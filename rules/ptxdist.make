# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PTXDIST) += ptxdist

#
# Paths and names
#
PTXDIST_VERSION	:= 1.99.20
PTXDIST		:= ptxdist-$(PTXDIST_VERSION)
PTXDIST_SUFFIX	:= tgz
PTXDIST_URL	:= http://www.pengutronix.de/software/ptxdist/download/v1.99/$(PTXDIST).$(PTXDIST_SUFFIX)
PTXDIST_P_URL	:= http://www.pengutronix.de/software/ptxdist/download/v1.99/$(PTXDIST)-patches.$(PTXDIST_SUFFIX)
PTXDIST_SOURCE	:= $(SRCDIR)/$(PTXDIST).$(PTXDIST_SUFFIX)
PTXDIST_P_SOURCE:= $(SRCDIR)/$(PTXDIST)-patches.$(PTXDIST_SUFFIX)
PTXDIST_DIR	:= $(BUILDDIR)/$(PTXDIST)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/ptxdist.get: $(PTXDIST_P_SOURCE)
	@$(call targetinfo)
	@$(call touch)

$(PTXDIST_SOURCE):
	@$(call targetinfo)
	@$(call get, PTXDIST)

$(PTXDIST_P_SOURCE):
	@$(call targetinfo)
	@$(call get, PTXDIST_P)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ptxdist.extract:
	@$(call targetinfo)
	@$(call clean, $(PTXDIST_DIR))
	@$(call extract, PTXDIST)
	cd $(BUILDDIR) && tar xf $(PTXDIST_P_SOURCE)
	@$(call patchin, PTXDIST)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PTXDIST_PATH	:= PATH=$(CROSS_PATH)
PTXDIST_ENV 	:= $(CROSS_ENV) CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX)

#
# autoconf
#
PTXDIST_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ptxdist.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ptxdist)
	@$(call install_fixup, ptxdist,PACKAGE,ptxdist)
	@$(call install_fixup, ptxdist,PRIORITY,optional)
	@$(call install_fixup, ptxdist,VERSION,$(PTXDIST_VERSION))
	@$(call install_fixup, ptxdist,SECTION,base)
	@$(call install_fixup, ptxdist,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ptxdist,DEPENDS,)
	@$(call install_fixup, ptxdist,DESCRIPTION,missing)

	$(call install_copy, ptxdist, 0, 0, 0755, \
		$(PKGDIR)/$(PTXDIST)/usr/lib/$(PTXDIST)/bin/ptxdist, \
		/usr/lib/$(PTXDIST)/bin/ptxdist, n)

	$(call install_link, ptxdist, \
		../lib/$(PTXDIST)/bin/ptxdist, \
		/usr/bin/ptxdist)

	$(call install_copy, ptxdist, 0, 0, 0644, \
		$(PKGDIR)/$(PTXDIST)/usr/lib/$(PTXDIST)/.done, \
		/usr/lib/$(PTXDIST)/.done, n)

	for i in `cd $(PKGDIR)/$(PTXDIST)/usr/lib/$(PTXDIST)/scripts; find . -type f`; do \
		$(call install_copy, ptxdist, 0, 0, 0755, \
			$(PKGDIR)/$(PTXDIST)/usr/lib/$(PTXDIST)/scripts/$$i, \
			/usr/lib/$(PTXDIST)/scripts/$$i); \
	done; \

	for j in patches config plugins generic rules; do \
		for i in `cd $(PKGDIR)/$(PTXDIST)/usr/lib/$(PTXDIST)/$$j; find . -type f`; do \
			$(call install_copy, ptxdist, 0, 0, 0644, \
				$(PKGDIR)/$(PTXDIST)/usr/lib/$(PTXDIST)/$$j/$$i, \
				/usr/lib/$(PTXDIST)/$$j/$$i); \
		done; \
	done

	@$(call install_finish, ptxdist)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ptxdist_clean:
	rm -rf $(STATEDIR)/ptxdist.*
	rm -rf $(PKGDIR)/ptxdist_*
	rm -rf $(PTXDIST_DIR)

# vim: syntax=make
