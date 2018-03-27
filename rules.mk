#!/usr/bin/make -f

include /usr/share/cdbs/1/rules/debhelper.mk
include /usr/share/cdbs/1/class/makefile.mk

BITS := $(shell test `arch` = x86_64 && echo 64 || echo 32)

DEB_SRCDIR = $(CURDIR)/fw

DEB_BUILD_OPTIONS = nocheck
DEB_MAKE_EXTRA_ARGS = BUILD_TYPE=r BUILD_CONFIG=Release

# no need to run clean
DEB_MAKE_CLEAN_TARGET	=
DEB_MAKE_BUILD_TARGET   = Fw-build-package
DEB_MAKE_INSTALL_TARGET = install-package DESTDIR=$(DEB_DESTDIR)
# don't run tests
DEB_MAKE_CHECK_TARGET   =

DEB_DH_STRIP_ARGS = -k
DEB_SHLIBDEPS_INCLUDE = /usr/lib/fieldworks
DEB_DH_MAKESHLIBS_ARGS_ALL = -X/usr/lib/fieldworks/
DEB_DH_SHLIBDEPS_ARGS_ALL = -X/usr/lib/fieldworks/Firefox-Linux$(BITS)/
