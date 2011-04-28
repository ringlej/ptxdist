# -*-makefile-*-
#
# Copyright (C) 2011 by George McCollister <george.mccollister@gmail.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_OPENSSL) += host-openssl

#
# Paths and names
#
HOST_OPENSSL		= $(OPENSSL)
HOST_OPENSSL_DIR	= $(HOST_BUILDDIR)/$(HOST_OPENSSL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_OPENSSL_CONF_ENV	:= $(HOST_ENV)
HOST_OPENSSL_MAKE_PAR	:= NO

#
# autoconf
#
HOST_OPENSSL_CONF_OPT := \
	--prefix=/ \
	--install_prefix=$(HOST_OPENSSL_PKGDIR)

#
# Follow the directions in INSTALL section 1a.
# Configure OpenSSL for your operation system automatically
#
# I see no reason to follow the instructions for manual configuration
# on the host, to do that we need to specify an architecture type.
#
$(STATEDIR)/host-openssl.prepare:
	@$(call targetinfo)
	cd $(HOST_OPENSSL_DIR) && \
		$(HOST_OPENSSL_PATH) $(HOST_OPENSSL_CONF_ENV) \
		./config $(HOST_OPENSSL_CONF_OPT)
	@$(call touch)

# vim: syntax=make
