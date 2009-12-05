# -*-makefile-*-
# $Id:$
#
# Copyright (C) 2005 by Steven Scholz <steven.scholz@imc-berlin.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SSMTP) += ssmtp

#
# Paths and names
#
SSMTP_VERSION		= 2.64
SSMTP			= ssmtp-$(SSMTP_VERSION)
SSMTP_SUFFIX		= tar.bz2
SSMTP_SRC		= ssmtp_$(SSMTP_VERSION).orig.$(SSMTP_SUFFIX)
SSMTP_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/s/ssmtp/$(SSMTP_SRC)
SSMTP_SOURCE		= $(SRCDIR)/$(SSMTP_SRC)
SSMTP_DIR		= $(BUILDDIR)/ssmtp-$(SSMTP_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ssmtp_get: $(STATEDIR)/ssmtp.get

$(STATEDIR)/ssmtp.get: $(ssmtp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SSMTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SSMTP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ssmtp_extract: $(STATEDIR)/ssmtp.extract

$(STATEDIR)/ssmtp.extract: $(ssmtp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SSMTP_DIR))
	@$(call extract, SSMTP)
	@$(call patchin, SSMTP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ssmtp_prepare: $(STATEDIR)/ssmtp.prepare

SSMTP_PATH	=  PATH=$(CROSS_PATH)
SSMTP_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
SSMTP_AUTOCONF =  $(CROSS_AUTOCONF_USR)

ifndef PTXCONF_SSMTP_REWRITE_DOMAIN
SSMTP_AUTOCONF  += --disable-rewrite-domain
endif

ifdef PTXCONF_SSMTP_SSL
SSMTP_AUTOCONF  += --enable-ssl
endif

ifdef PTXCONF_SSMTP_INET6
SSMTP_AUTOCONF  += --enable-inet6
endif

ifdef PTXCONF_SSMTP_MD5AUTH
SSMTP_AUTOCONF  += --enable-md5auth
endif

$(STATEDIR)/ssmtp.prepare: $(ssmtp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SSMTP_DIR)/config.cache)
	cd $(SSMTP_DIR) && \
		$(SSMTP_PATH) $(SSMTP_ENV) \
		./configure $(SSMTP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ssmtp_compile: $(STATEDIR)/ssmtp.compile

$(STATEDIR)/ssmtp.compile: $(ssmtp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SSMTP_DIR) && \
		$(SSMTP_ENV) $(SSMTP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ssmtp_install: $(STATEDIR)/ssmtp.install

$(STATEDIR)/ssmtp.install: $(ssmtp_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, SSMTP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ssmtp_targetinstall: $(STATEDIR)/ssmtp.targetinstall

$(STATEDIR)/ssmtp.targetinstall: $(ssmtp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  ssmtp)
	@$(call install_fixup, ssmtp,PACKAGE,ssmtp)
	@$(call install_fixup, ssmtp,PRIORITY,optional)
	@$(call install_fixup, ssmtp,VERSION,$(SSMTP_VERSION))
	@$(call install_fixup, ssmtp,SECTION,base)
	@$(call install_fixup, ssmtp,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ssmtp,DEPENDS,)
	@$(call install_fixup, ssmtp,DESCRIPTION,missing)

	@$(call install_copy, ssmtp, 0, 0, 0755, $(SSMTP_DIR)/ssmtp, /sbin/ssmtp)

	@$(call install_finish, ssmtp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ssmtp_clean:
	rm -rf $(STATEDIR)/ssmtp.*
	rm -rf $(PKGDIR)/ssmtp_*
	rm -rf $(SSMTP_DIR)

# vim: syntax=make
