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

TZCODE_VERSION		:= 2011i
TZCODE_MD5		:= cf7f4335b7c8682899fa2814e711c1b2
TZCODE			:= tzcode$(TZCODE_VERSION)
TZCODE_SUFFIX		:= tar.gz
TZCODE_URL		:= \
	ftp://elsie.nci.nih.gov/pub/$(TZCODE).$(TZCODE_SUFFIX) \
	ftp://munnari.oz.au/pub/oldtz/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_SOURCE		:= $(SRCDIR)/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_DIR		:= $(HOST_TZDATABASE_DIR)
TZCODE_STRIP_LEVEL	:= 0

TZDATA_VERSION		:= 2011i
TZDATA_MD5		:= c7a86ec34f30f8d6aa77ef94902a3047
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
	@$(call check_src, TZCODE)
	@$(call check_src, TZDATA)
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
	zic TZDIR=/usr/share/zoneinfo
HOST_TZDATABASE_INSTALL_OPT	:= \
	posix_only TZDIR=$(HOST_TZDATABASE_PKGDIR)/usr/share/zoneinfo

# vim: syntax=make
