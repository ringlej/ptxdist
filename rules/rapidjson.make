# -*-makefile-*-
#
# Copyright (C) 2019 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RAPIDJSON) += rapidjson

#
# Paths and names
#
RAPIDJSON_VERSION	:= 1.1.0
RAPIDJSON_MD5		:= badd12c511e081fec6c89c43a7027bce
RAPIDJSON		:= rapidjson-$(RAPIDJSON_VERSION)
RAPIDJSON_SUFFIX	:= tar.gz
RAPIDJSON_URL		:= https://github.com/Tencent/rapidjson/archive/v$(RAPIDJSON_VERSION).$(RAPIDJSON_SUFFIX)
RAPIDJSON_DIR		:= $(BUILDDIR)/$(RAPIDJSON)
RAPIDJSON_SOURCE	:= $(SRCDIR)/$(RAPIDJSON).$(RAPIDJSON_SUFFIX)
RAPIDJSON_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
RAPIDJSON_CONF_TOOL	:= cmake
RAPIDJSON_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DRAPIDJSON_BUILD_DOC=OFF \
	-DRAPIDJSON_BUILD_EXAMPLES=OFF \
	-DRAPIDJSON_BUILD_TESTS=OFF

# vim: syntax=make
