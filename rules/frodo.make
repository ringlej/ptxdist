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
FRODO		:= Frodo-$(FRODO_VERSION)
FRODO_SUFFIX	:= Src.tar.gz
FRODO_URL	:= http://frodo.cebix.net/downloads/FrodoV4_1b.$(FRODO_SUFFIX)
FRODO_SOURCE	:= $(SRCDIR)/FrodoV4_1b.$(FRODO_SUFFIX)
FRODO_DIR	:= $(BUILDDIR)/$(FRODO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FRODO_SOURCE):
	@$(call targetinfo)
	@$(call get, FRODO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FRODO_PATH	:= PATH=$(CROSS_PATH)
FRODO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FRODO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-x

$(STATEDIR)/frodo.prepare:
	@$(call targetinfo)
	@$(call clean, $(FRODO_DIR)/config.cache)
	cd $(FRODO_DIR)/Src && \
		$(FRODO_PATH) $(FRODO_ENV) \
		./configure $(FRODO_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/frodo.compile:
	@$(call targetinfo)
	cd $(FRODO_DIR)/Src && $(FRODO_ENV) $(FRODO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/frodo.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/frodo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, frodo)
	@$(call install_fixup, frodo,PACKAGE,frodo)
	@$(call install_fixup, frodo,PRIORITY,optional)
	@$(call install_fixup, frodo,VERSION,$(FRODO_VERSION))
	@$(call install_fixup, frodo,SECTION,base)
	@$(call install_fixup, frodo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, frodo,DEPENDS,)
	@$(call install_fixup, frodo,DESCRIPTION,missing)

	@$(call install_copy, frodo, 0, 0, 0755, $(FRODO_DIR)/Src/Frodo, /usr/bin/Frodo)

	@$(call install_copy, frodo, 0, 0, 0644, $(FRODO_DIR)/1541 ROM, /home/1541 ROM, n)
	@$(call install_copy, frodo, 0, 0, 0644, $(FRODO_DIR)/Basic ROM, /home/Basic ROM, n)
	@$(call install_copy, frodo, 0, 0, 0644, $(FRODO_DIR)/Char ROM, /home/Char ROM, n)
	@$(call install_copy, frodo, 0, 0, 0644, $(FRODO_DIR)/Kernal ROM, /home/Kernal ROM, n)

	@$(call install_alternative, frodo, 0, 0, 0644, /etc/frodorc, n)
	@$(call install_link, frodo, ../etc/frodorc, /home/.frodorc)

	@$(call install_finish, frodo)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

frodo_clean:
	rm -rf $(STATEDIR)/frodo.*
	rm -rf $(PKGDIR)/frodo_*
	rm -rf $(FRODO_DIR)

# vim: syntax=make
