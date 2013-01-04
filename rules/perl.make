# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PERL) += perl

#
# Paths and names
#
PERL_VERSION		:= 5.14.2
PERL_MD5		:= 3306fbaf976dcebdcd49b2ac0be00eb9
PERL			:= perl-$(PERL_VERSION)
PERL_SUFFIX		:= tar.gz
PERL_URL		:= http://cpan.perl.org/src/5.0/$(PERL).$(PERL_SUFFIX)
PERL_SOURCE		:= $(SRCDIR)/$(PERL).$(PERL_SUFFIX)
PERL_DIR		:= $(BUILDDIR)/$(PERL)
PERL_LICENSE		:= unknown

PERLCROSS_VERSION	:= 5.14.2-cross-0.6.5
PERLCROSS_MD5		:= 9380c4e33f74a7da2c8fb527e1747b09
PERLCROSS_URL		:= http://download.berlios.de/perlcross/perl-$(PERLCROSS_VERSION).tar.gz
PERLCROSS_SOURCE	:= $(SRCDIR)/perlcross-$(PERLCROSS_VERSION).tar.gz
$(PERLCROSS_SOURCE)	:= PERLCROSS
PERLCROSS_DIR		:= $(PERL_DIR)

PERL_SOURCES		:= $(PERL_SOURCE) $(PERLCROSS_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/perl.extract:
	@$(call targetinfo)
	@$(call clean, $(PERL_DIR))
	@$(call extract, PERL)
	@$(call extract, PERLCROSS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PERL_CONF_TOOL	:= autoconf
PERL_CONF_OPT	:= \
	--prefix=/usr \
	$(CROSS_AUTOCONF_ARCH) \
	--target=$(PTXCONF_GNU_TARGET) \
	--set-ld=$(CROSS_CC)

PERL_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------


PERL_PROGRAMS := \
	a2p \
	c2ph \
	config_data \
	corelist \
	dprofpp \
	enc2xs \
	find2perl \
	h2ph \
	h2xs \
	instmodsh \
	libnetcfg \
	perl \
	perl5.12.3 \
	perlivp \
	perlthanks \
	piconv \
	pl2pm \
	prove \
	psed \
	pstruct \
	ptar \
	ptardiff \
	s2p \
	shasum \
	splain \
	xsubpp

$(STATEDIR)/perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, perl)
	@$(call install_fixup, perl,PRIORITY,optional)
	@$(call install_fixup, perl,SECTION,base)
	@$(call install_fixup, perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, perl,DESCRIPTION,missing)

	@$(foreach prog, $(PERL_PROGRAMS), \
		$(call install_copy, perl, 0, 0, 0755, -, /usr/bin/$(prog));)

	@$(call install_tree, perl, 0, 0, -, /usr/lib/perl)

	@$(call install_finish, perl)

	@$(call touch)

# vim: syntax=make
