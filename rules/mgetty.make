# -*-makefile-*-
#
# Copyright (C) 2003 by BSP
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MGETTY) += mgetty

#
# Paths and names
#
MGETTY_VERSION	:= 1.1.36
MGETTY_MD5	:= 0320e98c6b86bcca48fc5f355b94ead4
MGETTY_DATE	:= Jun15
MGETTY		:= mgetty-$(MGETTY_VERSION)
MGETTY_SUFFIX	:= tar.gz
MGETTY_URL	:= ftp://alpha.greenie.net/pub/mgetty/source/1.1/mgetty$(MGETTY_VERSION)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_SOURCE	:= $(SRCDIR)/mgetty$(MGETTY_VERSION)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_DIR	:= $(BUILDDIR)/$(MGETTY)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MGETTY_SOURCE):
	@$(call targetinfo)
	@$(call get, MGETTY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/mgetty.prepare:
	@$(call targetinfo)
	cp $(PTXCONF_MGETTY_CONFIG) $(MGETTY_DIR)/policy.h
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MGETTY_DIRS	:= \
	prefix=/usr \
	CONFDIR=/etc/mgetty+sendfax

MGETTY_MAKE_PAR	:= NO
MGETTY_MAKE_OPT	:= \
	$(CROSS_ENV) \
	$(MGETTY_DIRS) \
	bin-all \
	mgetty.config \
	login.config \
	sendfax.config

$(STATEDIR)/mgetty.compile:
	@$(call targetinfo)
# FIXME: mol: this should be a host-tool
	cd $(MGETTY_DIR) && make mksed
	@$(call world/compile, MGETTY)
	@$(call touch)

MGETTY_INSTALL_OPT := install.bin $(MGETTY_DIRS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mgetty.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mgetty)
	@$(call install_fixup, mgetty,PRIORITY,optional)
	@$(call install_fixup, mgetty,SECTION,base)
	@$(call install_fixup, mgetty,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mgetty,DESCRIPTION,missing)

	@$(call install_copy, mgetty, 0, 0, 0700, -, /usr/sbin/mgetty)

ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, mgetty, 0, 0, 0600, -, /etc/mgetty+sendfax/login.config, n)
	@$(call install_copy, mgetty, 0, 0, 0600, -, /etc/mgetty+sendfax/mgetty.config, n)
	@$(call install_copy, mgetty, 0, 0, 0600, -, /etc/mgetty+sendfax/dialin.config, n)
endif
ifdef PTXCONF_MGETTY_CALLBACK
	@$(call install_copy, mgetty, 0, 0, 4755, -, /usr/sbin/callback)
endif
ifdef PTXCONF_SENDFAX
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/sbin/sendfax)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/bin/pbm2g3)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/bin/g3cat)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/bin/g32pbm)
ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, mgetty, 0, 0, 0644, -, /etc/mgetty+sendfax/sendfax.config, n)
endif
ifdef PTXCONF_SENDFAX_SPOOL
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/bin/faxspool, n)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/bin/faxrunq, n)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/bin/faxq, n)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/bin/faxrm, n)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/sbin/faxrunqd, n)
	@$(call install_copy, mgetty, 0, 0, 0755, -, /usr/lib/mgetty+sendfax/faxq-helper)
endif
ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, mgetty, 0, 0, 0644, -, /etc/mgetty+sendfax/faxrunq.config, n)
endif
endif
	@$(call install_finish, mgetty)

	@$(call touch)

# vim: syntax=make
