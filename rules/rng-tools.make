# -*-makefile-*-
#
# Copyright (C) 2014 by Andreas Pretzsch <apr@cn-eng.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_RNG_TOOLS) += rng-tools

RNG_TOOLS_VERSION	:= 5
RNG_TOOLS_MD5		:= 6726cdc6fae1f5122463f24ae980dd68
RNG_TOOLS		:= rng-tools-$(RNG_TOOLS_VERSION)
RNG_TOOLS_SUFFIX	:= tar.gz
RNG_TOOLS_URL		:= $(call ptx/mirror, SF, gkernel/$(RNG_TOOLS).$(RNG_TOOLS_SUFFIX))
RNG_TOOLS_SOURCE	:= $(SRCDIR)/$(RNG_TOOLS).$(RNG_TOOLS_SUFFIX)
RNG_TOOLS_DIR		:= $(BUILDDIR)/$(RNG_TOOLS)
RNG_TOOLS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RNG_TOOLS_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rng-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rng-tools)
	@$(call install_fixup, rng-tools,PRIORITY,optional)
	@$(call install_fixup, rng-tools,SECTION,base)
	@$(call install_fixup, rng-tools,AUTHOR,"Andreas Pretzsch <apr@cn-eng.de>")
	@$(call install_fixup, rng-tools,DESCRIPTION,"random number generator daemon - seed kernel random from hwrng")

	@$(call install_copy, rng-tools, 0, 0, 0755, -, /usr/sbin/rngd)
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_RNG_TOOLS_STARTSCRIPT
	@$(call install_alternative, rng-tools, 0, 0, 0755, /etc/init.d/rngd)
ifneq ($(call remove_quotes,$(PTXCONF_RNG_TOOLS_BBINIT_LINK)),)
	@$(call install_link, rng-tools, \
		../init.d/rngd, \
		/etc/rc.d/$(PTXCONF_RNG_TOOLS_BBINIT_LINK))
endif
endif
endif
ifdef PTXCONF_RNG_TOOLS_SYSTEMD_UNIT
	@$(call install_alternative, rng-tools, 0, 0, 0644, \
		/usr/lib/systemd/system/rngd.service)
	@$(call install_link, rng-tools, ../rngd.service, \
		/usr/lib/systemd/system/basic.target.wants/rngd.service)
endif
ifdef PTXCONF_RNG_TOOLS_RNGTEST
	@$(call install_copy, rng-tools, 0, 0, 0755, -, /usr/bin/rngtest)
endif
	@$(call install_finish, rng-tools)

	@$(call touch)

# vim: syntax=make
