# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLUXBOX) += fluxbox

#
# Paths and names
#
FLUXBOX_VERSION	:= 1.3.2
FLUXBOX_MD5	:= f95b0bdb9ee41bfac124bd0fc601f248
FLUXBOX		:= fluxbox-$(FLUXBOX_VERSION)
FLUXBOX_SUFFIX	:= tar.bz2
FLUXBOX_URL	:= $(call ptx/mirror, SF, fluxbox/$(FLUXBOX).$(FLUXBOX_SUFFIX))
FLUXBOX_SOURCE	:= $(SRCDIR)/$(FLUXBOX).$(FLUXBOX_SUFFIX)
FLUXBOX_DIR	:= $(BUILDDIR)/$(FLUXBOX)
FLUXBOX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FLUXBOX_CONF_TOOL := autoconf
FLUXBOX_CONF_OPT := $(CROSS_AUTOCONF_USR) \
	--disable-randr \
	--disable-randr1.2 \
	--disable-xrender \
	--disable-debug \
	--disable-test \
	--enable-newwmspec \
	--disable-shape \
	--disable-slit \
	--enable-remember \
	--disable-nls \
	--disable-timed-cache \
	--disable-xmb \
	--disable-fribidi

# force specific path
FLUXBOX_CONF_OPT += \
	--with-menu=/usr/share/fluxbox/menu \
	--with-windowmenu=/usr/share/fluxbox/windowmenu \
	--with-keys=/usr/share/fluxbox/keys \
	--with-apps=/usr/share/fluxbox/apps \
	--with-overlay=/usr/share/fluxbox/overlay \
	--with-init=/usr/share/fluxbox/init

ifdef PTXCONF_FLUXBOX_XINERAMA
FLUXBOX_CONF_OPT += --enable-xinerama
else
FLUXBOX_CONF_OPT += --disable-xinerama
endif

ifdef PTXCONF_FLUXBOX_THEMES
ifdef PTXCONF_FLUXBOX_DEFAULT_THEME_BLOE
FLUXBOX_CONF_OPT += --with-style=/usr/share/fluxbox/styles/bloe
endif
ifdef PTXCONF_FLUXBOX_DEFAULT_THEME_ARCH
FLUXBOX_CONF_OPT += --with-style=/usr/share/fluxbox/styles/arch
endif
ifdef PTXCONF_FLUXBOX_DEFAULT_THEME_BLUEFLUX
FLUXBOX_CONF_OPT += --with-style=/usr/share/fluxbox/styles/BlueFlux
endif
ifdef PTXCONF_FLUXBOX_DEFAULT_THEME_EMERGE
FLUXBOX_CONF_OPT += --with-style=/usr/share/fluxbox/styles/Emerge
endif
endif


ifdef PTXCONF_FLUXBOX_IMLIB2
FLUXBOX_CONF_OPT += --enable-imlib2
else
FLUXBOX_CONF_OPT += --disable-imlib2
endif

ifdef PTXCONF_FLUXBOX_XPM
FLUXBOX_CONF_OPT += --enable-xpm
else
FLUXBOX_CONF_OPT += --disable-xpm
endif

ifdef PTXCONF_FLUXBOX_XFT
FLUXBOX_CONF_OPT += --enable-xft
else
FLUXBOX_CONF_OPT += --disable-xft
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fluxbox.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fluxbox)
	@$(call install_fixup, fluxbox,PRIORITY,optional)
	@$(call install_fixup, fluxbox,SECTION,base)
	@$(call install_fixup, fluxbox,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, fluxbox,DESCRIPTION,missing)


	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/fbrun)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/fbsetbg)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/fbsetroot)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/fluxbox)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/fluxbox-generate_menu)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/fluxbox-remote)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/fluxbox-update_configs)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/bin/startfluxbox)

	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox)
	@$(call install_copy, fluxbox, 0, 0, 0644, -, /usr/share/fluxbox/apps)
	@$(call install_copy, fluxbox, 0, 0, 0644, -, /usr/share/fluxbox/init)
	@$(call install_copy, fluxbox, 0, 0, 0644, -, /usr/share/fluxbox/keys)
	@$(call install_copy, fluxbox, 0, 0, 0644, -, /usr/share/fluxbox/menu)
	@$(call install_copy, fluxbox, 0, 0, 0644, -, /usr/share/fluxbox/overlay)
	@$(call install_copy, fluxbox, 0, 0, 0644, -, /usr/share/fluxbox/windowmenu)

	@for i in Artwiz BlueNight Flux LemonSpace Makro Operation Results \
		MerleyKay Shade Flux Meta Outcomes Twice Nyz qnx-photon; do \
		$(call install_copy, fluxbox, 0, 0, 0644, -, \
			/usr/share/fluxbox/styles/$$i); \
	done

ifdef PTXCONF_FLUXBOX_THEMES_ARCH
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/arch)
endif
ifdef PTXCONF_FLUXBOX_THEMES_BLOE
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/bloe)
endif
ifdef PTXCONF_FLUXBOX_THEMES_BLUEFLUX
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/BlueFlux)
endif
ifdef PTXCONF_FLUXBOX_THEMES_BORABLACK
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/bora_black)
endif
ifdef PTXCONF_FLUXBOX_THEMES_BORABLUE
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/bora_blue)
endif
ifdef PTXCONF_FLUXBOX_THEMES_BORAGREEN
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/bora_green)
endif
ifdef PTXCONF_FLUXBOX_THEMES_CARP
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/carp)
endif
ifdef PTXCONF_FLUXBOX_THEMES_EMERGE
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/Emerge)
endif
ifdef PTXCONF_FLUXBOX_THEMES_GREENTEA
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/green_tea)
endif
ifdef PTXCONF_FLUXBOX_THEMES_OSTRICH
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/ostrich)
endif
ifdef PTXCONF_FLUXBOX_THEMES_ZIMEKBISQUE
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/zimek_bisque)
endif
ifdef PTXCONF_FLUXBOX_THEMES_ZIMEKDARKBLUE
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/zimek_darkblue)
endif
ifdef PTXCONF_FLUXBOX_THEMES_ZIMEKGREEN
	@$(call install_tree, fluxbox, 0, 0, -, /usr/share/fluxbox/styles/zimek_green)
endif
	@$(call install_finish, fluxbox)

	@$(call touch)

# vim: syntax=make
