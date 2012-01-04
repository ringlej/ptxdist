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
PACKAGES-$(PTXCONF_LIBURCU) += liburcu

#
# Paths and names
#
LIBURCU_VERSION	:= 0.6.7
LIBURCU_MD5	:= 2705dadd65beda8e8960472c082e44b3
LIBURCU		:= userspace-rcu-$(LIBURCU_VERSION)
LIBURCU_SUFFIX	:= tar.bz2
LIBURCU_URL	:= http://lttng.org/files/urcu/$(LIBURCU).$(LIBURCU_SUFFIX)
LIBURCU_SOURCE	:= $(SRCDIR)/$(LIBURCU).$(LIBURCU_SUFFIX)
LIBURCU_DIR	:= $(BUILDDIR)/$(LIBURCU)
LIBURCU_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBURCU_CONF_TOOL	:= autoconf
LIBURCU_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--$(call ptx/endis, PTXCONF_LIBURCU_SMP)-smp-support

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liburcu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liburcu)
	@$(call install_fixup, liburcu,PRIORITY,optional)
	@$(call install_fixup, liburcu,SECTION,base)
	@$(call install_fixup, liburcu,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, liburcu,DESCRIPTION,"Userspace RCU")

	@$(call install_lib, liburcu, 0, 0, 0644, liburcu)
	@$(call install_lib, liburcu, 0, 0, 0644, liburcu-bp)
	@$(call install_lib, liburcu, 0, 0, 0644, liburcu-cds)
	@$(call install_lib, liburcu, 0, 0, 0644, liburcu-common)
	@$(call install_lib, liburcu, 0, 0, 0644, liburcu-mb)
	@$(call install_lib, liburcu, 0, 0, 0644, liburcu-qsbr)
	@$(call install_lib, liburcu, 0, 0, 0644, liburcu-signal)

	@$(call install_finish, liburcu)

	@$(call touch)

# vim: syntax=make
