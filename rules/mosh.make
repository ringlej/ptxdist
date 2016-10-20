# -*-makefile-*-
#
# Copyright (C) 2015 Dr. Neuhaus Telekommunikation GmbH, Hamburg Germany,  Oliver Graute <oliver.graute@neuhaus.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MOSH) += mosh

#
# Paths and names
#
MOSH_VERSION	:= 1.2.6
MOSH_MD5	:= bb4e24795bb135a754558176a981ee9e
MOSH		:= mosh-$(MOSH_VERSION)
MOSH_SUFFIX	:= tar.gz
MOSH_URL	:= https://mosh.mit.edu/$(MOSH).$(MOSH_SUFFIX)
MOSH_SOURCE	:= $(SRCDIR)/$(MOSH).$(MOSH_SUFFIX)
MOSH_DIR	:= $(BUILDDIR)/$(MOSH)
MOSH_LICENSE	:= GPL-3.0

#
# autoconf
#
MOSH_CONF_TOOL	:= autoconf
MOSH_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-hardening \
	--enable-client \
	--enable-server \
	--disable-examples \
	--disable-ufw \
	--disable-completion \
	--without-utempter

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mosh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mosh)
	@$(call install_fixup, mosh,PRIORITY,optional)
	@$(call install_fixup, mosh,SECTION,base)
	@$(call install_fixup, mosh,AUTHOR,"<Oliver Graute@neuhaus.de>")
	@$(call install_fixup, mosh,DESCRIPTION,missing)

	@$(call install_copy, mosh, 0, 0, 0755, -, /usr/bin/mosh)
	@$(call install_copy, mosh, 0, 0, 0755, -, /usr/bin/mosh-server)
	@$(call install_copy, mosh, 0, 0, 0755, -, /usr/bin/mosh-client)

	@$(call install_finish, mosh)

	@$(call touch)

# vim: syntax=make
