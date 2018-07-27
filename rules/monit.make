# -*-makefile-*-
#
# Copyright (C) 2014,2016,2018 by Alexander Dahl <post@lespocky.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MONIT) += monit

#
# Paths and names
#
MONIT_VERSION	:= 5.25.2
MONIT_MD5	:= 890df599d6c1e9cfbbdd3edbacb7db81
MONIT		:= monit-$(MONIT_VERSION)
MONIT_SUFFIX	:= tar.gz
MONIT_URL	:= http://mmonit.com/monit/dist/$(MONIT).$(MONIT_SUFFIX)
MONIT_SOURCE	:= $(SRCDIR)/$(MONIT).$(MONIT_SUFFIX)
MONIT_DIR	:= $(BUILDDIR)/$(MONIT)
MONIT_LICENSE	:= AGPL-3.0-only
MONIT_LICENSE_FILES := file://COPYING;md5=ea116a7defaf0e93b3bb73b2a34a3f51

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MONIT_CONF_ENV	:= $(CROSS_ENV) \
	libmonit_cv_setjmp_available=yes \
	libmonit_cv_vsnprintf_c99_conformant=yes

MONIT_CONF_TOOL	:= autoconf
MONIT_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-optimized \
	--disable-profiling \
	--$(call ptx/wwo, PTXCONF_GLOBAL_IPV6)-ipv6 \
	--$(call ptx/wwo, PTXCONF_GLOBAL_LARGE_FILE)-largefiles \
	--$(call ptx/wwo, PTXCONF_MONIT_ZLIB)-zlib \
	--without-pam \
	--$(call ptx/wwo, PTXCONF_MONIT_SSL)-ssl \
	--with-ssl-dir=$(SYSROOT)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/monit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, monit)
	@$(call install_fixup, monit,PRIORITY,optional)
	@$(call install_fixup, monit,SECTION,base)
	@$(call install_fixup, monit,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, monit,DESCRIPTION,missing)

	@$(call install_copy, monit, 0, 0, 0755, -, /usr/bin/monit)
	@$(call install_copy, monit, 0, 0, 0755, /var/lib/monit)
	@$(call install_copy, monit, 0, 0, 0755, /var/lib/monit/events)
	@$(call install_alternative, monit, 0, 0, 0600, /etc/monitrc)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_MONIT_STARTSCRIPT
	@$(call install_alternative, monit, 0, 0, 0755, /etc/init.d/monit)
ifneq ($(call remove_quotes,$(PTXCONF_MONIT_BBINIT_LINK)),)
	@$(call install_link, monit, ../init.d/monit, \
		/etc/rc.d/$(PTXCONF_MONIT_BBINIT_LINK))
endif
endif
endif

	@$(call install_finish, monit)

	@$(call touch)

# vim: ft=make noet
