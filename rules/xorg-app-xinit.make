# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XINIT) += xorg-app-xinit

#
# Paths and names
#
XORG_APP_XINIT_VERSION	:= 1.2.0
XORG_APP_XINIT		:= xinit-$(XORG_APP_XINIT_VERSION)
XORG_APP_XINIT_SUFFIX	:= tar.bz2
XORG_APP_XINIT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XINIT).$(XORG_APP_XINIT_SUFFIX)
XORG_APP_XINIT_SOURCE	:= $(SRCDIR)/$(XORG_APP_XINIT).$(XORG_APP_XINIT_SUFFIX)
XORG_APP_XINIT_DIR	:= $(BUILDDIR)/$(XORG_APP_XINIT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xinit_get: $(STATEDIR)/xorg-app-xinit.get

$(STATEDIR)/xorg-app-xinit.get: $(xorg-app-xinit_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XINIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XINIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xinit_extract: $(STATEDIR)/xorg-app-xinit.extract

$(STATEDIR)/xorg-app-xinit.extract: $(xorg-app-xinit_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XINIT_DIR))
	@$(call extract, XORG_APP_XINIT)
	@$(call patchin, XORG_APP_XINIT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xinit_prepare: $(STATEDIR)/xorg-app-xinit.prepare

XORG_APP_XINIT_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XINIT_ENV 	:=  $(CROSS_ENV)
XORG_APP_XINIT_MAKEVARS :=  XINITDIR=/etc/X11/xinit \
			RAWCPP=$(COMPILER_PREFIX)cpp
	#FIXME: damm ugly hack, should fix cpp check in configure instead

#
# autoconf
#
XORG_APP_XINIT_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \

#
# if no value is given ignore the "--datadir" switch
#
ifneq ($(call remove_quotes,$(PTXCONF_XORG_DEFAULT_DATA_DIR)),)
	XORG_APP_XINIT_AUTOCONF += --datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)
endif
# startx and xinitrc shall use configfiles out of /etc/X11/xinit
XORG_APP_XINIT_AUTOCONF += --libdir=/etc

# what else is required?
#
# --with-xrdb=XRDB        Path to xrdb
# --with-xmodmap=XMODMAP  Path to xmodmap
# --with-twm=TWM          Path to twm
# --with-xclock=XCLOCK    Path to xclock
# --with-xterm=XTERM      Path to xterm
# --with-xserver=XSERVER  Path to default X server
# --with-xauth=XAUTH      Path to xauth
# --with-xinit=XINIT      Path to xinit
#
$(STATEDIR)/xorg-app-xinit.prepare: $(xorg-app-xinit_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XINIT_DIR)/config.cache)
	cd $(XORG_APP_XINIT_DIR) && \
		$(XORG_APP_XINIT_PATH) $(XORG_APP_XINIT_ENV) \
		./configure $(XORG_APP_XINIT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xinit_compile: $(STATEDIR)/xorg-app-xinit.compile

$(STATEDIR)/xorg-app-xinit.compile: $(xorg-app-xinit_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XINIT_DIR) && $(XORG_APP_XINIT_PATH) $(MAKE) $(XORG_APP_XINIT_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xinit_install: $(STATEDIR)/xorg-app-xinit.install

$(STATEDIR)/xorg-app-xinit.install: $(xorg-app-xinit_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XINIT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xinit_targetinstall: $(STATEDIR)/xorg-app-xinit.targetinstall

$(STATEDIR)/xorg-app-xinit.targetinstall: $(xorg-app-xinit_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xinit)
	@$(call install_fixup,xorg-app-xinit,PACKAGE,xorg-app-xinit)
	@$(call install_fixup,xorg-app-xinit,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xinit,VERSION,$(XORG_APP_XINIT_VERSION))
	@$(call install_fixup,xorg-app-xinit,SECTION,base)
	@$(call install_fixup,xorg-app-xinit,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-app-xinit,DEPENDS,)
	@$(call install_fixup,xorg-app-xinit,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xinit, 0, 0, 0755, $(XORG_APP_XINIT_DIR)/xinit, $(XORG_PREFIX)/bin/xinit)
	@$(call install_copy, xorg-app-xinit, 0, 0, 0755, $(XORG_APP_XINIT_DIR)/startx, $(XORG_PREFIX)/bin/startx, n)
	@$(call install_copy, xorg-app-xinit, 0, 0, 0755, $(XORG_APP_XINIT_DIR)/xinitrc, $(XORG_PREFIX)/lib/X11/xinit/xinitrc, n)

	@$(call install_finish,xorg-app-xinit)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xinit_clean:
	rm -rf $(STATEDIR)/xorg-app-xinit.*
	rm -rf $(PKGDIR)/xorg-app-xinit_*
	rm -rf $(XORG_APP_XINIT_DIR)

# vim: syntax=make
