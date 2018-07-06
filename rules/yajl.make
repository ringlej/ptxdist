# -*-makefile-*-
#
# Copyright (C) 2016 by Denis Osterland <Denis.Osterland@diehl.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_YAJL) += yajl

YAJL_VERSION       := 2.1.0
YAJL_MD5           := 8df8a92a2799bc949577e8e7a9f43670
YAJL               := yajl-$(YAJL_VERSION)
YAJL_SUFFIX        := tar.gz
YAJL_URL           := http://github.com/lloyd/yajl/tarball/$(YAJL_VERSION)
YAJL_SOURCE        := $(SRCDIR)/$(YAJL).$(YAJL_SUFFIX)
YAJL_DIR           := $(BUILDDIR)/$(YAJL)
YAJL_LICENSE       := ISC
YAJL_LICENSE_FILES := file://COPYING;md5=39af6eb42999852bdd3ea00ad120a36d


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

YAJL_CONF_TOOL	:= cmake

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/yajl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, yajl)
	@$(call install_fixup, yajl,PRIORITY,optional)
	@$(call install_fixup, yajl,SECTION,base)
	@$(call install_fixup, yajl,AUTHOR,"Denis Osterland <Denis.Osterland@diehl.com>")
	@$(call install_fixup, yajl,DESCRIPTION,missing)

	@$(call install_lib, yajl, 0, 0, 0755, libyajl)

	@$(call install_finish, yajl)

	@$(call touch)

# vim: syntax=make
