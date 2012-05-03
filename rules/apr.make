# -*-makefile-*-
#
# Copyright (C) 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_APR) += apr

#
# Paths and names
#
APR_VERSION	:= 0.9.20
APR_MD5		:= 6dd59a88ee75b8cdf719a90b5a2f2485
APR		:= apr-$(APR_VERSION)
APR_SUFFIX	:= tar.bz2
APR_URL		:= http://archive.apache.org/dist/apr/$(APR).$(APR_SUFFIX)
APR_SOURCE	:= $(SRCDIR)/$(APR).$(APR_SUFFIX)
APR_DIR		:= $(BUILDDIR)/$(APR)
APR_LICENSE	:= APLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

APR_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_file__dev_zero=yes \
	ac_cv_sizeof_size_t=4 \
	ac_cv_sizeof_ssize_t=4 \
	ac_cv_struct_rlimit=yes \
	apr_cv_mutex_robust_shared=no \
	apr_cv_process_shared_works=yes

#
# autoconf
#
APR_CONF_TOOL := autoconf
APR_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-threads

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apr.install.post:
	@$(call targetinfo)
	@$(call world/install.post, APR)
	sed -i -e "s~@SYSROOT@~${PTXDIST_SYSROOT_TARGET}~g" \
		$(PTXDIST_SYSROOT_TARGET)/usr/build/apr_rules.mk
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, apr)
	@$(call install_fixup, apr,PRIORITY,optional)
	@$(call install_fixup, apr,SECTION,base)
	@$(call install_fixup, apr,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, apr,DESCRIPTION,missing)

	@$(call install_lib, apr, 0, 0, 0644, libapr-0)

	@$(call install_finish, apr)

	@$(call touch)

# vim: syntax=make
