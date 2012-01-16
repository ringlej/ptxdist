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
HOST_PACKAGES-$(PTXCONF_HOST_TZ_DATABASE) += host-tz-database

#
# Paths and names
#
HOST_TZ_DATABASE	:= tz-database
HOST_TZ_DATABASE_DIR	:= $(HOST_BUILDDIR)/$(HOST_TZ_DATABASE)

TZCODE_VERSION		:= 2011i
TZCODE_MD5		:= cf7f4335b7c8682899fa2814e711c1b2
TZCODE			:= tzcode$(TZCODE_VERSION)
TZCODE_SUFFIX		:= tar.gz
TZCODE_URL		:= \
	ftp://elsie.nci.nih.gov/pub/$(TZCODE).$(TZCODE_SUFFIX) \
	ftp://munnari.oz.au/pub/oldtz/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_SOURCE		:= $(SRCDIR)/$(TZCODE).$(TZCODE_SUFFIX)
TZCODE_DIR		:= $(HOST_TZ_DATABASE_DIR)
TZCODE_STRIP_LEVEL	:= 0

TZDATA_VERSION		:= 2011n
TZDATA_MD5		:= 20dbfb28efa008ddbf6dd34601ea40fa
TZDATA			:= tzdata$(TZDATA_VERSION)
TZDATA_SUFFIX		:= tar.gz
TZDATA_URL		:= \
	ftp://elsie.nci.nih.gov/pub/$(TZDATA).$(TZDATA_SUFFIX) \
	ftp://munnari.oz.au/pub/oldtz/$(TZDATA).$(TZDATA_SUFFIX)
TZDATA_SOURCE		:= $(SRCDIR)/$(TZDATA).$(TZDATA_SUFFIX)
TZDATA_DIR		:= $(HOST_TZ_DATABASE_DIR)
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
	@$(call clean, $(HOST_TZ_DATABASE_DIR))
	@$(call extract, TZCODE)
	@$(call extract, TZDATA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TZ_DATABASE_PATH		:= PATH=$(HOST_PATH)
HOST_TZ_DATABASE_CONF_TOOL	:= NO
HOST_TZ_DATABASE_MAKE_OPT	:= \
	zic TZDIR=/usr/share/zoneinfo CFLAGS=-DSTD_INSPIRED
HOST_TZ_DATABASE_INSTALL_OPT	:= \
	posix_only TZDIR=$(HOST_TZ_DATABASE_PKGDIR)/usr/share/zoneinfo

# vim: syntax=make
