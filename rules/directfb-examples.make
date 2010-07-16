# -*-makefile-*-
#
# Copyright (C) 2007-2008, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIRECTFB_EXAMPLES) += directfb-examples

#
# Paths and names
#
DIRECTFB_EXAMPLES_VERSION	:= 1.2.0
DIRECTFB_EXAMPLES		:= DirectFB-examples-$(DIRECTFB_EXAMPLES_VERSION)
DIRECTFB_EXAMPLES_SUFFIX	:= tar.gz
DIRECTFB_EXAMPLES_SOURCE	:= $(SRCDIR)/$(DIRECTFB_EXAMPLES).$(DIRECTFB_EXAMPLES_SUFFIX)
DIRECTFB_EXAMPLES_DIR		:= $(BUILDDIR)/$(DIRECTFB_EXAMPLES)

DIRECTFB_EXAMPLES_URL := \
	http://www.directfb.org/downloads/Extras/$(DIRECTFB_EXAMPLES).$(DIRECTFB_EXAMPLES_SUFFIX) \
	http://www.directfb.org/downloads/Old/$(DIRECTFB_EXAMPLES).$(DIRECTFB_EXAMPLES_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DIRECTFB_EXAMPLES_SOURCE):
	@$(call targetinfo)
	@$(call get, DIRECTFB_EXAMPLES)


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/directfb-examples.extract:
	@$(call targetinfo)
	@$(call clean, $(DIRECTFB_EXAMPLES_DIR))
	@$(call extract, DIRECTFB_EXAMPLES)
	@$(call patchin, DIRECTFB_EXAMPLES)
	@cp $(DIRECTFB_EXAMPLES_DIR)/patches/ptx_logo_640_480.png $(DIRECTFB_EXAMPLES_DIR)/data
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DIRECTFB_EXAMPLES_PATH	:= PATH=$(CROSS_PATH)
DIRECTFB_EXAMPLES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DIRECTFB_EXAMPLES_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/directfb-examples.targetinstall:
	@$(call targetinfo)

	@$(call install_init, directfb-examples)
	@$(call install_fixup, directfb-examples,PRIORITY,optional)
	@$(call install_fixup, directfb-examples,SECTION,base)
	@$(call install_fixup, directfb-examples,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, directfb-examples,DESCRIPTION,missing)

# installs the binaries
	@cd $(DIRECTFB_EXAMPLES_PKGDIR)/usr/bin && \
	find . -perm /u+x -type f | \
		while read file; do \
		$(call install_copy, directfb-examples, 0, 0, 0755, -, \
			/usr/bin/$${file##*/} \
		) \
	done

# install the datafiles
	@cd $(DIRECTFB_EXAMPLES_PKGDIR)/usr/share/directfb-examples && \
	find . -type f | \
		while read file; do \
		$(call install_copy, directfb-examples, 0, 0, 0644, -, \
			/usr/share/directfb-examples/$${file##./}, n \
		) \
	done

	@$(call install_finish,directfb-examples)

	@$(call touch)

# vim: syntax=make
