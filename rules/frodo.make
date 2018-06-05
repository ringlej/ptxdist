# -*-makefile-*-
#
# Copyright (C) 2007-2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FRODO) += frodo

#
# Paths and names
#
FRODO_VERSION	:= 4.1b
FRODO_MD5	:= 095b9f21c03204cc13f7f249e8866cd9
FRODO		:= Frodo-$(FRODO_VERSION)
FRODO_SUFFIX	:= Src.tar.gz
FRODO_URL	:= http://frodo.cebix.net/downloads/FrodoV4_1b.$(FRODO_SUFFIX)
FRODO_SOURCE	:= $(SRCDIR)/FrodoV4_1b.$(FRODO_SUFFIX)
FRODO_DIR	:= $(BUILDDIR)/$(FRODO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FRODO_PATH	:= PATH=$(CROSS_PATH)
FRODO_CONF_ENV	:= $(CROSS_ENV)
ifdef PTXCONF_FRODO_SVGALIB
FRODO_CONF_ENV	+= ac_cv_lib_vga_vga_setmode=yes SDL_CONFIG=no
endif
FRODO_MAKE_ENV	:= $(CROSS_ENV)
FRODO_SUBDIR	:= Src
FRODO_CONF_TOOL	:= autoconf

#
# autoconf
#
FRODO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-x

# cpp files are built with gcc
FRODO_CFLAGS := -std=gnu++98

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/frodo.install:
	@$(call targetinfo)
	install -D -m 755 "$(FRODO_DIR)/Src/Frodo" "$(FRODO_PKGDIR)/usr/bin/Frodo"

	install -D -m 644 "$(FRODO_DIR)/1541 ROM" "$(FRODO_PKGDIR)/home/1541 ROM"
	install -D -m 644 "$(FRODO_DIR)/Basic ROM" "$(FRODO_PKGDIR)/home/Basic ROM"
	install -D -m 644 "$(FRODO_DIR)/Char ROM" "$(FRODO_PKGDIR)/home/Char ROM"
	install -D -m 644 "$(FRODO_DIR)/Kernal ROM" "$(FRODO_PKGDIR)/home/Kernal ROM"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/frodo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, frodo)
	@$(call install_fixup, frodo,PRIORITY,optional)
	@$(call install_fixup, frodo,SECTION,base)
	@$(call install_fixup, frodo,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, frodo,DESCRIPTION,missing)

	@$(call install_copy, frodo, 0, 0, 0755, -, /usr/bin/Frodo)

	@$(call install_copy, frodo, 0, 0, 0644, -, /home/1541 ROM)
	@$(call install_copy, frodo, 0, 0, 0644, -, /home/Basic ROM)
	@$(call install_copy, frodo, 0, 0, 0644, -, /home/Char ROM)
	@$(call install_copy, frodo, 0, 0, 0644, -, /home/Kernal ROM)

	@$(call install_alternative, frodo, 0, 0, 0644, /etc/frodorc, n)
	@$(call install_link, frodo, ../etc/frodorc, /home/.frodorc)

	@$(call install_finish, frodo)

	@$(call touch)

# vim: syntax=make
