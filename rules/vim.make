# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VIM) += vim

#
# Paths and names
#
VIM_VERSION	:= 8.1
VIM_MD5		:= 1739a1df312305155285f0cfa6118294
VIM		:= vim-$(VIM_VERSION)
VIM_SUFFIX	:= tar.bz2
VIM_URL		:= ftp://ftp.vim.org/pub/vim/unix/$(VIM).$(VIM_SUFFIX)
VIM_SOURCE	:= $(SRCDIR)/$(VIM).$(VIM_SUFFIX)
VIM_DIR		:= $(BUILDDIR)/$(VIM)
VIM_SUBDIR	:= src
VIM_LICENSE	:= Vim

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VIM_CONF_ENV	:= \
	$(CROSS_ENV) \
	vim_cv_toupper_broken=no \
	vim_cv_terminfo=yes \
	vim_cv_tgetent=zero \
	vim_cv_tty_group=world \
	vim_cv_tty_mode=0620 \
	vim_cv_getcwd_broken=no \
	vim_cv_stat_ignores_slash=no \
	vim_cv_memmove_handles_overlap=yes

#
# autoconf
#
VIM_CONF_TOOL	:= autoconf
VIM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-fail-if-missing \
	--disable-darwin \
	--disable-smack \
	--disable-selinux \
	--disable-xsmp \
	--disable-xsmp-interact \
	--disable-luainterp \
	--disable-mzschemeinterp \
	--disable-perlinterp \
	--disable-pythoninterp \
	--disable-python3interp \
	--disable-tclinterp \
	--disable-rubyinterp \
	--disable-cscope \
	--disable-workshop \
	--disable-netbeans \
	--disable-channel \
	--disable-terminal \
	--disable-autoservername \
	--disable-multibyte \
	--disable-hangulinput \
	--disable-xim \
	--disable-fontset \
	--disable-gui \
	--disable-gtk2-check \
	--disable-gnome-check \
	--disable-gtk3-check \
	--disable-motif-check \
	--disable-athena-check \
	--disable-nextaw-check \
	--disable-carbon-check \
	--disable-gtktest \
	--disable-icon-cache-update \
	--disable-desktop-database-update \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-acl \
	--disable-gpm \
	--disable-sysmouse \
	--disable-nls \
	--without-x \
	--with-tlib=ncurses

VIM_INSTALL_OPT := \
	installvimbin \
	installrtbase \
	installmacros \
	installspell

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

VIM_LINKS := ex rview rvim view vimdiff

$(STATEDIR)/vim.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vim)
	@$(call install_fixup, vim,PRIORITY,optional)
	@$(call install_fixup, vim,SECTION,base)
	@$(call install_fixup, vim,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, vim,DESCRIPTION,missing)

	@$(call install_copy, vim, 0, 0, 0755, -, /usr/bin/vim)

	@$(foreach link, $(VIM_LINKS), \
		$(call install_link, vim, vim, /usr/bin/$(link));)

	@$(call install_tree, vim, 0, 0, -, /usr/share/vim)

	@$(call install_finish, vim)

	@$(call touch)

# vim: syntax=make
