# -*-makefile-*-
# $Id: penguzilla.make,v 1.1 2003/08/27 21:44:48 robert Exp $
#
# (c) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
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
PENGUZILLA_VERSION	= 0.3.1
PENGUZILLA		= penguzilla-$(PENGUZILLA_VERSION)
PENGUZILLA_SUFFIX	= tar.gz
PENGUZILLA_URL		= http://www.pengutronix.de/software/penguzilla/$(PENGUZILLA).$(PENGUZILLA_SUFFIX)
PENGUZILLA_SOURCE	= $(SRCDIR)/$(PENGUZILLA).$(PENGUZILLA_SUFFIX)
PENGUZILLA_DIR		= $(BUILDDIR)/$(PENGUZILLA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

penguzilla_get: $(STATEDIR)/penguzilla.get

penguzilla_get_deps	=  $(PENGUZILLA_SOURCE)

$(STATEDIR)/penguzilla.get: $(penguzilla_get_deps)
	@$(call targetinfo, penguzilla.get)
	touch $@

$(PENGUZILLA_SOURCE):
	@$(call targetinfo, $(PENGUZILLA_SOURCE))
	@$(call get, $(PENGUZILLA_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

penguzilla_extract: $(STATEDIR)/penguzilla.extract

penguzilla_extract_deps	=  $(STATEDIR)/penguzilla.get

$(STATEDIR)/penguzilla.extract: $(penguzilla_extract_deps)
	@$(call targetinfo, penguzilla.extract)
	@$(call clean, $(PENGUZILLA_DIR))
	@$(call extract, $(PENGUZILLA_SOURCE))
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
#	$(STATEDIR)/virtual-xchain.install

PENGUZILLA_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
PENGUZILLA_ENV 	=  $(CROSS_ENV)
#PENGUZILLA_ENV	+=


#
# autoconf
#
PENGUZILLA_AUTOCONF	=  --prefix=/usr
PENGUZILLA_AUTOCONF	+= --build=$(GNU_HOST)
PENGUZILLA_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

PENGUZILLA_AUTOCONF	+= --with-mozilla=$(MFIREBIRD_DIR)
PENGUZILLA_AUTOCONF	+= --with-gtk-prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

$(STATEDIR)/penguzilla.prepare: $(penguzilla_prepare_deps)
	@$(call targetinfo, penguzilla.prepare)
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
	@$(call targetinfo, penguzilla.compile)
	$(PENGUZILLA_PATH) $(PENGUZILLA_ENV) make -C $(PENGUZILLA_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

penguzilla_install: $(STATEDIR)/penguzilla.install

$(STATEDIR)/penguzilla.install: $(STATEDIR)/penguzilla.compile
	@$(call targetinfo, penguzilla.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

penguzilla_targetinstall: $(STATEDIR)/penguzilla.targetinstall

penguzilla_targetinstall_deps	=  $(STATEDIR)/penguzilla.compile

$(STATEDIR)/penguzilla.targetinstall: $(penguzilla_targetinstall_deps)
	@$(call targetinfo, penguzilla.targetinstall)

	# pixmap directory
	install -d $(ROOTDIR)/usr/share/penguzilla/pixmaps
	install $(PENGUZILLA_DIR)/pixmaps/* $(ROOTDIR)/usr/share/penguzilla/pixmaps

	install -d $(ROOTDIR)/usr/bin
	install $(PENGUZILLA_DIR)/src/penguzilla $(ROOTDIR)/usr/bin/
	
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

penguzilla_clean:
	rm -rf $(STATEDIR)/penguzilla.*
	rm -rf $(PENGUZILLA_DIR)

# vim: syntax=make
