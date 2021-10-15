#!/usr/bin/make -f

include /usr/share/cdbs/1/rules/debhelper.mk
include /usr/share/cdbs/1/class/makefile.mk

BITS := $(shell test `arch` = x86_64 && echo 64 || echo 32)
CC = $(shell which gcc-7 || which gcc)
CXX = $(shell which g++-7 || which g++)

DEB_SRCDIR = $(CURDIR)/fw

DEB_BUILD_OPTIONS = nocheck
DEB_MAKE_EXTRA_ARGS = BUILD_TYPE=r BUILD_CONFIG=Release

# no need to run clean
DEB_MAKE_CLEAN_TARGET	=
# For build and install, use newer targets when available, or continue using the previous targets
# if not.
DEB_MAKE_BUILD_TARGET   = $(shell grep --quiet build-package-for-deb $(DEB_SRCDIR)/Makefile && echo build-package-for-deb || echo Fw-build-package)
DEB_MAKE_INSTALL_TARGET = $(shell grep --quiet install-for-deb $(DEB_SRCDIR)/Makefile && echo install-for-deb || echo install-package) DESTDIR=$(DEB_DESTDIR)
# don't run tests
DEB_MAKE_CHECK_TARGET   =

DEB_SHLIBDEPS_INCLUDE = /usr/lib/fieldworks:/usr/lib/fieldworks/lib:/opt/mono5-sil/lib
DEB_DH_SHLIBDEPS_ARGS_ALL := -X/usr/lib/fieldworks/Firefox-Linux$(BITS)/
