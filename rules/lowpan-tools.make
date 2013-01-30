# -*-makefile-*-
#
# Copyright (C) 2012 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LOWPAN_TOOLS) += lowpan-tools

#
# Paths and names
#
LOWPAN_TOOLS_VERSION	:= 0.3
LOWPAN_TOOLS_MD5	:= 564bdf163de5b33232d751383495a65c
LOWPAN_TOOLS		:= lowpan-tools-$(LOWPAN_TOOLS_VERSION)
LOWPAN_TOOLS_SUFFIX	:= tar.gz
LOWPAN_TOOLS_URL	:= $(call ptx/mirror, SF, linux-zigbee/$(LOWPAN_TOOLS).$(LOWPAN_TOOLS_SUFFIX))
LOWPAN_TOOLS_SOURCE	:= $(SRCDIR)/$(LOWPAN_TOOLS).$(LOWPAN_TOOLS_SUFFIX)
LOWPAN_TOOLS_DIR	:= $(BUILDDIR)/$(LOWPAN_TOOLS)
LOWPAN_TOOLS_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LOWPAN_TOOLS_CONF_ENV = \
	$(CROSS_ENV)

ifdef PTXCONF_LOWPAN_TOOLS_TESTS
LOWPAN_TOOLS_CONF_ENV += ac_cv_path_PYTHON=$(CROSS_PYTHON)
else
LOWPAN_TOOLS_CONF_ENV += ac_cv_path_PYTHON=:
endif

#
# autoconf
#
LOWPAN_TOOLS_CONF_TOOL	:= autoconf
LOWPAN_TOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-manpages \
	--enable-shared \
	--disable-static \
	--with-gnu-ld

LOWPAN_TOOLS_INSTALL_FILES := \
        gnl izlisten listen-packet test1 test2 test3 test4 test5 \
        test6 test7 test_edscan.py test_packets.py test_recv.py \
        test_trx.py

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lowpan-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lowpan-tools)
	@$(call install_fixup, lowpan-tools,PRIORITY,optional)
	@$(call install_fixup, lowpan-tools,SECTION,base)
	@$(call install_fixup, lowpan-tools,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, lowpan-tools,DESCRIPTION,missing)

	@$(call install_copy, lowpan-tools, 0, 0, 0755, -, /usr/bin/izchat)
	@$(call install_copy, lowpan-tools, 0, 0, 0755, -, /usr/sbin/iz)
	@$(call install_copy, lowpan-tools, 0, 0, 0755, -, /usr/sbin/izattach)
	@$(call install_copy, lowpan-tools, 0, 0, 0755, -, /usr/sbin/izcoordinator)

ifdef PTXCONF_LOWPAN_TOOLS_TESTS
	@$(call install_copy, lowpan-tools, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/test_DQ.pyc)
	
	@$(foreach tool,$(LOWPAN_TOOLS_INSTALL_FILES), \
		$(call install_copy, lowpan-tools, 0, 0, 0755, -, \
		/usr/libexec/lowpan-tools/$(tool));)
endif

	@$(call install_finish, lowpan-tools)

	@$(call touch)

# vim: syntax=make
