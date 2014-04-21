#!/bin/bash

set -o errexit	# exit if error
set -o nounset	# exit if variable not initalized
set +h		# disable hashall
shopt -s -o pipefail

sleep 5

_run_directory=$PWD
_src_cache=$PWD/src_cache

if [ ! -d "${_src_cache}" ]; then
   mkdir "${_src_cache}"
fi

function cleanup {
  find -P "${_run_directory}" -maxdepth 1 -type d -not -samefile "${_run_directory}" -not -samefile "${_src_cache}" -exec rm -rf '{}' \;
}

trap cleanup EXIT

function validate_file() {
  file=$1
  md5=$2

  echo $md5 $file | md5sum -c &>/dev/null
}

function download_file() {
  local url=$1
  local filename=$(basename $url)

  if [ ! -f "${_src_cache}/$filename" ]; then
    echo "Downloading $filename"

    (cd "${_src_cache}"; curl -L -O $url)
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

  download_file $url

  pkgname=${filename%-*.tar.*}

  mkdir $pkgname

  tar -xvf "${_src_cache}/$filename" --strip-components=1 -C $pkgname

  if [ "$#" -lt 3 ] || [ "$3" != "dl-only" ]; then
    cd $pkgname
  fi
}
