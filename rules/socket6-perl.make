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
PACKAGES-$(PTXCONF_SOCKET6_PERL) += socket6-perl

#
# Paths and names
#
SOCKET6_PERL_VERSION	:= 0.25
SOCKET6_PERL_MD5	:= e6c40d662b1fc5ffd436b7f50daa1f04
SOCKET6_PERL		:= Socket6-$(SOCKET6_PERL_VERSION)
SOCKET6_PERL_SUFFIX	:= tar.gz
SOCKET6_PERL_URL	:= http://cpan.metacpan.org/authors/id/U/UM/UMEMOTO/$(SOCKET6_PERL).$(SOCKET6_PERL_SUFFIX)
SOCKET6_PERL_SOURCE	:= $(SRCDIR)/$(SOCKET6_PERL).$(SOCKET6_PERL_SUFFIX)
SOCKET6_PERL_DIR	:= $(BUILDDIR)/$(SOCKET6_PERL)
SOCKET6_PERL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SOCKET6_PERL_CONF_ENV	= \
	$(CROSS_ENV) \
	CONFIGURE_ARGS="$(CROSS_AUTOCONF_USR)" \
	ac_cv_path_perl=/usr/bin/perl \
	socket6_cv_pl_sv_undef=yes

SOCKET6_PERL_CONF_TOOL	:= perl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/socket6-perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, socket6-perl)
	@$(call install_fixup, socket6-perl,PRIORITY,optional)
	@$(call install_fixup, socket6-perl,SECTION,base)
	@$(call install_fixup, socket6-perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, socket6-perl,DESCRIPTION,missing)

	@$(call install_tree, socket6-perl, 0, 0, -, $(PERL_SITELIB))

	@$(call install_finish, socket6-perl)

	@$(call touch)

# vim: syntax=make
