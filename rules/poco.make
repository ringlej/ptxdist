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
POCO_VERSION	:= 1.4.1p1
POCO_MD5	:= bedcf66df951a6e534a004f18344f385
POCO		:= poco-$(POCO_VERSION)
POCO_SUFFIX	:= tar.gz
POCO_URL	:= $(PTXCONF_SETUP_SFMIRROR)/project/poco/sources/poco-1.4.1/$(POCO).$(POCO_SUFFIX)
POCO_SOURCE	:= $(SRCDIR)/$(POCO).$(POCO_SUFFIX)
POCO_DIR	:= $(BUILDDIR)/$(POCO)
POCO_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(POCO_SOURCE):
	@$(call targetinfo)
	@$(call get, POCO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POCO_PATH	:= PATH=$(CROSS_PATH)
POCO_CONF_ENV	:= $(CROSS_ENV)

$(STATEDIR)/poco.prepare:
	@$(call targetinfo)
	cd $(POCO_DIR) && \
		$(POCO_PATH) $(POCO_ENV) \
		./configure \
			--config=Linux \
			--prefix=/usr \
			--no-tests \
			--no-samples \
			--omit=Data/MySQL,Data/ODBC,Zip \
			--poquito
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
#
$(STATEDIR)/poco.compile:
	@$(call targetinfo)
	cd $(POCO_DIR) && $(POCO_PATH) $(MAKE) \
		$(PARALLELMFLAGS) CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX)
	@$(call touch)

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

	@$(call install_finish, poco)

	@$(call touch)

# vim: syntax=make
