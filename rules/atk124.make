# -*-makefile-*-
# $Id: atk124.make,v 1.1 2003/08/13 12:04:17 robert Exp $
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
ifdef PTXCONF_ATK124
PACKAGES += atk124
endif

#
# Paths and names
#
ATK124_VERSION		= 1.2.4
ATK124			= atk-$(ATK124_VERSION)
ATK124_SUFFIX		= tar.gz
ATK124_URL		= ftp://ftp.gtk.org/pub/gtk/v2.2/$(ATK124).$(ATK124_SUFFIX)
ATK124_SOURCE		= $(SRCDIR)/$(ATK124).$(ATK124_SUFFIX)
ATK124_DIR		= $(BUILDDIR)/$(ATK124)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

atk124_get: $(STATEDIR)/atk124.get

atk124_get_deps	=  $(ATK124_SOURCE)

$(STATEDIR)/atk124.get: $(atk124_get_deps)
	@$(call targetinfo, atk124.get)
	touch $@

$(ATK124_SOURCE):
	@$(call targetinfo, $(ATK124_SOURCE))
	@$(call get, $(ATK124_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

atk124_extract: $(STATEDIR)/atk124.extract

atk124_extract_deps	=  $(STATEDIR)/atk124.get

$(STATEDIR)/atk124.extract: $(atk124_extract_deps)
	@$(call targetinfo, atk124.extract)
	@$(call clean, $(ATK124_DIR))
	@$(call extract, $(ATK124_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

atk124_prepare: $(STATEDIR)/atk124.prepare

#
# dependencies
#
atk124_prepare_deps =  \
	$(STATEDIR)/atk124.extract \
#	$(STATEDIR)/virtual-xchain.install

ATK124_PATH	=  PATH=$(CROSS_PATH)
ATK124_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
ATK124_AUTOCONF	=  --prefix=/usr
ATK124_AUTOCONF	+= --build=$(GNU_HOST)
ATK124_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

ifdef PTXCONF_ATK124_FOO
ATK124_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/atk124.prepare: $(atk124_prepare_deps)
	@$(call targetinfo, atk124.prepare)
	@$(call clean, $(ATK124_BUILDDIR))
	cd $(ATK124_DIR) && \
		$(ATK124_PATH) $(ATK124_ENV) \
		$(ATK124_DIR)/configure $(ATK124_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

atk124_compile: $(STATEDIR)/atk124.compile

atk124_compile_deps =  $(STATEDIR)/atk124.prepare

$(STATEDIR)/atk124.compile: $(atk124_compile_deps)
	@$(call targetinfo, atk124.compile)
	$(ATK124_PATH) make -C $(ATK124_DIR) 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

atk124_install: $(STATEDIR)/atk124.install

$(STATEDIR)/atk124.install: $(STATEDIR)/atk124.compile
	@$(call targetinfo, atk124.install)
	install -d $(PTXCONF_PREFIX)
	rm -f $(PTXCONF_PREFIX)/lib/libatk-1.0.so*
	install $(ATK124_DIR)/atk/.libs/libatk-1.0.so.0.200.4 $(PTXCONF_PREFIX)/lib/
	ln -s libatk-1.0.so.0.200.4 $(PTXCONF_PREFIX)/lib/libatk-1.0.so.0
	ln -s libatk-1.0.so.0.200.4 $(PTXCONF_PREFIX)/lib/libatk-1.0.so
	rm -f $(PTXCONF_PREFIX)/include/atk*.h
	install $(ATK124_DIR)/atk/atk*.h $(PTXCONF_PREFIX)/include
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

atk124_targetinstall: $(STATEDIR)/atk124.targetinstall

atk124_targetinstall_deps	=  $(STATEDIR)/atk124.compile

$(STATEDIR)/atk124.targetinstall: $(atk124_targetinstall_deps)
	@$(call targetinfo, atk124.targetinstall)
	install -d $(ROOTDIR)
	rm -f $(ROOTDIR)/lib/libatk-1.0.so*
	install $(ATK124_DIR)/atk/.libs/libatk-1.0.so.0.200.4 $(ROOTDIR)/lib/
	ln -s libatk-1.0.so.0.200.4 $(ROOTDIR)/lib/libatk-1.0.so.0
	ln -s libatk-1.0.so.0.200.4 $(ROOTDIR)/lib/libatk-1.0.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

atk124_clean:
	rm -rf $(STATEDIR)/atk124.*
	rm -rf $(ATK124_DIR)

# vim: syntax=make
