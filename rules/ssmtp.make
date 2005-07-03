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
ifdef PTXCONF_SSMTP
PACKAGES += ssmtp
endif

#
# Paths and names
#
SSMTP_VERSION		= 2.61
SSMTP			= ssmtp-$(SSMTP_VERSION)
SSMTP_SUFFIX		= tar.gz
SSMTP_SRC		= ssmtp_$(SSMTP_VERSION).orig.$(SSMTP_SUFFIX) 
SSMTP_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/s/ssmtp/$(SSMTP_SRC)
SSMTP_SOURCE		= $(SRCDIR)/$(SSMTP_SRC)
SSMTP_DIR		= $(BUILDDIR)/ssmtp-$(SSMTP_VERSION)

SSMTP_PATCH		= 3
SSMTP_PATCH_SRC		= ssmtp_$(SSMTP_VERSION)-$(SSMTP_PATCH).diff.gz
SSMTP_PATCH_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/s/ssmtp/$(SSMTP_PATCH_SRC)
SSMTP_PATCH_SOURCE	= $(SRCDIR)/$(SSMTP_PATCH_SRC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ssmtp_get: $(STATEDIR)/ssmtp.get

ssmtp_get_deps = $(SSMTP_SOURCE) $(SSMTP_PATCH_SOURCE)

$(STATEDIR)/ssmtp.get: $(ssmtp_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(SSMTP))
	touch $@

$(SSMTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SSMTP_URL))

$(SSMTP_PATCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SSMTP_PATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ssmtp_extract: $(STATEDIR)/ssmtp.extract

ssmtp_extract_deps = $(STATEDIR)/ssmtp.get

$(STATEDIR)/ssmtp.extract: $(ssmtp_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SSMTP_DIR))
	@$(call extract, $(SSMTP_SOURCE))
	cd $(SSMTP_DIR) && zcat $(SSMTP_PATCH_SOURCE) | patch -p1
	@$(call patchin, $(SSMTP))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ssmtp_prepare: $(STATEDIR)/ssmtp.prepare

#
# dependencies
#
ssmtp_prepare_deps = \
	$(STATEDIR)/ssmtp.extract \
	$(STATEDIR)/virtual-xchain.install

SSMTP_PATH	=  PATH=$(CROSS_PATH)
SSMTP_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
SSMTP_AUTOCONF =  $(CROSS_AUTOCONF)
SSMTP_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

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

$(STATEDIR)/ssmtp.prepare: $(ssmtp_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SSMTP_DIR)/config.cache)
	cd $(SSMTP_DIR) && \
		$(SSMTP_PATH) $(SSMTP_ENV) \
		./configure $(SSMTP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ssmtp_compile: $(STATEDIR)/ssmtp.compile

ssmtp_compile_deps = $(STATEDIR)/ssmtp.prepare

$(STATEDIR)/ssmtp.compile: $(ssmtp_compile_deps)
	@$(call targetinfo, $@)
	cd $(SSMTP_DIR) && $(SSMTP_ENV) $(SSMTP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ssmtp_install: $(STATEDIR)/ssmtp.install

$(STATEDIR)/ssmtp.install: $(STATEDIR)/ssmtp.compile
	@$(call targetinfo, $@)
#	cd $(SSMTP_DIR) && $(SSMTP_ENV) $(SSMTP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ssmtp_targetinstall: $(STATEDIR)/ssmtp.targetinstall

ssmtp_targetinstall_deps = $(STATEDIR)/ssmtp.compile

$(STATEDIR)/ssmtp.targetinstall: $(ssmtp_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ssmtp)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SSMTP_VERSION)-$(SSMTP_PATCH))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(SSMTP_DIR)/ssmtp, /sbin/ssmtp)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ssmtp_clean:
	rm -rf $(STATEDIR)/ssmtp.*
	rm -rf $(IMAGEDIR)/ssmtp_*
	rm -rf $(SSMTP_DIR)

# vim: syntax=make
