# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LSH) += lsh

#
# Paths and names
#
LSH_VERSION	= 1.5.3
LSH		= lsh-$(LSH_VERSION)
LSH_SUFFIX	= tar.gz
LSH_URL		= http://www.lysator.liu.se/~nisse/archive/$(LSH).$(LSH_SUFFIX)
LSH_SOURCE	= $(SRCDIR)/$(LSH).$(LSH_SUFFIX)
LSH_DIR		= $(BUILDDIR)/$(LSH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lsh_get: $(STATEDIR)/lsh.get

lsh_get_deps = \
	$(LSH_SOURCE) \
	$(STATEDIR)/lsh-patches.get

$(STATEDIR)/lsh.get: $(lsh_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(STATEDIR)/lsh-patches.get:
	@$(call get_patches, $(LSH))
	@$(call touch, $@)

$(LSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LSH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lsh_extract: $(STATEDIR)/lsh.extract

lsh_extract_deps = $(STATEDIR)/lsh.get

$(STATEDIR)/lsh.extract: $(lsh_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LSH_DIR))
	@$(call extract, $(LSH_SOURCE))
	@$(call patchin, $(LSH))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lsh_prepare: $(STATEDIR)/lsh.prepare

#
# dependencies
#
lsh_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.install \
	$(STATEDIR)/gmp3.install \
	$(STATEDIR)/liboop.install \
	$(STATEDIR)/lsh.extract \

LSH_PATH	=  PATH=$(CROSS_PATH)
LSH_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LSH_AUTOCONF =  $(CROSS_AUTOCONF)
LSH_AUTOCONF = \
	--prefix=/usr \
	--sysconfdir=/etc/lsh \
	--disable-kerberos \
	--disable-pam \
	--disable-tcp-forward \
	--disable-x11-forward \
	--disable-agent-forward \
	--disable-ipv6 \
	--disable-utmp \
	--without-system-argp


$(STATEDIR)/lsh.prepare: $(lsh_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LSH_DIR)/config.cache)
	cd $(LSH_DIR) && \
		$(LSH_PATH) $(LSH_ENV) \
		$(LSH_DIR)/configure $(LSH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lsh_compile: $(STATEDIR)/lsh.compile

lsh_compile_deps = $(STATEDIR)/lsh.prepare

$(STATEDIR)/lsh.compile: $(lsh_compile_deps)
	@$(call targetinfo, $@)
	$(LSH_PATH) make -C $(LSH_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lsh_install: $(STATEDIR)/lsh.install

$(STATEDIR)/lsh.install: $(STATEDIR)/lsh.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lsh_targetinstall: $(STATEDIR)/lsh.targetinstall

lsh_targetinstall_deps = \
	$(STATEDIR)/lsh.compile \
	$(STATEDIR)/gmp3.targetinstall \
	$(STATEDIR)/liboop.targetinstall \
	$(STATEDIR)/zlib.targetinstall

$(STATEDIR)/lsh.targetinstall: $(lsh_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,lsh)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LSH_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# FIXME: use build paths
ifdef PTXCONF_LSH_EXECUV
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/sbin/lsh-execuv, /sbin/lsh-execuv)
endif
ifdef PTXCONF_LSH_PROXY
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/sbin/lsh_proxy, /sbin/lsh_proxy)
endif
ifdef PTXCONF_LSH_LSHD
	@$(call install_copy, 0, 0, 0755, $(LSH_DIR)/src/lshd, /sbin/lshd)
endif
ifdef PTXCONF_LSH_SFTPD
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/sbin/sftp-server, /sbin/sftp-server)
endif
ifdef PTXCONF_LSH_MAKESEED
	@$(call install_copy, 0, 0, 0755, $(LSH_DIR)/src/lsh-make-seed, /bin/lsh-make-seed)
endif
ifdef PTXCONF_LSH_WRITEKEY
	@$(call install_copy, 0, 0, 0755, $(LSH_DIR)/src/lsh-writekey, /sbin/lsh-writekey)
endif
ifdef PTXCONF_LSH_KEYGEN
	@$(call install_copy, 0, 0, 0755, $(LSH_DIR)/src/lsh-keygen, /sbin/lsh-keygen)
endif
	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lsh_clean:
	rm -rf $(STATEDIR)/lsh.*
	rm -rf $(IMAGEDIR)/lsh_*
	rm -rf $(LSH_DIR)

# vim: syntax=make
