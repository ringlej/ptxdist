# -*-makefile-*-
# $Id: gtk22.make,v 1.1 2003/08/13 12:04:17 robert Exp $
#
# (c) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GTK22
PACKAGES += gtk22
endif

#
# Paths and names
#
GTK22_VERSION		= 2.2.2
GTK22			= gtk+-$(GTK22_VERSION)
GTK22_SUFFIX		= tar.gz
GTK22_URL		= ftp://ftp.gtk.org/pub/gtk/v2.2/$(GTK22).$(GTK22_SUFFIX)
GTK22_SOURCE		= $(SRCDIR)/$(GTK22).$(GTK22_SUFFIX)
GTK22_DIR		= $(BUILDDIR)/$(GTK22)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk22_get: $(STATEDIR)/gtk22.get

gtk22_get_deps	=  $(GTK22_SOURCE)

$(STATEDIR)/gtk22.get: $(gtk22_get_deps)
	@$(call targetinfo, gtk22.get)
	touch $@

$(GTK22_SOURCE):
	@$(call targetinfo, $(GTK22_SOURCE))
	@$(call get, $(GTK22_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk22_extract: $(STATEDIR)/gtk22.extract

gtk22_extract_deps	=  $(STATEDIR)/gtk22.get

$(STATEDIR)/gtk22.extract: $(gtk22_extract_deps)
	@$(call targetinfo, gtk22.extract)
	@$(call clean, $(GTK22_DIR))
	@$(call extract, $(GTK22_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk22_prepare: $(STATEDIR)/gtk22.prepare

#
# dependencies
#
gtk22_prepare_deps =  \
	$(STATEDIR)/gtk22.extract \
#	$(STATEDIR)/virtual-xchain.install

GTK22_PATH	=  PATH=$(CROSS_PATH)
GTK22_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
GTK22_AUTOCONF	=  --prefix=/usr
GTK22_AUTOCONF	+= --build=$(GNU_HOST)
GTK22_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

ifdef PTXCONF_GTK22_FOO
GTK22_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/gtk22.prepare: $(gtk22_prepare_deps)
	@$(call targetinfo, gtk22.prepare)
	@$(call clean, $(GTK22_BUILDDIR))
	cd $(GTK22_DIR) && \
		$(GTK22_PATH) $(GTK22_ENV) \
		$(GTK22_DIR)/configure $(GTK22_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk22_compile: $(STATEDIR)/gtk22.compile

gtk22_compile_deps =  $(STATEDIR)/gtk22.prepare

$(STATEDIR)/gtk22.compile: $(gtk22_compile_deps)
	@$(call targetinfo, gtk22.compile)
	$(GTK22_PATH) make -C $(GTK22_DIR) gtk22
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk22_install: $(STATEDIR)/gtk22.install

$(STATEDIR)/gtk22.install: $(STATEDIR)/gtk22.compile
	@$(call targetinfo, gtk22.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk22_targetinstall: $(STATEDIR)/gtk22.targetinstall

gtk22_targetinstall_deps	=  $(STATEDIR)/gtk22.compile

$(STATEDIR)/gtk22.targetinstall: $(gtk22_targetinstall_deps)
	@$(call targetinfo, gtk22.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk22_clean:
	rm -rf $(STATEDIR)/gtk22.*
	rm -rf $(GTK22_DIR)

# vim: syntax=make
