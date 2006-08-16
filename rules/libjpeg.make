# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBJPEG) += libjpeg

#
# Paths and names
#
LIBJPEG_VERSION	:= 6b
LIBJPEG		:= jpeg-6b
LIBJPEG_SUFFIX	:= tar.gz
LIBJPEG_URL	:= http://www.ijg.org/files/jpegsrc.v6b.$(LIBJPEG_SUFFIX)
LIBJPEG_SOURCE	:= $(SRCDIR)/jpegsrc.v6b.$(LIBJPEG_SUFFIX)
LIBJPEG_DIR	:= $(BUILDDIR)/$(LIBJPEG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libjpeg_get: $(STATEDIR)/libjpeg.get

$(STATEDIR)/libjpeg.get: $(libjpeg_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBJPEG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBJPEG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libjpeg_extract: $(STATEDIR)/libjpeg.extract

$(STATEDIR)/libjpeg.extract: $(libjpeg_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBJPEG_DIR))
	@$(call extract, LIBJPEG)
	@$(call patchin, LIBJPEG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libjpeg_prepare: $(STATEDIR)/libjpeg.prepare

LIBJPEG_PATH	:= PATH=$(CROSS_PATH)
LIBJPEG_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_prog_cc_cross=yes

#
# autoconf
#
LIBJPEG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static

$(STATEDIR)/libjpeg.prepare: $(libjpeg_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBJPEG_DIR)/config.cache)
	cd $(LIBJPEG_DIR) && \
		$(LIBJPEG_PATH) $(LIBJPEG_ENV) \
		./configure $(LIBJPEG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libjpeg_compile: $(STATEDIR)/libjpeg.compile

$(STATEDIR)/libjpeg.compile: $(libjpeg_compile_deps_default)
	@$(call targetinfo, $@)
	# libtool came from a patch, so we have to make it executable
	chmod a+x $(LIBJPEG_DIR)/libtool
	cd $(LIBJPEG_DIR) && $(LIBJPEG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libjpeg_install: $(STATEDIR)/libjpeg.install

$(STATEDIR)/libjpeg.install: $(libjpeg_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBJPEG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libjpeg_targetinstall: $(STATEDIR)/libjpeg.targetinstall

$(STATEDIR)/libjpeg.targetinstall: $(libjpeg_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libjpeg)
	@$(call install_fixup,libjpeg,PACKAGE,libjpeg)
	@$(call install_fixup,libjpeg,PRIORITY,optional)
	@$(call install_fixup,libjpeg,VERSION,$(LIBJPEG_VERSION))
	@$(call install_fixup,libjpeg,SECTION,base)
	@$(call install_fixup,libjpeg,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,libjpeg,DEPENDS,)
	@$(call install_fixup,libjpeg,DESCRIPTION,missing)

	@$(call install_copy, libjpeg, 0, 0, 0755, $(LIBJPEG_DIR)/.libs/cjpeg, /usr/bin/cjpeg)
	@$(call install_copy, libjpeg, 0, 0, 0755, $(LIBJPEG_DIR)/.libs/djpeg, /usr/bin/djpeg)
	@$(call install_copy, libjpeg, 0, 0, 0755, $(LIBJPEG_DIR)/.libs/jpegtran, /usr/bin/jpegtran)

	@$(call install_copy, libjpeg, 0, 0, 0755, $(LIBJPEG_DIR)/.libs/libjpeg.so.62.0.0, /usr/lib/libjpeg.so.62.0.0 )
	@$(call install_link, libjpeg, libjpeg.so.62.0.0, /usr/lib/libjpeg.so.62)
	@$(call install_link, libjpeg, libjpeg.so.62.0.0, /usr/lib/libjpeg.so)

	@$(call install_finish,libjpeg)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libjpeg_clean:
	rm -rf $(STATEDIR)/libjpeg.*
	rm -rf $(IMAGEDIR)/libjpeg_*
	rm -rf $(LIBJPEG_DIR)

# vim: syntax=make
