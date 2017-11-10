# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_JDK) += host-system-jdk
HOST_SYSTEM_JDK_LICENSE := ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-system-jdk.prepare:
	@$(call targetinfo)
	@echo "Checking Java SDK ..."
	@test "$(PTXCONF_SETUP_JAVA_SDK)" != "/usr" || \
		ptxd_bailout "SETUP_JAVA_SDK must not be '/usr'. \
	Please run 'ptxdist setup' to change this."
	@echo "Checking for javac ..."
	@test -x $(PTXCONF_SETUP_JAVA_SDK)/bin/javac || \
		ptxd_bailout "'$(PTXCONF_SETUP_JAVA_SDK)' is not a valid Java SDK. \
	Please run 'ptxdist setup' to change this."
ifdef PTXCONF_HOST_SYSTEM_JDK_ANT
	@echo "Checking for ant ..."
	@ant -h >/dev/null 2>&1 || \
		ptxd_bailout "'ant' not found! Please install.";
endif
	@echo
	@$(call touch)

# vim: syntax=make
