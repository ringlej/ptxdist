# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
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
PACKAGES-$(PTXCONF_XORG_LIB_X11) += xorg-lib-X11

#
# Paths and names
#
XORG_LIB_X11_VERSION	:= 1.0.1
XORG_LIB_X11		:= libX11-X11R7.1-$(XORG_LIB_X11_VERSION)
XORG_LIB_X11_SUFFIX	:= tar.bz2
XORG_LIB_X11_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/lib/$(XORG_LIB_X11).$(XORG_LIB_X11_SUFFIX)
XORG_LIB_X11_SOURCE	:= $(SRCDIR)/$(XORG_LIB_X11).$(XORG_LIB_X11_SUFFIX)
XORG_LIB_X11_DIR	:= $(BUILDDIR)/$(XORG_LIB_X11)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-X11_get: $(STATEDIR)/xorg-lib-X11.get

$(STATEDIR)/xorg-lib-X11.get: $(xorg-lib-X11_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_X11_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_X11)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-X11_extract: $(STATEDIR)/xorg-lib-X11.extract

$(STATEDIR)/xorg-lib-X11.extract: $(xorg-lib-X11_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_X11_DIR))
	@$(call extract, XORG_LIB_X11)
	@$(call patchin, XORG_LIB_X11)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-X11_prepare: $(STATEDIR)/xorg-lib-X11.prepare

XORG_LIB_X11_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_X11_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_X11_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull \
	--disable-dependency-tracking \
	--disable-man-pages
#
# if no value is given ignore the "--datadir" switch
#
ifneq ($(call remove_quotes,$(PTXCONF_XORG_DEFAULT_DATA_DIR)),)
	XORG_LIB_X11_AUTOCONF   += --datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_UNIX
XORG_LIB_X11_AUTOCONF	+= --enable-unix-transport
else
XORG_LIB_X11_AUTOCONF	+= --disable-unix-transport
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_TCP
XORG_LIB_X11_AUTOCONF	+= --enable-tcp-transport
else
XORG_LIB_X11_AUTOCONF	+= --disable-tcp-transport
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_IPV6
XORG_LIB_X11_AUTOCONF	+= --enable-ipv6
else
XORG_LIB_X11_AUTOCONF	+= --disable-ipv6
endif
#
# feature is marked as experimental if disabled!
#
ifdef PTXCONF_XORG_LIB_X11_XKB
XORG_LIB_X11_AUTOCONF	+= --enable-xkb
else
XORG_LIB_X11_AUTOCONF	+= --disable-xkb
endif

ifdef PTXCONF_XORG_SERVER_OPT_SECURE_RPC
XORG_LIB_X11_AUTOCONF	+= --enable-secure-rpc
else
XORG_LIB_X11_AUTOCONF	+= --disable-secure-rpc
endif

ifdef PTXCONF_XORG_LIB_X11_XF86BIGFONT
XORG_LIB_X11_AUTOCONF	+= --enable-xf86bigfont
else
XORG_LIB_X11_AUTOCONF	+= --disable-xf86bigfont
endif

ifdef PTXCONF_XORG_LIB_X11_I18N
XORG_LIB_X11_AUTOCONF	+= --enable-loadable-i18n
else
XORG_LIB_X11_AUTOCONF	+= --disable-loadable-i18n
endif

ifdef PTXCONF_XORG_LIB_X11_CURSOR
XORG_LIB_X11_AUTOCONF	+= --disable-loadable-xcursor
else
XORG_LIB_X11_AUTOCONF	+= --disable-loadable-xcursor
endif

# missing configure switches:
# --disable-xthreads      Disable Xlib support for Multithreading
# --disable-xcms          Disable Xlib support for CMS *EXPERIMENTAL*
# --disable-xlocale       Disable Xlib locale implementation *EXPERIMENTAL*
# --enable-xlocaledir     Enable XLOCALEDIR environment variable support
#
$(STATEDIR)/xorg-lib-X11.prepare: $(xorg-lib-X11_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_X11_DIR)/config.cache)
	cd $(XORG_LIB_X11_DIR) && \
		$(XORG_LIB_X11_PATH) $(XORG_LIB_X11_ENV) \
		./configure $(XORG_LIB_X11_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-X11_compile: $(STATEDIR)/xorg-lib-X11.compile

$(STATEDIR)/xorg-lib-X11.compile: $(xorg-lib-X11_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_X11_DIR) && $(XORG_LIB_X11_PATH) $(XORG_LIB_X11_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-X11_install: $(STATEDIR)/xorg-lib-X11.install

$(STATEDIR)/xorg-lib-X11.install: $(xorg-lib-X11_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_X11)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-X11_targetinstall: $(STATEDIR)/xorg-lib-X11.targetinstall

$(STATEDIR)/xorg-lib-X11.targetinstall: $(xorg-lib-X11_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-X11)
	@$(call install_fixup, xorg-lib-X11,PACKAGE,xorg-lib-x11)
	@$(call install_fixup, xorg-lib-X11,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-X11,VERSION,$(XORG_LIB_X11_VERSION))
	@$(call install_fixup, xorg-lib-X11,SECTION,base)
	@$(call install_fixup, xorg-lib-X11,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-X11,DEPENDS,)
	@$(call install_fixup, xorg-lib-X11,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/src/.libs/libX11.so.6.2.0, \
		$(XORG_LIBDIR)/libX11.so.6.2.0)

	@$(call install_link, xorg-lib-X11, \
		libX11.so.6.2.0, \
		$(XORG_LIBDIR)/libX11.so.6)

	@$(call install_link, xorg-lib-X11, \
		libX11.so.6.2.0, \
		$(XORG_LIBDIR)/libX11.so)

ifdef PTXCONF_XORG_LIB_X11_INSTALL_LOCALE
	@$(call install_copy, xorg-lib-X11, 0, 0, 0755, /usr/lib/X11/locale)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/locale.alias, \
		/usr/lib/X11/locale/locale.alias,n)

	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/locale.dir, \
		/usr/lib/X11/locale/locale.dir,n)

	@$(call install_copy, xorg-lib-X11, 0, 0, 0755, /usr/lib/X11/locale/C)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/C/Compose, \
		/usr/lib/X11/locale/C/Compose,n)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/C/XI18N_OBJS, \
		/usr/lib/X11/locale/C/XI18N_OBJS,n)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/C/XLC_LOCALE, \
		/usr/lib/X11/locale/C/XLC_LOCALE,n)

endif

ifdef PTXCONF_XORG_LIB_X11_INSTALL_LOCALE_8859_1
	@$(call install_copy, xorg-lib-X11, 0, 0, 0755, /usr/lib/X11/locale/iso8859-1)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/iso8859-1/Compose, \
		/usr/lib/X11/locale/iso8859-1/Compose,n)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/iso8859-1/XI18N_OBJS, \
		/usr/lib/X11/locale/iso8859-1/XI18N_OBJS,n)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/iso8859-1/XLC_LOCALE, \
		/usr/lib/X11/locale/iso8859-1/XLC_LOCALE,n)
endif

ifdef PTXCONF_XORG_LIB_X11_INSTALL_LOCALE_8859_15
	@$(call install_copy, xorg-lib-X11, 0, 0, 0755, /usr/lib/X11/locale/iso8859-15)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/iso8859-15/Compose, \
		/usr/lib/X11/locale/iso8859-15/Compose,n)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/iso8859-15/XI18N_OBJS, \
		/usr/lib/X11/locale/iso8859-15/XI18N_OBJS,n)
	@$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/nls/iso8859-15/XLC_LOCALE, \
		/usr/lib/X11/locale/iso8859-15/XLC_LOCALE,n)
endif

ifdef PTXCONF_XORG_LIB_X11_INSTALL_LOCALE_CHN_MAIN
	@cd $(XORG_LIB_X11_DIR)/nls; \
	for file in `find . -name "*zh_CN*" -type d`; do \
		echo "scanning $$file"; \
		if [ -d $$file ]; then \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/Compose, \
				/usr/lib/X11/locale/$$file/Compose,n); \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/XI18N_OBJS, \
				/usr/lib/X11/locale/$$file/XI18N_OBJS,n); \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/XLC_LOCALE, \
				/usr/lib/X11/locale/$$file/XLC_LOCALE,n); \
		fi; \
	done;
endif

ifdef PTXCONF_XORG_LIB_X11_INSTALL_LOCALE_CHN_HK
	@cd $(XORG_LIB_X11_DIR)/nls; \
	for file in `find . -name "*zh_HK*" -type d`; do \
		if [ -d $$file ]; then \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/Compose, \
				/usr/lib/X11/locale/$$file/Compose,n); \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/XI18N_OBJS, \
				/usr/lib/X11/locale/$$file/XI18N_OBJS,n); \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/XLC_LOCALE, \
				/usr/lib/X11/locale/$$file/XLC_LOCALE,n); \
		fi; \
	done;
endif

ifdef PTXCONF_XORG_LIB_X11_INSTALL_LOCALE_CHN_TW
	@cd $(XORG_LIB_X11_DIR)/nls; \
	for file in `find . -name "*zh_TW*" -type d`; do \
		if [ -d $$file ]; then \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/Compose, \
				/usr/lib/X11/locale/$$file/Compose,n); \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/XI18N_OBJS, \
				/usr/lib/X11/locale/$$file/XI18N_OBJS,n); \
			$(call install_copy, xorg-lib-X11, 0, 0, 0644, \
				$(XORG_LIB_X11_DIR)/nls/$$file/XLC_LOCALE, \
				/usr/lib/X11/locale/$$file/XLC_LOCALE,n); \
		fi; \
	done;
endif

	@$(call install_finish, xorg-lib-X11)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-X11_clean:
	rm -rf $(STATEDIR)/xorg-lib-X11.*
	rm -rf $(IMAGEDIR)/xorg-lib-X11_*
	rm -rf $(XORG_LIB_X11_DIR)

# vim: syntax=make
