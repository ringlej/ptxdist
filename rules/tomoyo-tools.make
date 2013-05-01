# -*-makefile-*-
#
# Copyright (C) 2013 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TOMOYO_TOOLS) += tomoyo-tools

#
# Paths and names
#
TOMOYO_TOOLS_VERSION	:= 2.5.0-20130406
TOMOYO_TOOLS_MD5	:= 8888f83fcb87823d714ff551e8680d0d
TOMOYO_TOOLS		:= tomoyo-tools-$(TOMOYO_TOOLS_VERSION)
TOMOYO_TOOLS_SUFFIX	:= tar.gz
TOMOYO_TOOLS_URL	:= http://sourceforge.jp/frs/redir.php?m=jaist&f=/tomoyo/53357/$(TOMOYO_TOOLS).$(TOMOYO_TOOLS_SUFFIX)
TOMOYO_TOOLS_SOURCE	:= $(SRCDIR)/$(TOMOYO_TOOLS).$(TOMOYO_TOOLS_SUFFIX)
TOMOYO_TOOLS_DIR	:= $(BUILDDIR)/tomoyo-tools
TOMOYO_TOOLS_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TOMOYO_TOOLS_CONF_TOOL	:= NO
TOMOYO_TOOLS_MAKE_ENV	:= $(CROSS_ENV) INSTALLDIR=$(TOMOYO_TOOLS_PKGDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

TOMOYO_TOOLS_SBIN_PROGS := \
	tomoyo-auditd \
	tomoyo-checkpolicy \
	tomoyo-diffpolicy \
	tomoyo-domainmatch \
	tomoyo-editpolicy \
	tomoyo-findtemp \
	tomoyo-loadpolicy \
	tomoyo-notifyd \
	tomoyo-patternize \
	tomoyo-pstree \
	tomoyo-queryd \
	tomoyo-savepolicy \
	tomoyo-selectpolicy \
	tomoyo-setlevel \
	tomoyo-setprofile \
	tomoyo-sortpolicy

TOMOYO_TOOLS_LIBEXEC_PROGS := \
	audit-exec-param \
	convert-audit-log \
	convert-exec-param \
	init_policy \
	tomoyo-editpolicy-agent


$(STATEDIR)/tomoyo-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tomoyo-tools)
	@$(call install_fixup, tomoyo-tools,PRIORITY,optional)
	@$(call install_fixup, tomoyo-tools,SECTION,base)
	@$(call install_fixup, tomoyo-tools,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, tomoyo-tools,DESCRIPTION,missing)

	@$(call install_copy, tomoyo-tools, 0, 0, 0755, -, /sbin/tomoyo-init)

	@$(foreach prog, $(TOMOYO_TOOLS_SBIN_PROGS), \
		$(call install_copy, tomoyo-tools, 0, 0, 0755, -, /usr/sbin/$(prog));)

	@$(foreach prog, $(TOMOYO_TOOLS_LIBEXEC_PROGS), \
		$(call install_copy, tomoyo-tools, 0, 0, 0755, -, /usr/lib/tomoyo/$(prog));)

	@$(call install_lib, tomoyo-tools, 0, 0, 0644, libtomoyotools)

	@$(call install_finish, tomoyo-tools)

	@$(call touch)

# vim: syntax=make
