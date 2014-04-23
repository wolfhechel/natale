#!/bin/bash

set -o errexit	# Exit if error
set -o nounset	# Exit if variable not initalized
set +h		      # Disable hashall

shopt -s -o pipefail

# Clear directory stack
dirs -c

_run_directory=$(cd $(dirname $0); pwd)
_src_cache=${_run_directory}/src_cache

# Create source cache

if [ ! -d "${_src_cache}" ]; then
   mkdir "${_src_cache}"
fi

function cleanup {
  # Return to bottom of directory stack
  cd $(dirs -l -0; dirs -c)

  # Clean out all unpacked and build directories
  find -P "${_run_directory}" -maxdepth 1 -type d -not -samefile "${_run_directory}" -not -samefile "${_src_cache}" -exec rm -rf '{}' \;
}

trap cleanup EXIT

# Helper functions for stage-scripts

function validate_file() {
  file=$1
  md5=$2

  echo $md5 $file | md5sum -c &>/dev/null
}

function download_file() {
  local url=$1
  local md5=$2
  local filename=$(basename $url)

  if [ ! -f "${_src_cache}/$filename" ]; then
    echo "Downloading $filename"
    wget -P "${_src_cache}" $url --progress=dot
  fi

  if ! validate_file "${_src_cache}/$filename" $md5; then
    echo "File $filename appears to be corrupt, remove it and start build again."
    exit 2
  fi
}

function fetch() {
  local url=$1
  local md5=$2
  local filename=$(basename $url)

  download_file $url $md5

  pkgname=${filename%-*.tar.*}

  mkdir $pkgname

  echo "Unpacking ${filename}"
  tar -xf "${_src_cache}/$filename" --strip-components=1 -C $pkgname

  if [ "$#" -lt 3 ] || [ "$3" != "dl-only" ]; then
    pushd $pkgname &>/dev/null
  fi
}

# Configure build flags

MAKEFLAGS="-j"$(/usr/bin/getconf _NPROCESSORS_ONLN)

common_CFLAGS='-O2 -pipe'
common_CXXFLAGS='-O2 -pipe'

case $(uname -m) in
  i686)
    arch_CFLAGS="-march=i486 -mtune=i686"
    arch_CXXFLAGS="-march=i486 -mtune=i686"
  ;;
  x86_64)
    arch_CFLAGS="-march=x86-64 -mtune=generic"
    arch_CXXFLAGS="-march=x86-64 -mtune=generic"
  ;;
  *)
    echo "Unknown architecture, aborting"; exit 1
  ;;
esac

CFLAGS="${common_CFLAGS} ${arch_CFLAGS}"
CXXFLAGS="${common_CXXFLAGS} ${arch_CXXFLAGS}"

LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro"

export MAKEFLAGS CFLAGS CXXFLAGS LDFLAGS

(
  cd ${_run_directory};

  for step in [0-9]*-*.sh; do
    . $step

    cleanup
  done
)
