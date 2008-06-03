# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>,
#                       Pengutronix e.K.<info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MFIREBIRD) += mfirebird

#
# Paths and names
#
MFIREBIRD_VERSION		= 0.8
MFIREBIRD			= firefox-source-$(MFIREBIRD_VERSION)
MFIREBIRD_SUFFIX		= tar.bz2
MFIREBIRD_URL			= ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$(MFIREBIRD_VERSION)/$(MFIREBIRD).$(MFIREBIRD_SUFFIX)
MFIREBIRD_SOURCE		= $(SRCDIR)/$(MFIREBIRD).$(MFIREBIRD_SUFFIX)
MFIREBIRD_DIR			= $(BUILDDIR)/$(MFIREBIRD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mfirebird_get: $(STATEDIR)/mfirebird.get

$(STATEDIR)/mfirebird.get: $(mfirebird_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MFIREBIRD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MFIREBIRD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mfirebird_extract: $(STATEDIR)/mfirebird.extract

$(STATEDIR)/mfirebird.extract: $(mfirebird_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MFIREBIRD_DIR))
	@$(call extract, MFIREBIRD)
	cd $(BUILDDIR) && mv mozilla $(MFIREBIRD)
	@$(call patchin, MFIREBIRD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mfirebird_prepare: $(STATEDIR)/mfirebird.prepare

MFIREBIRD_PATH	=  PATH=$(CROSS_PATH)

MFIREBIRD_ENV	=  $(CROSS_ENV)
MFIREBIRD_ENV	+= MOZILLA_OFFICIAL=1
MFIREBIRD_ENV	+= BUILD_OFFICIAL=1
MFIREBIRD_ENV	+= MOZ_PHOENIX=1
MFIREBIRD_ENV   += PKG_CONFIG_PATH=$(SYSROOT)/lib/pkgconfig/

#
# autoconf
#

MFIREBIRD_AUTOCONF	=  $(CROSS_AUTOCONF_USR) \
	--with-x=$(SYSROOT)/usr/X11R6 \
	--enable-default-toolkit=gtk2 \
	--with-gtk-prefix=$(SYSROOT) \
	--with-glib-prefix=$(SYSROOT) \
	--disable-gtktest \
	--disable-gdktest \
	--disable-tests \
	--disable-xinerama \
	--disable-calendar \
	--disable-mailnews \
	--disable-ldap \
	--disable-freetypetest \
	--disable-xprint \
	--enable-crypto \
	--enable-accessability \
	--enable-xfpe-components \
	--disable-composer \
	--enable-mathml \
	--disable-svg \
	--disable-activex \
	--enable-extensions \
	--without-system-nspr \
	--enable-necko-disk-cache \
	--enable-xft

#MFIREBIRD_AUTOCONF	+= --disable-jsloader
#MFIREBIRD_AUTOCONF	+= --disable-jsd
#MFIREBIRD_AUTOCONF	+= --disable-oji
#MFIREBIRD_AUTOCONF	+= --disable-postscript
#MFIREBIRD_AUTOCONF	+= --enable-single-profile
#MFIREBIRD_AUTOCONF	+= --disable-installer



# g++ currently seems to have a bug with -pedantic (at least the
# configure script claims so)
MFIREBIRD_AUTOCONF	+= --disable-pedantic

##ifdef PTXCONF_MFIREBIRD_CALENDAR
##MFIREBIRD_AUTOCONF	+= --enable-calendar
##else
##MFIREBIRD_AUTOCONF	+= --disable-calendar
##endif

##ifdef PTXCONF_MFIREBIRD_MAILNEWS
##MFIREBIRD_AUTOCONF	+= --enable-mailnews
##else
##MFIREBIRD_AUTOCONF	+= --disable-mailnews
##endif

#ifdef PTXCONF_MFIREBIRD_MAILNEWS_STATICBUILD
#MFIREBIRD_AUTOCONF	+= --enable-static-mail
#else
#MFIREBIRD_AUTOCONF	+= --disable-static-mail
#endif
#
#ifdef PTXCONF_MFIREBIRD_LDAP
#MFIREBIRD_AUTOCONF	+= --enable-ldap
#else
#MFIREBIRD_AUTOCONF	+= --disable-ldap
#endif

ifdef PTXCONF_MFIREBIRD_FREETYPE2
MFIREBIRD_AUTOCONF	+= --enable-freetype2
else
MFIREBIRD_AUTOCONF	+= --disable-freetype2
endif

ifdef PTXCONF_MFIREBIRD_XFT
MFIREBIRD_AUTOCONF	+= --enable-xft
else
MFIREBIRD_AUTOCONF	+= --disable-xft
endif

#ifdef PTXCONF_MFIREBIRD_POSTSCRIPT
#MFIREBIRD_AUTOCONF	+= --enable-postscript
#else
#MFIREBIRD_AUTOCONF	+= --disable-postscript
#endif
#
#ifdef PTXCONF_MFIREBIRD_XPRINT
#MFIREBIRD_AUTOCONF	+= --enable-xprint
#else
#MFIREBIRD_AUTOCONF	+= --disable-xprint
#endif
#
#ifdef PTXCONF_MFIREBIRD_CRYPTO
#MFIREBIRD_AUTOCONF	+= --enable-crypto
#else
#MFIREBIRD_AUTOCONF	+= --disable-crypto
#endif
#
#ifdef PTXCONF_MFIREBIRD_JSD
#MFIREBIRD_AUTOCONF	+= --enable-jsd
#else
#MFIREBIRD_AUTOCONF	+= --disable-jsd
#endif
#
#ifdef PTXCONF_MFIREBIRD_OJI
#MFIREBIRD_AUTOCONF	+= --enable-oji
#else
#MFIREBIRD_AUTOCONF	+= --disable-oji
#endif
#
#ifdef PTXCONF_MFIREBIRD_XINERAMA
#MFIREBIRD_AUTOCONF	+= --enable-xinerama
#else
#MFIREBIRD_AUTOCONF	+= --disable-xinerama
#endif
#
#ifdef PTXCONF_MFIREBIRD_CTL
#MFIREBIRD_AUTOCONF	+= --enable-ctl
#else
#MFIREBIRD_AUTOCONF	+= --disable-ctl
#endif
#
#ifdef PTXCONF_MFIREBIRD_ACCESSABILITY
#MFIREBIRD_AUTOCONF	+= --enable-accessability
#else
#MFIREBIRD_AUTOCONF	+= --disable-accessability
#endif
#
#ifdef PTXCONF_MFIREBIRD_XFPE_COMP
#MFIREBIRD_AUTOCONF	+= --enable-xpfe-components
#else
#MFIREBIRD_AUTOCONF	+= --disable-xpfe-components
#endif
#
#ifdef PTXCONF_MFIREBIRD_XPINSTALL
#MFIREBIRD_AUTOCONF	+= --enable-xpinstall
#else
#MFIREBIRD_AUTOCONF	+= --disable-xpinstall
#endif
#
#ifdef PTXCONF_MFIREBIRD_SINGLE_PROFILE
#MFIREBIRD_AUTOCONF	+= --enable-single-profile
#else
#MFIREBIRD_AUTOCONF	+= --disable-single-profile
#endif
#
#ifdef PTXCONF_MFIREBIRD_JSLOADER
#MFIREBIRD_AUTOCONF	+= --enable-jsloader
#else
#MFIREBIRD_AUTOCONF	+= --disable-jsloader
#endif
#
#ifdef PTXCONF_MFIREBIRD_NATIVE_UCONV
#MFIREBIRD_AUTOCONF	+= --enable-native-uconv
#else
#MFIREBIRD_AUTOCONF	+= --disable-native-uconv
#endif
#
#ifdef PTXCONF_MFIREBIRD_PLAINTEXT
#MFIREBIRD_AUTOCONF	+= --enable-plaintext-editor-only
#else
#MFIREBIRD_AUTOCONF	+= --disable-plaintext-editor-only
#endif

##ifdef PTXCONF_MFIREBIRD_COMPOSER
##MFIREBIRD_AUTOCONF	+= --enable-composer
##else
##MFIREBIRD_AUTOCONF	+= --disable-composer
##endif

#ifdef PTXCONF_MFIREBIRD_EXTENSIONS
#MFIREBIRD_AUTOCONF	+= --enable-extensions
#else
#MFIREBIRD_AUTOCONF	+= --disable-extensions
#endif
#
#ifdef PTXCONF_MFIREBIRD_IMAGE_DECODERS
#MFIREBIRD_AUTOCONF	+= --enable-extensions
#else
#MFIREBIRD_AUTOCONF	+= --disable-extensions
#endif
#
#ifdef PTXCONF_MFIREBIRD_IMAGE_DECODERS_MOD1
#MFIREBIRD_AUTOCONF	+= --enable-image-decoders=mod1
#endif
#
#ifdef PTXCONF_MFIREBIRD_IMAGE_DECODERS_MOD2
#MFIREBIRD_AUTOCONF	+= --enable-image-decoders=mod2
#endif
#
#ifdef PTXCONF_MFIREBIRD_MATHML
#MFIREBIRD_AUTOCONF	+= --enable-mathml
#else
#MFIREBIRD_AUTOCONF	+= --disable-mathml
#endif
#
#ifdef PTXCONF_MFIREBIRD_SVG
#MFIREBIRD_AUTOCONF	+= --enable-svg
#else
#MFIREBIRD_AUTOCONF	+= --disable-svg
#endif
#
#ifdef PTXCONF_MFIREBIRD_INSTALLER
#MFIREBIRD_AUTOCONF	+= --enable-installer
#else
#MFIREBIRD_AUTOCONF	+= --disable-installer
#endif
#
#ifdef PTXCONF_MFIREBIRD_LEAKY
#MFIREBIRD_AUTOCONF	+= --enable-leaky
#else
#MFIREBIRD_AUTOCONF	+= --disable-leaky
#endif
#
#ifdef PTXCONF_MFIREBIRD_XPCTOOLS
#MFIREBIRD_AUTOCONF	+= --enable-xpctools
#else
#MFIREBIRD_AUTOCONF	+= --disable-xpctools
#endif
#
#ifdef PTXCONF_MFIREBIRD_TESTS
#MFIREBIRD_AUTOCONF	+= --enable-tests
#else
#MFIREBIRD_AUTOCONF	+= --disable-tests
#endif
#
#ifdef PTXCONF_MFIREBIRD_XPCOM_LEA
#MFIREBIRD_AUTOCONF	+= --enable-xpcom-lea
#else
#MFIREBIRD_AUTOCONF	+= --disable-xpcom-lea
#endif

ifdef PTXCONF_MFIREBIRD_DEBUG
MFIREBIRD_AUTOCONF	+= --enable-debug
else
MFIREBIRD_AUTOCONF	+= --disable-debug
endif

ifdef PTXCONF_MFIREBIRD_OPTIMIZE
MFIREBIRD_AUTOCONF	+= --enable-optimize=$(PTXCONF_MFIREBIRD_OPTIMIZE)
endif

#ifdef PTXCONF_MFIREBIRD_BOEHM
#MFIREBIRD_AUTOCONF	+= --enable-boehm
#else
#MFIREBIRD_AUTOCONF	+= --disable-boehm
#endif
#
#ifdef PTXCONF_MFIREBIRD_LOGGING
#MFIREBIRD_AUTOCONF	+= --enable-logging
#else
#MFIREBIRD_AUTOCONF	+= --disable-logging
#endif
#
#ifdef PTXCONF_MFIREBIRD_CRASH_ASSERT
#MFIREBIRD_AUTOCONF	+= --enable-crash-on-assert
#else
#MFIREBIRD_AUTOCONF	+= --disable-crash-on-assert
#endif
#
#ifdef PTXCONF_MFIREBIRD_TIMELINE
#MFIREBIRD_AUTOCONF	+= --enable-timeline
#else
#MFIREBIRD_AUTOCONF	+= --disable-timeline
#endif
#
#ifdef PTXCONF_MFIREBIRD_XTERM_UPDATE
#MFIREBIRD_AUTOCONF	+= --enable-xterm-updates
#else
#MFIREBIRD_AUTOCONF	+= --disable-xterm-updates
#endif
#
#ifdef PTXCONF_MFIREBIRD_SHARED
#MFIREBIRD_AUTOCONF	+= --enable-shared
#else
#MFIREBIRD_AUTOCONF	+= --enable-static
#endif
#
#ifdef PTXCONF_MFIREBIRD_COMPONENTLIB
#MFIREBIRD_AUTOCONF	+= --enable-componentlib
#else
#MFIREBIRD_AUTOCONF	+= --disable-componentlib
#endif
#
#ifdef PTXCONF_MFIREBIRD_XUL
#MFIREBIRD_AUTOCONF	+= --enable-xul
#else
#MFIREBIRD_AUTOCONF	+= --disable-xul
#endif
#
#ifdef PTXCONF_MFIREBIRD_PROFILE_SHARING
#MFIREBIRD_AUTOCONF	+= --enable-profilesharing
#else
#MFIREBIRD_AUTOCONF	+= --disable-profilesharing
#endif
#
#ifdef PTXCONF_MFIREBIRD_PROFILE_LOCKING
#MFIREBIRD_AUTOCONF	+= --enable-profilelocking
#else
#MFIREBIRD_AUTOCONF	+= --disable-profilelocking
#endif
#
#ifdef PTXCONF_MFIREBIRD_NECKO_PROTOCOLS_FTP
#MFIREBIRD_AUTOCONF	+= --enable-necko-protocols=ftp
#endif
#
#ifdef PTXCONF_MFIREBIRD_NECKO_PROTOCOLS_HTTP
#MFIREBIRD_AUTOCONF	+= --enable-necko-protocols=http
#endif
#
#ifdef PTXCONF_MFIREBIRD_NECKO_CACHE
#MFIREBIRD_AUTOCONF	+= --enable-necko-disk-cache
#else
#MFIREBIRD_AUTOCONF	+= --disable-necko-disk-cache
#endif
#
#ifdef PTXCONF_MFIREBIRD_NECKO_SMALLBUF
#MFIREBIRD_AUTOCONF	+= --enable-necko-small-buffers
#else
#MFIREBIRD_AUTOCONF	+= --disable-necko-small-buffers
#endif

$(STATEDIR)/mfirebird.prepare: $(mfirebird_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MFIREBIRD_BUILDDIR))
	cd $(MFIREBIRD_DIR) && \
		$(MFIREBIRD_PATH) $(MFIREBIRD_ENV) \
		./configure $(MFIREBIRD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mfirebird_compile: $(STATEDIR)/mfirebird.compile

$(STATEDIR)/mfirebird.compile: $(mfirebird_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MFIREBIRD_DIR) && $(MFIREBIRD_PATH) $(MFIREBIRD_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mfirebird_install: $(STATEDIR)/mfirebird.install

$(STATEDIR)/mfirebird.install: $(mfirebird_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, MFIREBIRD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mfirebird_targetinstall: $(STATEDIR)/mfirebird.targetinstall

$(STATEDIR)/mfirebird.targetinstall: $(mfirebird_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mfirebird)
	@$(call install_fixup, mfirebird,PACKAGE,mfirebird)
	@$(call install_fixup, mfirebird,PRIORITY,optional)
	@$(call install_fixup, mfirebird,VERSION,$(MFIREBIRD_VERSION))
	@$(call install_fixup, mfirebird,SECTION,base)
	@$(call install_fixup, mfirebird,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mfirebird,DEPENDS,)
	@$(call install_fixup, mfirebird,DESCRIPTION,missing)

	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libgkgfx.so, /usr/lib/libgkgfx.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libgtkembedmoz.so, /usr/lib/libgtkembedmoz.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libgtkxtbin.so, /usr/lib/libgtkxtbin.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libjsj.so, /usr/lib/libjsj.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libmozjs.so, /usr/lib/libmozjs.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libmozz.so, /usr/lib/libmozz.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libnspr4.so, /usr/lib/libnspr4.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libnss3.so, /usr/lib/libnss3.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libplds4.so, /usr/lib/libplds4.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libplc4.so, /usr/lib/libplc4.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libsmime3.so, /usr/lib/libsmime3.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libsoftokn3.so, /usr/lib/libsoftokn3.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libssl3.so, /usr/lib/libssl3.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libxpcom.so, /usr/lib/libxpcom.so)
	@$(call install_copy, mfirebird, 0, 0, 0644, $(MFIREBIRD_DIR)/dist/lib/libxpcom_compat.so, /usr/lib/libxpcom_compat.so)

#	cp -a $(SYSROOT)/lib/mozilla-1.6/components $(ROOTDIR)/usr/lib/mozilla-1.6
#	cp -a $(SYSROOT)/lib/mozilla-1.6/chrome $(ROOTDIR)/usr/lib/mozilla-1.6
#	cp -a $(SYSROOT)/lib/mozilla-1.6/res $(ROOTDIR)/usr/lib/mozilla-1.6

# BSP: Quick and ...
	for file in $(SYSROOT)/lib/mozilla-1.6/*; do 			\
		$(call install_copy, mfirebird, 0, 0, 0755, $$file, /usr/lib/)		\
	done

	@$(call install_finish, mfirebird)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mfirebird_clean:
	rm -rf $(STATEDIR)/mfirebird.*
	rm -rf $(PKGDIR)/mfirebird_*
	rm -rf $(MFIREBIRD_DIR)

# vim: syntax=make
