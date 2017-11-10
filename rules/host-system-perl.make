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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PERL) += host-system-perl
HOST_SYSTEM_PERL_LICENSE = ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-system-perl.prepare:
	@$(call targetinfo)
	@echo "Checking for Perl ..."
	@perl -v >/dev/null 2>&1 || \
		ptxd_bailout "'perl' not found! Please install.";
ifdef PTXCONF_HOST_SYSTEM_PERL_BUILD
	@echo "Checking for Perl: Module::Build"
	@perl -e "require Module::Build" 2>/dev/null || \
		ptxd_bailout "Module::Build perl module is required. \
	Please install libmodule-build-perl (debian)."
endif
ifdef PTXCONF_HOST_SYSTEM_PERL_JSON
	@echo "Checking for Perl: JSON"
	@perl -e "require JSON" 2>/dev/null || \
		ptxd_bailout "JSON perl module is required. \
	Please install libjson-perl (debian)."
endif
ifdef PTXCONF_HOST_SYSTEM_PERL_LOCALE_PO
	@echo "Checking for Perl: Locale::PO"
	@perl -e "require Locale::PO" 2>/dev/null || \
		ptxd_bailout "Locale::PO perl module is required. \
	Please install liblocale-po-perl (debian)."
endif
ifdef PTXCONF_HOST_SYSTEM_PERL_XMLPARSER
	@echo "Checking for Perl: XML::Parser"
	@perl -e "require XML::Parser" 2>/dev/null || \
		ptxd_bailout "XML::Parser perl module is required. \
	Please install libxml-parser-perl (debian)."
endif
	@echo
	@$(call touch)

# vim: syntax=make
