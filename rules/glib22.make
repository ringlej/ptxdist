# -*-makefile-*-
# $Id: glib22.make,v 1.3 2003/08/15 00:33:35 robert Exp $
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
ifdef PTXCONF_GLIB22
PACKAGES += glib22
endif

#
# Paths and names
#
GLIB22_VERSION		= 2.2.2
GLIB22			= glib-$(GLIB22_VERSION)
GLIB22_SUFFIX		= tar.gz
GLIB22_URL		= ftp://ftp.gtk.org/pub/gtk/v2.2/$(GLIB22).$(GLIB22_SUFFIX)
GLIB22_SOURCE		= $(SRCDIR)/$(GLIB22).$(GLIB22_SUFFIX)
GLIB22_DIR		= $(BUILDDIR)/$(GLIB22)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glib22_get: $(STATEDIR)/glib22.get

glib22_get_deps	=  $(GLIB22_SOURCE)

$(STATEDIR)/glib22.get: $(glib22_get_deps)
	@$(call targetinfo, glib22.get)
	touch $@

$(GLIB22_SOURCE):
	@$(call targetinfo, $(GLIB22_SOURCE))
	@$(call get, $(GLIB22_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glib22_extract: $(STATEDIR)/glib22.extract

glib22_extract_deps	=  $(STATEDIR)/glib22.get

$(STATEDIR)/glib22.extract: $(glib22_extract_deps)
	@$(call targetinfo, glib22.extract)
	@$(call clean, $(GLIB22_DIR))
	@$(call extract, $(GLIB22_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glib22_prepare: $(STATEDIR)/glib22.prepare

#
# dependencies
#
glib22_prepare_deps =  \
	$(STATEDIR)/glib22.extract \
#	$(STATEDIR)/virtual-xchain.install

GLIB22_PATH	=  PATH=$(CROSS_PATH)
GLIB22_ENV 	=  $(CROSS_ENV)
GLIB22_ENV	+= PKG_CONFIG_PATH=$(GLIB22_DIR):$(PANGO12_DIR):$(ATK124_DIR):$(GTK22_DIR)
GLIB22_ENV	+= PKG_CONFIG_TOP_BUILD_DIR=$(PTXCONF_PREFIX)

GLIB22_ENV	+= glib_cv_use_pid_surrogate=no
GLIB22_ENV	+= ac_cv_func_posix_getpwuid_r=yes 
ifeq (y, $G(PTXCONF_GLIBC_DL))
GLIB22_ENV	+= glib_cv_uscore=yes
else
GLIB22_ENV	+= glib_cv_uscore=no
endif
GLIB22_ENV	+= glib_cv_stack_grows=no

#
# autoconf
#
GLIB22_AUTOCONF	=  --prefix=/usr
GLIB22_AUTOCONF	+= --build=$(GNU_HOST)
GLIB22_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

GLIB22_AUTOCONF	+= --with-threads=posix

$(STATEDIR)/glib22.prepare: $(glib22_prepare_deps)
	@$(call targetinfo, glib22.prepare)
	@$(call clean, $(GLIB22_BUILDDIR))
	cd $(GLIB22_DIR) && \
		$(GLIB22_PATH) $(GLIB22_ENV) \
		$(GLIB22_DIR)/configure $(GLIB22_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glib22_compile: $(STATEDIR)/glib22.compile

glib22_compile_deps =  $(STATEDIR)/glib22.prepare

$(STATEDIR)/glib22.compile: $(glib22_compile_deps)
	@$(call targetinfo, glib22.compile)
	$(GLIB22_PATH) make -C $(GLIB22_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glib22_install: $(STATEDIR)/glib22.install

$(STATEDIR)/glib22.install: $(STATEDIR)/glib22.compile
	@$(call targetinfo, glib22.install)
	install -d $(PTXCONF_PREFIX)
	rm -f $(PTXCONF_PREFIX)/lib/libglib-2.0.so*
	install $(ATK124_DIR)/atk/.libs/libglib-2.0.so.0.200.2 $(PTXCONF_PREFIX)/lib/
	ln -s libglib-2.0.so.0.200.2 $(PTXCONF_PREFIX)/lib/libglib-2.0.so.0
	ln -s libglib-2.0.so.0.200.2 $(PTXCONF_PREFIX)/lib/libglib-2.0.so
	rm -f $(PTXCONF_PREFIX)/include/gtk*.h
	install $(ATK124_DIR)/atk/gtk*.h $(PTXCONF_PREFIX)/include
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glib22_targetinstall: $(STATEDIR)/glib22.targetinstall

glib22_targetinstall_deps	=  $(STATEDIR)/glib22.compile

$(STATEDIR)/glib22.targetinstall: $(glib22_targetinstall_deps)
	@$(call targetinfo, glib22.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glib22_clean:
	rm -rf $(STATEDIR)/glib22.*
	rm -rf $(GLIB22_DIR)

# vim: syntax=make
