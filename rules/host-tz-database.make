# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_TZDATABASE) += host-tz-database

#
# Paths and names
#
HOST_TZDATABASE		:= tz-database
HOST_TZDATABASE_DIR	:= $(HOST_BUILDDIR)/$(HOST_TZDATABASE)

TZCODE_VERSION		:= 2010f
TZCODE_MD5		:=
TZCODE			:= tzcode$(TZCODE_VERSION)
TZCODE_SUFFIX		:= tar.gz
TZCODE_URL		:= \
	ftp://elsie.nci.nih.gov/pub/$(TZCODE).$(TZCODE_SUFFIX) \
	ftp://munnari.oz.au/pub/oldtz/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_SOURCE		:= $(SRCDIR)/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_DIR		:= $(HOST_TZDATABASE_DIR)
TZCODE_STRIP_LEVEL	:= 0

TZDATA_VERSION		:= 2010h
TZCODE_MD5		:=
TZDATA			:= tzdata$(TZDATA_VERSION)
TZDATA_SUFFIX		:= tar.gz
TZDATA_URL		:= \
	ftp://elsie.nci.nih.gov/pub/$(TZDATA).$(TZDATA_SUFFIX) \
	ftp://munnari.oz.au/pub/oldtz/$(TZDATA).$(TZDATA_SUFFIX)
TZDATA_SOURCE		:= $(SRCDIR)/$(TZDATA).$(TZDATA_SUFFIX)
TZDATA_DIR		:= $(HOST_TZDATABASE_DIR)
TZDATA_STRIP_LEVEL	:= 0

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------
$(TZCODE_SOURCE):
	@$(call get, TZCODE)

$(TZDATA_SOURCE):
	@$(call get, TZDATA)

$(STATEDIR)/host-tz-database.get: $(TZCODE_SOURCE) $(TZDATA_SOURCE)
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-tz-database.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_TZDATABASE_DIR))
	@$(call extract, TZCODE)
	@$(call extract, TZDATA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TZDATABASE_PATH		:= PATH=$(HOST_PATH)
HOST_TZDATABASE_CONF_TOOL	:= NO
HOST_TZDATABASE_MAKE_OPT	:= \
	posix_only TZDIR=$(PTXDIST_SYSROOT_HOST)/usr/share/zoneinfo

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-tz-database.install:
	$(call targetinfo)
	$(call touch)

# vim: syntax=make
