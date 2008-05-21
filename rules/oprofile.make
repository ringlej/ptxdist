# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003      by Benedikt Spranger <b.spranger@pengutronix.de>
# Copyright (C) 2003      by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2003-2008 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPROFILE) += oprofile

#
# Paths and names
#
OPROFILE_VERSION	:= 0.9.3
OPROFILE		:= oprofile-$(OPROFILE_VERSION)
OPROFILE_SUFFIX		:= tar.gz
OPROFILE_URL		:= $(PTXCONF_SETUP_SFMIRROR)/oprofile/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_SOURCE		:= $(SRCDIR)/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_DIR		:= $(BUILDDIR)/$(OPROFILE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(OPROFILE_SOURCE):
	@$(call targetinfo)
	@$(call get, OPROFILE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPROFILE_PATH	:= PATH=$(CROSS_PATH)
OPROFILE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
OPROFILE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-kernel-support \
	--without-x

$(STATEDIR)/oprofile.prepare:
	@$(call targetinfo)
	@$(call clean, $(OPROFILE_DIR)/config.cache)
	cd $(OPROFILE_DIR) && \
		$(OPROFILE_PATH) $(OPROFILE_ENV) \
		./configure $(OPROFILE_AUTOCONF) --with-linux=$(KERNEL_DIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/oprofile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, oprofile)
	@$(call install_fixup, oprofile,PACKAGE,oprofile)
	@$(call install_fixup, oprofile,PRIORITY,optional)
	@$(call install_fixup, oprofile,VERSION,$(OPROFILE_VERSION))
	@$(call install_fixup, oprofile,SECTION,base)
	@$(call install_fixup, oprofile,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, oprofile,DEPENDS,)
	@$(call install_fixup, oprofile,DESCRIPTION,missing)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/utils/opcontrol, \
		/usr/bin/opcontrol, 0 \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/utils/ophelp, \
		/usr/bin/ophelp \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/pp/opreport, \
		/usr/bin/opreport \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/daemon/oprofiled, \
		/usr/bin/oprofiled \
	)

	@cd $(OPROFILE_DIR)/events && \
	find . \
		-name "events" -o -name "unit_masks" | \
		while read file; do \
		$(call install_copy, oprofile, 0, 0, 0755, \
			$(OPROFILE_DIR)/events/$$file, \
			/usr/share/oprofile/$$file, 0 \
		) \
	done

	@$(call install_finish, oprofile)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

oprofile_clean:
	rm -rf $(STATEDIR)/oprofile.*
	rm -rf $(IMAGEDIR)/oprofile_*
	rm -rf $(OPROFILE_DIR)

# vim: syntax=make
