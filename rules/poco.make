# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POCO) += poco

#
# Paths and names
#
POCO_VERSION	:= 1.6.1
POCO_MD5	:= 8bc6b7dc22a8cbd97257028c02ac2707
POCO		:= poco-$(POCO_VERSION)
POCO_SUFFIX	:= tar.gz
POCO_URL	:= http://pocoproject.org/releases/$(POCO)/$(POCO).$(POCO_SUFFIX)
POCO_SOURCE	:= $(SRCDIR)/$(POCO).$(POCO_SUFFIX)
POCO_DIR	:= $(shell readlink -f "$(BUILDDIR)/$(POCO)")
POCO_LICENSE	:= BSL-1.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POCO_CONF_TOOL	:= autoconf
POCO_CONF_OPT	:= \
	--config=Linux \
	--prefix=/usr \
	--no-tests \
	--no-samples \
	--omit=Data/MySQL,Data/ODBC,Zip \
	--poquito \
	--unbundled \
	--shared

POCO_MAKE_ENV	:= \
	$(CROSS_ENV) \
	CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX) \
	POCO_TARGET_OSNAME=Linux \
	POCO_TARGET_OSARCH=$(PTXCONF_ARCH_STRING)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/poco.targetinstall:
	@$(call targetinfo)

	@$(call install_init, poco)
	@$(call install_fixup, poco,PRIORITY,optional)
	@$(call install_fixup, poco,SECTION,base)
	@$(call install_fixup, poco,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, poco,DESCRIPTION,missing)

	@$(call install_lib, poco, 0, 0, 0644, libPocoUtil)
	@$(call install_lib, poco, 0, 0, 0644, libPocoXML)
	@$(call install_lib, poco, 0, 0, 0644, libPocoNet)
	@$(call install_lib, poco, 0, 0, 0644, libPocoFoundation)
	@$(call install_lib, poco, 0, 0, 0644, libPocoJSON)

	@$(call install_finish, poco)

	@$(call touch)

# vim: syntax=make
