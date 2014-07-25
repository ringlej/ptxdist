# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIGEST_HMAC_PERL) += digest-hmac-perl

#
# Paths and names
#
DIGEST_HMAC_PERL_VERSION	:= 1.03
DIGEST_HMAC_PERL_MD5		:= e6a5d6f552da16eacb5157ea4369ff9d
DIGEST_HMAC_PERL		:= Digest-HMAC-$(DIGEST_HMAC_PERL_VERSION)
DIGEST_HMAC_PERL_SUFFIX		:= tar.gz
DIGEST_HMAC_PERL_URL		:= http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/$(DIGEST_HMAC_PERL).$(DIGEST_HMAC_PERL_SUFFIX)
DIGEST_HMAC_PERL_SOURCE		:= $(SRCDIR)/$(DIGEST_HMAC_PERL).$(DIGEST_HMAC_PERL_SUFFIX)
DIGEST_HMAC_PERL_DIR		:= $(BUILDDIR)/$(DIGEST_HMAC_PERL)
DIGEST_HMAC_PERL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DIGEST_HMAC_PERL_CONF_TOOL	:= perl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/digest-hmac-perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, digest-hmac-perl)
	@$(call install_fixup, digest-hmac-perl,PRIORITY,optional)
	@$(call install_fixup, digest-hmac-perl,SECTION,base)
	@$(call install_fixup, digest-hmac-perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, digest-hmac-perl,DESCRIPTION,missing)

	@$(call install_tree, digest-hmac-perl, 0, 0, -, $(PERL_SITELIB)/Digest)

	@$(call install_finish, digest-hmac-perl)

	@$(call touch)

# vim: syntax=make
