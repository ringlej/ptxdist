# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SUDO) += sudo

#
# Paths and names
#
SUDO_VERSION	= 1.6.9
SUDO		= sudo-$(SUDO_VERSION)
SUDO_SUFFIX	= tar.gz
SUDO_URL	= http://www.courtesan.com/sudo/dist/OLD/$(SUDO).$(SUDO_SUFFIX)
SUDO_SOURCE	= $(SRCDIR)/$(SUDO).$(SUDO_SUFFIX)
SUDO_DIR	= $(BUILDDIR)/$(SUDO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sudo_get: $(STATEDIR)/sudo.get

$(STATEDIR)/sudo.get: $(sudo_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SUDO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SUDO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sudo_extract: $(STATEDIR)/sudo.extract

$(STATEDIR)/sudo.extract: $(sudo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SUDO_DIR))
	@$(call extract, SUDO)
	@$(call patchin, SUDO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sudo_prepare: $(STATEDIR)/sudo.prepare

SUDO_PATH	=  PATH=$(CROSS_PATH)
SUDO_ENV = \
	$(CROSS_ENV) \
	sudo_cv_uid_t_len=10

#
# autoconf
#
SUDO_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--without-pam

ifdef PTXCONF_SUDO_DONT_SEND_MAILS
SUDO_AUTOCONF += --without-sendmail
endif

ifndef PTXCONF_SUDO_USE_SENDMAIL
SUDO_AUTOCONF += --without-sendmail
endif
ifndef PTXCONF_SUDO_USE_PAM
SUDO_AUTOCONF += --without-pam
endif

$(STATEDIR)/sudo.prepare: $(sudo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SUDO_DIR)/config.cache)
	cd $(SUDO_DIR) && \
		$(SUDO_PATH) $(SUDO_ENV) \
		./configure $(SUDO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sudo_compile: $(STATEDIR)/sudo.compile

$(STATEDIR)/sudo.compile: $(sudo_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SUDO_DIR) && $(SUDO_ENV) $(SUDO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sudo_install: $(STATEDIR)/sudo.install

$(STATEDIR)/sudo.install: $(sudo_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sudo_targetinstall: $(STATEDIR)/sudo.targetinstall

$(STATEDIR)/sudo.targetinstall: $(sudo_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, sudo)
	@$(call install_fixup, sudo,PACKAGE,sudo)
	@$(call install_fixup, sudo,PRIORITY,optional)
	@$(call install_fixup, sudo,VERSION,$(SUDO_VERSION))
	@$(call install_fixup, sudo,SECTION,base)
	@$(call install_fixup, sudo,AUTHOR,"Carsten Schlote <c.schlote\@konzeptpark.de>")
	@$(call install_fixup, sudo,DEPENDS,)
	@$(call install_fixup, sudo,DESCRIPTION,missing)

	@$(call install_copy, sudo, 0, 0, 7755, $(SUDO_DIR)/sudo, /usr/bin/sudo)
	@$(call install_link, sudo, sudo, /usr/bin/sudoedit)

	@$(call install_copy, sudo, 0, 0, 0755, $(SUDO_DIR)/.libs/sudo_noexec.so, /usr/libexec/sudo_noexec.so)

 ifdef PTXCONF_SUDO_ETC_SUDOERS
  ifdef PTXCONF_SUDO_ETC_SUDOERS_DEFAULT
	@$(call install_copy, sudo, 0, 0, 0440, $(SUDO_DIR)/sudoers, /etc/sudoers,n)
  endif
  ifdef PTXCONF_SUDO_ETC_SUDOERS_USER
	@$(call install_copy, sudo, 0, 0, 0440, ${PTXDIST_WORKSPACE}/projectroot/etc/sudoers, /etc/sudoers,n)
  endif
 endif
	@$(call install_finish, sudo)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sudo_clean:
	rm -rf $(STATEDIR)/sudo.*
	rm -rf $(SUDO_DIR)

# vim: syntax=make
