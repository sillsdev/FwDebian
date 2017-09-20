#!/usr/bin/make -f

include /usr/share/cdbs/1/rules/debhelper.mk
include /usr/share/cdbs/1/class/makefile.mk

DEB_SRCDIR = $(CURDIR)/fw

DEB_BUILD_OPTIONS = nocheck
DEB_MAKE_EXTRA_ARGS = BUILD_TYPE=r BUILD_CONFIG=Release

# no need to run clean
DEB_MAKE_CLEAN_TARGET	=
DEB_MAKE_BUILD_TARGET   = Fw-build-package
DEB_MAKE_INSTALL_TARGET = install-package DESTDIR=$(DEB_DESTDIR)
# don't run tests
DEB_MAKE_CHECK_TARGET   =

DEB_SHLIBDEPS_INCLUDE = /usr/lib/fieldworks:/usr/lib/fieldworks/lib
DEB_DH_SHLIBDEPS_ARGS_ALL = -X/usr/lib/fieldworks/Firefox/
