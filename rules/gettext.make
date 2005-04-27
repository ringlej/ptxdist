# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GETTEXT
PACKAGES += gettext
endif

#
# Paths and names
#
GETTEXT_VERSION		= 0.13
GETTEXT			= gettext-$(GETTEXT_VERSION)
GETTEXT_SUFFIX		= tar.gz
GETTEXT_URL		= $(PTXCONF_SETUP_GNUMIRROR)/gettext/$(GETTEXT).$(GETTEXT_SUFFIX)
GETTEXT_SOURCE		= $(SRCDIR)/$(GETTEXT).$(GETTEXT_SUFFIX)
GETTEXT_DIR		= $(BUILDDIR)/$(GETTEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gettext_get: $(STATEDIR)/gettext.get

gettext_get_deps = $(GETTEXT_SOURCE)

$(STATEDIR)/gettext.get: $(gettext_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(GETTEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GETTEXT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gettext_extract: $(STATEDIR)/gettext.extract

gettext_extract_deps = $(STATEDIR)/gettext.get

$(STATEDIR)/gettext.extract: $(gettext_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GETTEXT_DIR))
	@$(call extract, $(GETTEXT_SOURCE))
	@$(call patchin, $(GETTEXT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gettext_prepare: $(STATEDIR)/gettext.prepare

#
# dependencies
#
gettext_prepare_deps =  \
	$(STATEDIR)/gettext.extract \
	$(STATEDIR)/virtual-xchain.install

GETTEXT_PATH	=  PATH=$(CROSS_PATH)
GETTEXT_ENV 	=  $(CROSS_ENV)

#
# autoconf
#

GETTEXT_AUTOCONF =  $(CROSS_AUTOCONF)
GETTEXT_AUTOCONF +=  --prefix=/usr

# This is braindead but correct :-) 
GETTEXT_AUTOCONF	+= --disable-nls

$(STATEDIR)/gettext.prepare: $(gettext_prepare_deps)
	@$(call targetinfo, $@)
	cd $(GETTEXT_DIR) && \
		$(GETTEXT_PATH) $(GETTEXT_ENV) \
		./configure $(GETTEXT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gettext_compile: $(STATEDIR)/gettext.compile

gettext_compile_deps = $(STATEDIR)/gettext.prepare

$(STATEDIR)/gettext.compile: $(gettext_compile_deps)
	@$(call targetinfo, $@)
	$(GETTEXT_PATH) make -C $(GETTEXT_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gettext_install: $(STATEDIR)/gettext.install

$(STATEDIR)/gettext.install: $(STATEDIR)/gettext.compile
	@$(call targetinfo, $@)
	install -d $(PTXCONF_PREFIX)/lib
	rm -f $(PTXCONF_PREFIX)/lib/libgnuintl.so*
	install $(GETTEXT_DIR)/gettext-runtime/intl/.libs/libgnuintl.so* $(PTXCONF_PREFIX)/lib/
#	ln -s $(PTXCONF_PREFIX)/lib/libgnuintl.so* $(PTXCONF_PREFIX)/lib/libgnuintl.so.2 
#	ln -s $(PTXCONF_PREFIX)/lib/libgnuintl.so.2 $(PTXCONF_PREFIX)/lib/libgnuintl.so 
	install $(GETTEXT_DIR)/gettext-runtime/intl/libgnuintl.h $(PTXCONF_PREFIX)/include
	install $(GETTEXT_DIR)/gettext-tools/src/msgfmt $(PTXCONF_PREFIX)/bin
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gettext_targetinstall: $(STATEDIR)/gettext.targetinstall

gettext_targetinstall_deps = $(STATEDIR)/gettext.compile

$(STATEDIR)/gettext.targetinstall: $(gettext_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gettext)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GETTEXT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)
	
	# FIXME: RSC: do wildcards work? 
	@$(call install_copy, 0, 0, 0644, $(GETTEXT_DIR)/gettext-runtime/intl/.libs/libgnuintl.so.*, /usr/lib/)
	@$(call install_link, libgnuintl.so.*, /lib/libgnuintl.so.2)
	@$(call install_link, libgnuintl.so.*, /lib/libgnuintl.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gettext_clean:
	rm -rf $(STATEDIR)/gettext.*
	rm -rf $(IMAGEDIR)/gettext_*
	rm -rf $(GETTEXT_DIR)

# vim: syntax=make
