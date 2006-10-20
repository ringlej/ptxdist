# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QTOPIA) += qtopia

#
# Paths and names
#
QTOPIA_VERSION		:= 4.1.1
QTOPIA			:= qtopia-core-opensource-src-$(QTOPIA_VERSION)
QTOPIA_SUFFIX		:= tar.gz
QTOPIA_URL		:= ftp://ftp.trolltech.com/qt/source/$(QTOPIA).$(QTOPIA_SUFFIX)
QTOPIA_SOURCE		:= $(SRCDIR)/$(QTOPIA).$(QTOPIA_SUFFIX)
QTOPIA_DIR		:= $(BUILDDIR)/$(QTOPIA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

qtopia_get: $(STATEDIR)/qtopia.get

$(STATEDIR)/qtopia.get: $(qtopia_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(QTOPIA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, QTOPIA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

qtopia_extract: $(STATEDIR)/qtopia.extract

$(STATEDIR)/qtopia.extract: $(qtopia_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(QTOPIA_DIR))
	@$(call extract, QTOPIA)
	@$(call patchin, QTOPIA)
	sed -i -e "s,@COMPILER_PREFIX@,$(COMPILER_PREFIX),g" $(QTOPIA_DIR)/mkspecs/qws/linux-ptxdist-g++/qmake.conf
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

qtopia_prepare: $(STATEDIR)/qtopia.prepare

QTOPIA_PATH	:= PATH=$(CROSS_PATH)
QTOPIA_MAKEVARS	:= INSTALL_ROOT=$(SYSROOT)

#
# autoconf
#
QTOPIA_AUTOCONF := \
	-prefix /usr \
	-no-gif \
	-qt-libpng \
	-no-cups \
	-no-qt3support \
	-no-g++-exceptions \
	-depths 8,16 \
	-no-qvfb \
	-embedded ptxdist \
	-I$(SYSROOT)/include \
	-I$(SYSROOT)/usr/include \
	-L$(SYSROOT)/lib \
	-L$(SYSROOT)/usr/lib \
	-release \
	-verbose

ifdef PTXCONF_QTOPIA_STL
QTOPIA_AUTOCONF	+= -stl
else
QTOPIA_AUTOCONF	+= -no-stl
endif

ifdef PTXCONF_QTOPIA_TSLIB
QTOPIA_AUTOCONF	+= -qt-mouse-tslib
endif

ifdef PTXCONF_QTOPIA_SHARED
QTOPIA_AUTOCONF	+= -shared
else
QTOPIA_AUTOCONF	+= -static
endif

$(STATEDIR)/qtopia.prepare: $(qtopia_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(QTOPIA_DIR)/config.cache)
	cd $(QTOPIA_DIR) && \
		echo "yes" | $(QTOPIA_PATH) $(QTOPIA_ENV) \
		./configure $(QTOPIA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

qtopia_compile: $(STATEDIR)/qtopia.compile

$(STATEDIR)/qtopia.compile: $(qtopia_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(QTOPIA_DIR) && $(QTOPIA_PATH) make sub-src-all-ordered $(QTOPIA_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

qtopia_install: $(STATEDIR)/qtopia.install

$(STATEDIR)/qtopia.install: $(qtopia_install_deps_default)
	@$(call targetinfo, $@)
	cd $(QTOPIA_DIR) && $(QTOPIA_PATH) make sub-src-install_subtargets-ordered $(QTOPIA_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

qtopia_targetinstall: $(STATEDIR)/qtopia.targetinstall

$(STATEDIR)/qtopia.targetinstall: $(qtopia_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, qtopia)
	@$(call install_fixup,qtopia,PACKAGE,qtopia)
	@$(call install_fixup,qtopia,PRIORITY,optional)
	@$(call install_fixup,qtopia,VERSION,$(QTOPIA_VERSION))
	@$(call install_fixup,qtopia,SECTION,base)
	@$(call install_fixup,qtopia,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,qtopia,DEPENDS,)
	@$(call install_fixup,qtopia,DESCRIPTION,missing)

ifdef PTXCONF_QTOPIA_SHARED
	@$(call install_copy, qtopia, 0, 0, 0755, $(QTOPIA_DIR)/lib/libQtCore.so.4.1.1, /usr/lib/libQtCore.so.4.1.1 )
	@$(call install_link, qtopia, libQtCore.so.4.1.1, /usr/lib/libQtCore.so.4.1)
	@$(call install_link, qtopia, libQtCore.so.4.1.1, /usr/lib/libQtCore.so.4)

	@$(call install_copy, qtopia, 0, 0, 0755, $(QTOPIA_DIR)/lib/libQtGui.so.4.1.1, /usr/lib/libQtGui.so.4.1.1 )
	@$(call install_link, qtopia, libQtGui.so.4.1.1, /usr/lib/libQtGui.so.4.1)
	@$(call install_link, qtopia, libQtGui.so.4.1.1, /usr/lib/libQtGui.so.4)

	@$(call install_copy, qtopia, 0, 0, 0755, $(QTOPIA_DIR)/lib/libQtNetwork.so.4.1.1, /usr/lib/libQtNetwork.so.4.1.1 )
	@$(call install_link, qtopia, libQtNetwork.so.4.1.1, /usr/lib/libQtNetwork.so.4.1)
	@$(call install_link, qtopia, libQtNetwork.so.4.1.1, /usr/lib/libQtNetwork.so.4)

	@$(call install_copy, qtopia, 0, 0, 0755, $(QTOPIA_DIR)/lib/libQtSql.so.4.1.1, /usr/lib/libQtSql.so.4.1.1 )
	@$(call install_link, qtopia, libQtSql.so.4.1.1, /usr/lib/libQtSql.so.4.1)
	@$(call install_link, qtopia, libQtSql.so.4.1.1, /usr/lib/libQtSql.so.4)

	@$(call install_copy, qtopia, 0, 0, 0755, $(QTOPIA_DIR)/lib/libQtSvg.so.4.1.1, /usr/lib/libQtSvg.so.4.1.1 )
	@$(call install_link, qtopia, libQtSvg.so.4.1.1, /usr/lib/libQtSvg.so.4.1)
	@$(call install_link, qtopia, libQtSvg.so.4.1.1, /usr/lib/libQtSvg.so.4)

#	FIXME: should be made configurable, we don't build tests right now
#	@$(call install_copy, qtopia, 0, 0, 0755, $(QTOPIA_DIR)/lib/libQtTest.so.4.1.1, /usr/lib/libQtTest.so.4.1.1 )
#	@$(call install_link, qtopia, libQtTest.so.4.1.1, /usr/lib/libQtTest.so.4.1)
#	@$(call install_link, qtopia, libQtTest.so.4.1.1, /usr/lib/libQtTest.so.4)

	@$(call install_copy, qtopia, 0, 0, 0755, $(QTOPIA_DIR)/lib/libQtXml.so.4.1.1, /usr/lib/libQtXml.so.4.1.1 )
	@$(call install_link, qtopia, libQtXml.so.4.1.1, /usr/lib/libQtXml.so.4.1)
	@$(call install_link, qtopia, libQtXml.so.4.1.1, /usr/lib/libQtXml.so.4)
endif

	@$(call install_finish,qtopia)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qtopia_clean:
	rm -rf $(STATEDIR)/qtopia.*
	rm -rf $(IMAGEDIR)/qtopia_*
	rm -rf $(QTOPIA_DIR)

# vim: syntax=make
