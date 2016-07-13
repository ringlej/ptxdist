# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RRDTOOL) += rrdtool

#
# Paths and names
#
RRDTOOL_VERSION	:= 1.4.9
RRDTOOL_MD5	:= 1cea5a9efd6a48ac4035b0f9c7e336cf
RRDTOOL		:= rrdtool-$(RRDTOOL_VERSION)
RRDTOOL_SUFFIX	:= tar.gz
RRDTOOL_URL	:= http://oss.oetiker.ch/rrdtool/pub/$(RRDTOOL).$(RRDTOOL_SUFFIX)
RRDTOOL_SOURCE	:= $(SRCDIR)/$(RRDTOOL).$(RRDTOOL_SUFFIX)
RRDTOOL_DIR	:= $(BUILDDIR)/$(RRDTOOL)
RRDTOOL_LICENSE	:= GPL-2.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RRDTOOL_CONF_ENV	:= \
	$(CROSS_ENV) \
	rd_cv_ieee_works=yes \
	rd_cv_ms_async=ok \
	rd_cv_null_realloc=yes
#
# autoconf
#
RRDTOOL_CONF_TOOL	:= autoconf
RRDTOOL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_RRDTOOL_RRDCGI)-rrdcgi \
	--$(call ptx/endis, PTXCONF_RRDTOOL_RRD_GRAPH)-rrd_graph \
	--enable-mmap \
	--enable-pthread \
	--disable-static-programs \
	--disable-nls \
	--disable-rpath \
	--disable-libdbi \
	--$(call ptx/endis, PTXCONF_RRDTOOL_WRAP)-libwrap \
	--disable-perl \
	--disable-ruby \
	--disable-lua \
	--disable-tcl \
	--disable-python \
	--without-libiconv-prefix \
	--without-libintl-prefix

ifneq ($(call remove_quotes,$(PTXCONF_RRDTOOL_DEFAULT_FONT)),)
RRDTOOL_CONF_OPT += --with-rrd-default-font=$(PTXCONF_RRDTOOL_DEFAULT_FONT)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rrdtool.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rrdtool)
	@$(call install_fixup, rrdtool,PRIORITY,optional)
	@$(call install_fixup, rrdtool,SECTION,base)
	@$(call install_fixup, rrdtool,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, rrdtool,DESCRIPTION,missing)

ifdef PTXCONF_RRDTOOL_RRDCACHED
	@$(call install_copy, rrdtool, 0, 0, 0755, -, /usr/bin/rrdcached)
endif
ifdef PTXCONF_RRDTOOL_RRDCGI
	@$(call install_copy, rrdtool, 0, 0, 0755, -, /usr/bin/rrdcgi)
endif
ifdef PTXCONF_RRDTOOL_RRDTOOL
	@$(call install_copy, rrdtool, 0, 0, 0755, -, /usr/bin/rrdtool)
endif
ifdef PTXCONF_RRDTOOL_RRDUPDATE
	@$(call install_copy, rrdtool, 0, 0, 0755, -, /usr/bin/rrdupdate)
endif

	@$(call install_lib, rrdtool, 0, 0, 0644, librrd)
	@$(call install_lib, rrdtool, 0, 0, 0644, librrd_th)

	@$(call install_finish, rrdtool)

	@$(call touch)

# vim: syntax=make
