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
FLUXBOX_VERSION	:= 1.1.1
FLUXBOX		:= fluxbox-$(FLUXBOX_VERSION)
FLUXBOX_SUFFIX	:= tar.bz2
FLUXBOX_URL	:= http://prdownloads.sourceforge.net/fluxbox/$(FLUXBOX).$(FLUXBOX_SUFFIX)
FLUXBOX_SOURCE	:= $(SRCDIR)/$(FLUXBOX).$(FLUXBOX_SUFFIX)
FLUXBOX_DIR	:= $(BUILDDIR)/$(FLUXBOX)
FLUXBOX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FLUXBOX_SOURCE):
	@$(call targetinfo)
	@$(call get, FLUXBOX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FLUXBOX_CONF_TOOL := autoconf
FLUXBOX_CONF_OPT := $(CROSS_AUTOCONF_USR) \
	--disable-randr \
	--disable-randr1.2 \
	--disable-xrender \
	--disable-gnome \
	--disable-debug \
	--enable-newwmspec \
	--disable-shape \
	--disable-slit \
	--enable-remember \
	--disable-nls \
	--disable-timed-cache \
	--disable-xmb

# force specific path
FLUXBOX_CONF_OPT += \
	--with-menu=/usr/share/fluxbox/menu \
	--with-windowmenu=/usr/share/fluxbox/windowmenu \
	--with-keys=/usr/share/fluxbox/keys \
	--with-apps=/usr/share/fluxbox/apps \
	--with-overlay=/usr/share/fluxbox/overlay \
	--with-init=/usr/share/fluxbox/init

ifdef PTXCONF_XORG_SERVER_EXT_XINERAMA
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

ifdef PTXCONF_FLUXBOX_THEMES
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles)

ifdef PTXCONF_FLUXBOX_THEMES_ARCH
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/arch)
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/arch/pixmaps)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/arch/theme.cfg)
	@for i in `find $(FLUXBOX_PKGDIR)/usr/share/fluxbox/styles/arch/pixmaps -name *.xpm`; do \
		file=`basename $$i`; \
		$(call install_copy, fluxbox, 0, 0, 0644, -, \
			/usr/share/fluxbox/styles/arch/pixmaps/$$file); \
	done
endif

ifdef PTXCONF_FLUXBOX_THEMES_BLOE
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/bloe)
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/bloe/pixmaps)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/bloe/theme.cfg)
	@for i in `find $(FLUXBOX_PKGDIR)/usr/share/fluxbox/styles/bloe/pixmaps -name *.xpm`; do \
		file=`basename $$i`; \
		$(call install_copy, fluxbox, 0, 0, 0644, -, \
			/usr/share/fluxbox/styles/bloe/pixmaps/$$file); \
	done
endif

ifdef PTXCONF_FLUXBOX_THEMES_BLUEFLUX
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/BlueFlux)
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/BlueFlux/pixmaps)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/BlueFlux/theme.cfg)
	@for i in `find $(FLUXBOX_PKGDIR)/usr/share/fluxbox/styles/BlueFlux/pixmaps -name *.xpm`; do \
		file=`basename $$i`; \
		$(call install_copy, fluxbox, 0, 0, 0644, -, \
			/usr/share/fluxbox/styles/BlueFlux/pixmaps/$$file); \
	done
endif

ifdef PTXCONF_FLUXBOX_THEMES_BORABLACK
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/bora_black)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/bora_black/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_BORABLUE
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/bora_blue)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/bora_blue/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_BORAGREEN
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/bora_green)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/bora_green/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_CARP
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/carp)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/carp/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_EMERGE
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/Emerge)
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/Emerge/pixmaps)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/Emerge/theme.cfg)
	@for i in `find $(FLUXBOX_PKGDIR)/usr/share/fluxbox/styles/Emerge/pixmaps -name *.xpm`; do \
		file=`basename $$i`; \
		$(call install_copy, fluxbox, 0, 0, 0644, -, \
			/usr/share/fluxbox/styles/Emerge/pixmaps/$$file); \
	done
endif

ifdef PTXCONF_FLUXBOX_THEMES_GREENTEA
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/green_tea)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/green_tea/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_OSTRICH
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/ostrich)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/ostrich/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_ZIMEKBISQUE
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/zimek_bisque)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/zimek_bisque/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_ZIMEKDARKBLUE
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/zimek_darkblue)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/zimek_darkblue/theme.cfg)
endif

ifdef PTXCONF_FLUXBOX_THEMES_ZIMEKGREEN
	@$(call install_copy, fluxbox, 0, 0, 0755, /usr/share/fluxbox/styles/zimek_green)
	@$(call install_copy, fluxbox, 0, 0, 0755, -, /usr/share/fluxbox/styles/zimek_green/theme.cfg)
endif

endif
	@$(call install_finish, fluxbox)

	@$(call touch)

# vim: syntax=make
