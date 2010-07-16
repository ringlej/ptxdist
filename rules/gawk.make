# -*-makefile-*-
#
# Copyright (C) 2003 by Ixia Corporation, By Milan Bobde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GAWK) += gawk

#
# Paths and names
#
GAWK_VERSION	:= 3.1.6
GAWK		:= gawk-$(GAWK_VERSION)
GAWK_SUFFIX	:= tar.gz
GAWK_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/gawk/$(GAWK).$(GAWK_SUFFIX)
GAWK_SOURCE	:= $(SRCDIR)/$(GAWK).$(GAWK_SUFFIX)
GAWK_DIR	:= $(BUILDDIR)/$(GAWK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GAWK_SOURCE):
	@$(call targetinfo)
	@$(call get, GAWK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GAWK_PATH	:= PATH=$(CROSS_PATH)
GAWK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GAWK_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gawk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gawk)
	@$(call install_fixup, gawk,PRIORITY,optional)
	@$(call install_fixup, gawk,SECTION,base)
	@$(call install_fixup, gawk,AUTHOR,"Carsten Schlote <schlote@konzeptpark.de>")
	@$(call install_fixup, gawk,DESCRIPTION,missing)

	@$(call install_copy, gawk, 0, 0, 0755, -, /usr/bin/gawk)
	@$(call install_link, gawk, gawk, /usr/bin/awk)

ifdef PTXCONF_GAWK_PGAWK
	@$(call install_copy, gawk, 0, 0, 0755, -, /usr/bin/pgawk)
endif

ifdef PTXCONF_GAWK_AWKLIB
	@$(call install_copy, gawk, 0, 0, 0755, -, /usr/bin/igawk)
	@$(call install_copy, gawk, 0, 0, 0755, -, /usr/libexec/awk/pwcat)
	@$(call install_copy, gawk, 0, 0, 0755, -, /usr/libexec/awk/grcat)
endif

	@$(call install_finish, gawk)

	@$(call touch)

# vim: syntax=make
