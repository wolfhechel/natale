@include

<interface>autotools {

}

<package, @using autotools>linux-headers = {
  summary = Linux API Headers
  version = 3.14.2
  license = GPLv2
  sources = [
    http://www.kernel.org/pub/linux/kernel/v3.x/linux-%version%.tar.xz
  ]

  description = The Linux API Headers expose the kernel's API for use by Glibc.

  configuration = {
    enable-shared,
    disable-multilib
  }
}

package linux-headers autotools
(Summary: Linux API headers)
{

  build `exec`{

  }
}

Summary:	Linux API headers
Name:		linux-headers
Version:	3.14.2
Release:	1
License:	GPLv2
URL:		http://www.kernel.org/
Group:		System Environment/Kernel
Source0:	http://www.kernel.org/pub/linux/kernel/v3.x/linux-%{version}.tar.xz
BuildArch:	noarch

%description
The Linux API Headers expose the kernel's API for use by Glibc.

%prep
tar xf %{SOURCE0}

%build
cd %{_builddir}/linux-%{version}
make mrproper
make headers_check

%install
[ %{buildroot} != "/"] && rm -rf %{buildroot}/*
cd %{_builddir}/linux-%{version}
rm -rf %{buildroot}/*
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
install -vdm 755 %{buildroot}%{_includedir}
cp -rv dest/include/* %{buildroot}%{_includedir}

%clean
rm -rf %{buildroot} %{_builddir}/*

%files

%defattr(-,root,root)
%{_includedir}/*

%changelog
*	Sun Apr 27 2014 Pontus Karlsson <jonet@okuejina.net> 3.14.2-1
-	Initial build.	First version
