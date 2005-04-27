# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_PENGUZILLA
PACKAGES += penguzilla
endif

#
# Paths and names
#
PENGUZILLA_VERSION	= 0.4.0
PENGUZILLA		= penguzilla-$(PENGUZILLA_VERSION)
PENGUZILLA_SUFFIX	= tar.gz
PENGUZILLA_URL		= http://metis.pengutronix.de/$(PENGUZILLA).$(PENGUZILLA_SUFFIX)
PENGUZILLA_SOURCE	= $(SRCDIR)/$(PENGUZILLA).$(PENGUZILLA_SUFFIX)
PENGUZILLA_DIR		= $(BUILDDIR)/$(PENGUZILLA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

penguzilla_get: $(STATEDIR)/penguzilla.get

penguzilla_get_deps	=  $(PENGUZILLA_SOURCE)

$(STATEDIR)/penguzilla.get: $(penguzilla_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(PENGUZILLA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PENGUZILLA_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

penguzilla_extract: $(STATEDIR)/penguzilla.extract

penguzilla_extract_deps	=  $(STATEDIR)/penguzilla.get

$(STATEDIR)/penguzilla.extract: $(penguzilla_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PENGUZILLA_DIR))
	@$(call extract, $(PENGUZILLA_SOURCE))
	@$(call patchin, $(PENGUZILLA))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

penguzilla_prepare: $(STATEDIR)/penguzilla.prepare

#
# dependencies
#
penguzilla_prepare_deps =  \
	$(STATEDIR)/penguzilla.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/mfirebird.install \
	$(STATEDIR)/gail.install \
	$(STATEDIR)/libxml2.install

PENGUZILLA_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
PENGUZILLA_ENV 	=  $(CROSS_ENV)
PENGUZILLA_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/


#
# autoconf
#
PENGUZILLA_AUTOCONF	=  $(CROSS_AUTOCONF)
PENGUZILLA_AUTOCONF	+= --prefix=/usr

PENGUZILLA_AUTOCONF	+= --with-mozilla=$(MFIREBIRD_DIR)
PENGUZILLA_AUTOCONF	+= --with-gtk-prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

$(STATEDIR)/penguzilla.prepare: $(penguzilla_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PENGUZILLA_BUILDDIR))
	cd $(PENGUZILLA_DIR) && \
		$(PENGUZILLA_PATH) $(PENGUZILLA_ENV) \
		./configure $(PENGUZILLA_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

penguzilla_compile: $(STATEDIR)/penguzilla.compile

penguzilla_compile_deps =  $(STATEDIR)/penguzilla.prepare

$(STATEDIR)/penguzilla.compile: $(penguzilla_compile_deps)
	@$(call targetinfo, $@)
	$(PENGUZILLA_PATH) $(PENGUZILLA_ENV) make -C $(PENGUZILLA_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

penguzilla_install: $(STATEDIR)/penguzilla.install

$(STATEDIR)/penguzilla.install: $(STATEDIR)/penguzilla.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

penguzilla_targetinstall: $(STATEDIR)/penguzilla.targetinstall

penguzilla_targetinstall_deps =	\
	$(STATEDIR)/penguzilla.compile	\
	$(STATEDIR)/gtk2-engines.targetinstall \
	$(STATEDIR)/gail.targetinstall \
	$(STATEDIR)/libxml2.targetinstall

$(STATEDIR)/penguzilla.targetinstall: $(penguzilla_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,penguzilla)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PENGUZILLA_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

# 	# pixmap directory
	for file in $(PENGUZILLA_DIR)/pixmaps/*; do 						\
		$(call install_copy, 0, 0, 0644, $$file, /usr/share/penguzilla/pixmaps/)	\
	done

	@$(call install_copy, 0, 0, 0755, $(PENGUZILLA_DIR)/src/penguzilla, /usr/bin/penguzilla)

# 	# Style
	@$(call install_copy, 0, 0, 0644, $(PENGUZILLA_DIR)/penguzilla.rc, /usr/share/penguzilla/penguzillarc, n)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

penguzilla_clean:
	rm -rf $(STATEDIR)/penguzilla.*
	rm -rf $(IMAGEDIR)/penguzilla_*
	rm -rf $(PENGUZILLA_DIR)

# vim: syntax=make
