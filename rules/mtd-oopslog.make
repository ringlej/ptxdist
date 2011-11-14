# -*-makefile-*-
#
# Copyright (C) 2009 by Wolfram Sang
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MTD_OOPSLOG) += mtd-oopslog

#
# Paths and names
#
MTD_OOPSLOG_VERSION	:= 2007
MTD_OOPSLOG_MD5		:= d243a1d0efa3770ee2a6a498be6632e9
MTD_OOPSLOG		:= mtd-oopslog-$(MTD_OOPSLOG_VERSION)
MTD_OOPSLOG_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/oopslog.c
MTD_OOPSLOG_SOURCE	:= $(SRCDIR)/oopslog.c
MTD_OOPSLOG_DIR		:= $(BUILDDIR)/$(MTD_OOPSLOG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MTD_OOPSLOG_SOURCE):
	@$(call targetinfo)
	@$(call get, MTD_OOPSLOG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/mtd-oopslog.extract:
	@$(call targetinfo)
	mkdir -p $(MTD_OOPSLOG_DIR)
	cp $(MTD_OOPSLOG_SOURCE) $(MTD_OOPSLOG_DIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MTD_OOPSLOG_MAKE_ENV	:= $(CROSS_ENV)
MTD_OOPSLOG_MAKE_OPT	:= oopslog

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mtd-oopslog.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mtd-oopslog.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mtd-oopslog)
	@$(call install_fixup, mtd-oopslog,PRIORITY,optional)
	@$(call install_fixup, mtd-oopslog,SECTION,base)
	@$(call install_fixup, mtd-oopslog,AUTHOR,"Wolfram Sang")
	@$(call install_fixup, mtd-oopslog,DESCRIPTION,missing)

	@$(call install_copy, mtd-oopslog, 0, 0, 0755, $(MTD_OOPSLOG_DIR)/oopslog, /bin/oopslog)

	@$(call install_finish, mtd-oopslog)

	@$(call touch)

# vim: syntax=make
