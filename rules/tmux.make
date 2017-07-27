# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TMUX) += tmux

#
# Paths and names
#
TMUX_VERSION	:= 2.5
TMUX_MD5	:= 4a5d73d96d8f11b0bdf9b6f15ab76d15
TMUX		:= tmux-$(TMUX_VERSION)
TMUX_SUFFIX	:= tar.gz
TMUX_URL	:= https://github.com/tmux/tmux/releases/download/$(TMUX_VERSION)/$(TMUX).$(TMUX_SUFFIX)
TMUX_SOURCE	:= $(SRCDIR)/$(TMUX).$(TMUX_SUFFIX)
TMUX_DIR	:= $(BUILDDIR)/$(TMUX)
TMUX_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TMUX_CONF_TOOL	:= autoconf
TMUX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-static \
	--disable-utempter \
	--disable-utf8proc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tmux.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tmux)
	@$(call install_fixup, tmux,PRIORITY,optional)
	@$(call install_fixup, tmux,SECTION,base)
	@$(call install_fixup, tmux,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, tmux,DESCRIPTION,missing)

	@$(call install_copy, tmux, 0, 0, 0755, -, /usr/bin/tmux)

	@$(call install_finish, tmux)

	@$(call touch)

# vim: syntax=make
