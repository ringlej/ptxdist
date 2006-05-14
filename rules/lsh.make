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
LSH_VERSION	= 2.0.1
LSH		= lsh-$(LSH_VERSION)
LSH_SUFFIX	= tar.gz
LSH_URL		= http://www.lysator.liu.se/~nisse/archive/$(LSH).$(LSH_SUFFIX)
LSH_SOURCE	= $(SRCDIR)/$(LSH).$(LSH_SUFFIX)
LSH_DIR		= $(BUILDDIR)/$(LSH)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lsh_get: $(STATEDIR)/lsh.get

$(STATEDIR)/lsh.get: $(lsh_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LSH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lsh_extract: $(STATEDIR)/lsh.extract

$(STATEDIR)/lsh.extract: $(lsh_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LSH_DIR))
	@$(call extract, LSH)
	@$(call patchin, $(LSH))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lsh_prepare: $(STATEDIR)/lsh.prepare

LSH_PATH	=  PATH=$(CROSS_PATH)
LSH_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LSH_AUTOCONF =  $(CROSS_AUTOCONF_USR)
LSH_AUTOCONF += \
	--sysconfdir=/etc/lsh \
	--disable-kerberos \
	--disable-pam \
	--disable-tcp-forward \
	--disable-x11-forward \
	--disable-agent-forward \
	--disable-ipv6 \
	--disable-utmp \
	--without-system-argp


$(STATEDIR)/lsh.prepare: $(lsh_prepare_deps_default)
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

$(STATEDIR)/lsh.compile: $(lsh_compile_deps_default)
	@$(call targetinfo, $@)
	$(LSH_PATH) make -C $(LSH_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lsh_install: $(STATEDIR)/lsh.install

$(STATEDIR)/lsh.install: $(lsh_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lsh_targetinstall: $(STATEDIR)/lsh.targetinstall

$(STATEDIR)/lsh.targetinstall: $(lsh_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, lsh)
	@$(call install_fixup, lsh,PACKAGE,lsh)
	@$(call install_fixup, lsh,PRIORITY,optional)
	@$(call install_fixup, lsh,VERSION,$(LSH_VERSION))
	@$(call install_fixup, lsh,SECTION,base)
	@$(call install_fixup, lsh,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, lsh,DEPENDS,)
	@$(call install_fixup, lsh,DESCRIPTION,missing)

ifdef PTXCONF_LSH_EXECUV
	@$(call install_copy, lsh, 0, 0, 0755, $(LSH_DIR)/src/lsh-execuv, /sbin/lsh-execuv)
endif
ifdef PTXCONF_LSH_LSHD
	@$(call install_copy, lsh, 0, 0, 0755, $(LSH_DIR)/src/lshd, /sbin/lshd)
endif
ifdef PTXCONF_LSH_SFTPD
	@$(call install_copy, lsh, 0, 0, 0755, $(LSH_DIR)/src/sftp/sftp-server, /sbin/sftp-server)
endif
ifdef PTXCONF_LSH_MAKESEED
	@$(call install_copy, lsh, 0, 0, 0755, $(LSH_DIR)/src/lsh-make-seed, /bin/lsh-make-seed)
endif
ifdef PTXCONF_LSH_WRITEKEY
	@$(call install_copy, lsh, 0, 0, 0755, $(LSH_DIR)/src/lsh-writekey, /sbin/lsh-writekey)
endif
ifdef PTXCONF_LSH_KEYGEN
	@$(call install_copy, lsh, 0, 0, 0755, $(LSH_DIR)/src/lsh-keygen, /sbin/lsh-keygen)
endif
	@$(call install_finish, lsh)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lsh_clean:
	rm -rf $(STATEDIR)/lsh.*
	rm -rf $(IMAGEDIR)/lsh_*
	rm -rf $(LSH_DIR)

# vim: syntax=make
