# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QPDF) += qpdf

#
# Paths and names
#
QPDF_VERSION	:= 7.0.0
QPDF_MD5	:= c3ff408f69b3a6b2b3b4c8b373b2600c
QPDF		:= qpdf-$(QPDF_VERSION)
QPDF_SUFFIX	:= tar.gz
QPDF_URL	:= $(call ptx/mirror, SF, /qpdf/qpdf/$(QPDF_VERSION)/$(QPDF).$(QPDF_SUFFIX))
QPDF_SOURCE	:= $(SRCDIR)/$(QPDF).$(QPDF_SUFFIX)
QPDF_DIR	:= $(BUILDDIR)/$(QPDF)
QPDF_LICENSE	:= Apache-2.0
QPDF_LICENSE_FILES	:= file://LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# We emulate --enable-external-libs as minimally as possible
QPDF_CONF_ENV	:= \
	$(CROSS_ENV) \
	LIBS="-lz -ljpeg"

#
# autoconf
#
# Note: --with-random sets RANDOM_SOURCE, which is not used at all when
# --enable-insecure-random is given. Nevertheless, autoconf will try to
# autodetect whether /dev/urandom exists, which fails when cross-compiling.
QPDF_CONF_TOOL	:= autoconf
QPDF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-libtool-lock \
	--disable-insecure-random \
	--enable-os-secure-random \
	--disable-external-libs \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-werror \
	--disable-test-compare-images \
	--disable-show-failed-test-output \
	--disable-doc-maintenance \
	--disable-html-doc \
	--disable-pdf-doc \
	--disable-validate-doc \
	--with-random=/dev/urandom \
	--with-buildrules=libtool

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qpdf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qpdf)
	@$(call install_fixup, qpdf,PRIORITY,optional)
	@$(call install_fixup, qpdf,SECTION,base)
	@$(call install_fixup, qpdf,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, qpdf,DESCRIPTION,missing)

	@$(call install_lib, qpdf, 0, 0, 0644, libqpdf)

ifdef PTXCONF_QPDF_TOOLS
	@$(call install_copy, qpdf, 0, 0, 0755, -, /usr/bin/qpdf)
	@$(call install_copy, qpdf, 0, 0, 0755, -, /usr/bin/fix-qdf)
	@$(call install_copy, qpdf, 0, 0, 0755, -, /usr/bin/zlib-flate)
endif

	@$(call install_finish, qpdf)

	@$(call touch)

# vim: ft=make ts=8 tw=80
