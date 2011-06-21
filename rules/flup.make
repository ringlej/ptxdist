# -*-makefile-*-
#
# Copyright (C) 2011 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLUP) += flup

#
# Paths and names
#
FLUP_VERSION	:= 1.0.2
FLUP_MD5	:= 24dad7edc5ada31dddd49456ee8d5254
FLUP		:= flup-$(FLUP_VERSION)
FLUP_SUFFIX	:= tar.gz
FLUP_URL	:= http://www.saddi.com/software/flup/dist/$(FLUP).$(FLUP_SUFFIX)
FLUP_SOURCE	:= $(SRCDIR)/$(FLUP).$(FLUP_SUFFIX)
FLUP_DIR	:= $(BUILDDIR)/$(FLUP)
FLUP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FLUP_PATH	:= PATH=$(CROSS_PATH)
FLUP_CONF_ENV	:= $(CROSS_ENV)
FLUP_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/flup.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flup.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flup.targetinstall:
	@$(call targetinfo)

	@$(call install_init, flup)
	@$(call install_fixup, flup,PRIORITY,optional)
	@$(call install_fixup, flup,SECTION,base)
	@$(call install_fixup, flup,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, flup,DESCRIPTION,missing)

	for i in $(shell cd $(FLUP_DIR)/flup && find . -name "*.py"); do \
		$(call install_copy, flup, 0, 0, 0644, \
			$(FLUP_DIR)/flup/$$i, \
			$(PYTHON_SITEPACKAGES)/flup/$$i) \
	done

	@$(call install_finish, flup)

	@$(call touch)

# vim: syntax=make
