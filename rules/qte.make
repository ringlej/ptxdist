# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marco Cavallini <m.cavallini@koansoftware.com>
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QTE) += qte

#
# Paths and names
#
QTE_VERSION	:= 3.3.4
QTE		:= qt-embedded-free-$(QTE_VERSION)
QTE_SUFFIX	:= tar.gz
QTE_URL		:= ftp://ftp.trolltech.com/qt/source/$(QTE).$(QTE_SUFFIX)
QTE_SOURCE	:= $(SRCDIR)/$(QTE).$(QTE_SUFFIX)
QTE_DIR		:= $(BUILDDIR)/$(QTE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

qte_get: $(STATEDIR)/qte.get

$(STATEDIR)/qte.get: $(qte_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(QTE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, QTE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

qte_extract: $(STATEDIR)/qte.extract

$(STATEDIR)/qte.extract: $(qte_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(QTE_DIR))
	@$(call extract, QTE)
	@$(call patchin, QTE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

qte_prepare: $(STATEDIR)/qte.prepare

QTE_PATH	:= PATH=$(CROSS_PATH)
QTE_ENV		:= QTDIR=/opt

#
# autoconf
#
QTE_AUTOCONF	= \
	-prefix $(SYSROOT) \
	-no-gif \
	-qt-libpng \
	\
	-no-cups \
	\
	-release \
	-no-g++-exceptions \
	-depths 8,16 \
	-no-qvfb \
	-xplatform linux-ptxdist \
	-embedded $(PTXCONF_ARCH) \
	-disable-opengl \
	-disable-sql \
	-disable-workspace

ifdef PTXCONF_QTE_THREAD
QTE_AUTOCONF	+= -thread
else
QTE_AUTOCONF	+= -no-thread
endif

ifdef PTXCONF_QTE_STL
QTE_AUTOCONF	+= -stl
else
QTE_AUTOCONF	+= -no-stl
endif

ifdef PTXCONF_QTE_QVFB
QTE_AUTOCONF	+= -qvfb
endif

ifdef PTXCONF_QTE_TSLIB
QTE_AUTOCONF	+= -qt-mouse-tslib
endif

ifdef PTXCONF_QTE_SHARED
QTE_AUTOCONF	+= -shared
else
QTE_AUTOCONF	+= -static
endif

$(STATEDIR)/qte.prepare: $(qte_prepare_deps_default)
	@$(call targetinfo, $@)
	mkdir -p $(QTE_DIR)/mkspecs/linux-ptxdist
	ln -sf ../linux-g++/qplatformdefs.h $(QTE_DIR)/mkspecs/linux-ptxdist

	@echo 'MAKEFILE_GENERATOR         = UNIX'			> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'TEMPLATE                   = app'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'CONFIG                     += qt link_prl'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo "QMAKE_CC                   = $(PTXCONF_GNU_TARGET)-gcc"	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LEX                  = flex'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LEXFLAGS             ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_YACC                 = yacc'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_YACCFLAGS            = -d'				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS               = -pipe'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS_WARN_ON       = -Wall -W'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS_WARN_OFF      ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS_RELEASE       = -O2'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS_DEBUG         = -g'				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS_SHLIB         = -fPIC'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS_YACC          = -Wno-unused -Wno-parentheses' >> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CFLAGS_THREAD        = -D_REENTRANT'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo "QMAKE_CXX                  = $(PTXCONF_GNU_TARGET)-g++"	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS             = $$$$QMAKE_CFLAGS -DQWS -fno-exceptions -fno-rtti' >> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS_WARN_ON     = $$$$QMAKE_CFLAGS_WARN_ON'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS_WARN_OFF    = $$$$QMAKE_CFLAGS_WARN_OFF'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS_RELEASE     = $$$$QMAKE_CFLAGS_RELEASE'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS_DEBUG       = $$$$QMAKE_CFLAGS_DEBUG'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS_SHLIB       = $$$$QMAKE_CFLAGS_SHLIB'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS_YACC        = $$$$QMAKE_CFLAGS_YACC'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CXXFLAGS_THREAD      = $$$$QMAKE_CFLAGS_THREAD'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo 'QMAKE_INCDIR               ='$(SYSROOT)/include    	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBDIR               ='$(SYSROOT)/lib		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_INCDIR_X11           ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBDIR_X11           ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_INCDIR_QT            = $(QTDIR)/include'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBDIR_QT            = $(QTDIR)/lib'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_INCDIR_OPENGL        = '				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBDIR_OPENGL        = '				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_INCDIR_QTOPIA        = $(QPEDIR)/include'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBDIR_QTOPIA        = $(QPEDIR)/lib'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo "QMAKE_LINK                 = $(PTXCONF_GNU_TARGET)-g++"	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo "QMAKE_LINK_SHLIB           = $(PTXCONF_GNU_TARGET)-g++"	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LFLAGS               ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LFLAGS_RELEASE       ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LFLAGS_DEBUG         ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LFLAGS_SHLIB         = -shared'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LFLAGS_PLUGIN        = $$$$QMAKE_LFLAGS_SHLIB'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LFLAGS_SONAME        = -Wl,-soname,'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LFLAGS_THREAD        ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_RPATH                = -Wl,-rpath,'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo 'QMAKE_LIBS                 = '				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_DYNLOAD         = -ldl'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_X11             = '				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_X11SM           = '				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_QT              = -lqte'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_QT_THREAD       = -lqte-mt'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_QT_OPENGL       = -lqgl'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_QTOPIA          = -lqtopia -lqpe'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_LIBS_THREAD          = -lpthread'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo 'QMAKE_MOC                  = $(QTDIR)/bin/moc'		>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_UIC                  = $(PTXCONF_PREFIX)/bin/uic'	>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo 'QMAKE_AR                   = ar cqs'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_RANLIB               ='				>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo 'QMAKE_TAR                  = tar -cf'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_GZIP                 = gzip -9f'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	@echo 'QMAKE_COPY                 = cp -f'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_MOVE                 = mv -f'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_DEL_FILE             = rm -f'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_DEL_DIR              = rmdir'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_CHK_DIR_EXISTS       = test -d'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf
	@echo 'QMAKE_MKDIR                = mkdir -p'			>> $(QTE_DIR)/mkspecs/linux-ptxdist/qmake.conf

	cd $(QTE_DIR) && \
		echo yes | $(QTE_PATH) $(QTE_ENV) \
 		./configure $(QTE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

qte_compile: $(STATEDIR)/qte.compile

$(STATEDIR)/qte.compile: $(qte_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(QTE_DIR) && $(QTE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

qte_install: $(STATEDIR)/qte.install

$(STATEDIR)/qte.install: $(qte_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, QTE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

qte_targetinstall: $(STATEDIR)/qte.targetinstall

$(STATEDIR)/qte.targetinstall: $(qte_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  qte)
	@$(call install_fixup, qte,PACKAGE,qte)
	@$(call install_fixup, qte,PRIORITY,optional)
	@$(call install_fixup, qte,VERSION,$(QTE_VERSION))
	@$(call install_fixup, qte,SECTION,base)
	@$(call install_fixup, qte,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, qte,DEPENDS,)
	@$(call install_fixup, qte,DESCRIPTION,missing)

	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_120_50.qpf, /usr/qt/lib/fonts/fixed_120_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_120_50_t10.qpf, /usr/qt/lib/fonts/fixed_120_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_120_50_t15.qpf, /usr/qt/lib/fonts/fixed_120_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_120_50_t5.qpf, /usr/qt/lib/fonts/fixed_120_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_70_50.qpf, /usr/qt/lib/fonts/fixed_70_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_70_50_t10.qpf, /usr/qt/lib/fonts/fixed_70_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_70_50_t15.qpf, /usr/qt/lib/fonts/fixed_70_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fixed_70_50_t5.qpf, /usr/qt/lib/fonts/fixed_70_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50.qpf, /usr/qt/lib/fonts/helvetica_100_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50_t10.qpf, /usr/qt/lib/fonts/helvetica_100_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50_t15.qpf, /usr/qt/lib/fonts/helvetica_100_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50_t5.qpf, /usr/qt/lib/fonts/helvetica_100_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50i.qpf, /usr/qt/lib/fonts/helvetica_100_50i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50i_t10.qpf, /usr/qt/lib/fonts/helvetica_100_50i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50i_t15.qpf, /usr/qt/lib/fonts/helvetica_100_50i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_50i_t5.qpf, /usr/qt/lib/fonts/helvetica_100_50i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75.qpf, /usr/qt/lib/fonts/helvetica_100_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75_t10.qpf, /usr/qt/lib/fonts/helvetica_100_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75_t15.qpf, /usr/qt/lib/fonts/helvetica_100_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75_t5.qpf, /usr/qt/lib/fonts/helvetica_100_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75i.qpf, /usr/qt/lib/fonts/helvetica_100_75i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75i_t10.qpf, /usr/qt/lib/fonts/helvetica_100_75i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75i_t15.qpf, /usr/qt/lib/fonts/helvetica_100_75i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_100_75i_t5.qpf, /usr/qt/lib/fonts/helvetica_100_75i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50.qpf, /usr/qt/lib/fonts/helvetica_120_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50_t10.qpf, /usr/qt/lib/fonts/helvetica_120_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50_t15.qpf, /usr/qt/lib/fonts/helvetica_120_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50_t5.qpf, /usr/qt/lib/fonts/helvetica_120_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50i.qpf, /usr/qt/lib/fonts/helvetica_120_50i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50i_t10.qpf, /usr/qt/lib/fonts/helvetica_120_50i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50i_t15.qpf, /usr/qt/lib/fonts/helvetica_120_50i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_50i_t5.qpf, /usr/qt/lib/fonts/helvetica_120_50i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75.qpf, /usr/qt/lib/fonts/helvetica_120_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75_t10.qpf, /usr/qt/lib/fonts/helvetica_120_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75_t15.qpf, /usr/qt/lib/fonts/helvetica_120_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75_t5.qpf, /usr/qt/lib/fonts/helvetica_120_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75i.qpf, /usr/qt/lib/fonts/helvetica_120_75i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75i_t10.qpf, /usr/qt/lib/fonts/helvetica_120_75i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75i_t15.qpf, /usr/qt/lib/fonts/helvetica_120_75i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_120_75i_t5.qpf, /usr/qt/lib/fonts/helvetica_120_75i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50.qpf, /usr/qt/lib/fonts/helvetica_140_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50_t10.qpf, /usr/qt/lib/fonts/helvetica_140_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50_t15.qpf, /usr/qt/lib/fonts/helvetica_140_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50_t5.qpf, /usr/qt/lib/fonts/helvetica_140_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50i.qpf, /usr/qt/lib/fonts/helvetica_140_50i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50i_t10.qpf, /usr/qt/lib/fonts/helvetica_140_50i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50i_t15.qpf, /usr/qt/lib/fonts/helvetica_140_50i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_50i_t5.qpf, /usr/qt/lib/fonts/helvetica_140_50i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75.qpf, /usr/qt/lib/fonts/helvetica_140_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75_t10.qpf, /usr/qt/lib/fonts/helvetica_140_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75_t15.qpf, /usr/qt/lib/fonts/helvetica_140_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75_t5.qpf, /usr/qt/lib/fonts/helvetica_140_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75i.qpf, /usr/qt/lib/fonts/helvetica_140_75i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75i_t10.qpf, /usr/qt/lib/fonts/helvetica_140_75i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75i_t15.qpf, /usr/qt/lib/fonts/helvetica_140_75i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_140_75i_t5.qpf, /usr/qt/lib/fonts/helvetica_140_75i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50.qpf, /usr/qt/lib/fonts/helvetica_180_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50_t10.qpf, /usr/qt/lib/fonts/helvetica_180_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50_t15.qpf, /usr/qt/lib/fonts/helvetica_180_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50_t5.qpf, /usr/qt/lib/fonts/helvetica_180_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50i.qpf, /usr/qt/lib/fonts/helvetica_180_50i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50i_t10.qpf, /usr/qt/lib/fonts/helvetica_180_50i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50i_t15.qpf, /usr/qt/lib/fonts/helvetica_180_50i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_50i_t5.qpf, /usr/qt/lib/fonts/helvetica_180_50i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75.qpf, /usr/qt/lib/fonts/helvetica_180_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75_t10.qpf, /usr/qt/lib/fonts/helvetica_180_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75_t15.qpf, /usr/qt/lib/fonts/helvetica_180_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75_t5.qpf, /usr/qt/lib/fonts/helvetica_180_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75i.qpf, /usr/qt/lib/fonts/helvetica_180_75i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75i_t10.qpf, /usr/qt/lib/fonts/helvetica_180_75i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75i_t15.qpf, /usr/qt/lib/fonts/helvetica_180_75i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_180_75i_t5.qpf, /usr/qt/lib/fonts/helvetica_180_75i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50.qpf, /usr/qt/lib/fonts/helvetica_240_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50_t10.qpf, /usr/qt/lib/fonts/helvetica_240_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50_t15.qpf, /usr/qt/lib/fonts/helvetica_240_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50_t5.qpf, /usr/qt/lib/fonts/helvetica_240_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50i.qpf, /usr/qt/lib/fonts/helvetica_240_50i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50i_t10.qpf, /usr/qt/lib/fonts/helvetica_240_50i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50i_t15.qpf, /usr/qt/lib/fonts/helvetica_240_50i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_50i_t5.qpf, /usr/qt/lib/fonts/helvetica_240_50i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75.qpf, /usr/qt/lib/fonts/helvetica_240_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75_t10.qpf, /usr/qt/lib/fonts/helvetica_240_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75_t15.qpf, /usr/qt/lib/fonts/helvetica_240_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75_t5.qpf, /usr/qt/lib/fonts/helvetica_240_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75i.qpf, /usr/qt/lib/fonts/helvetica_240_75i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75i_t10.qpf, /usr/qt/lib/fonts/helvetica_240_75i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75i_t15.qpf, /usr/qt/lib/fonts/helvetica_240_75i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_240_75i_t5.qpf, /usr/qt/lib/fonts/helvetica_240_75i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50.qpf, /usr/qt/lib/fonts/helvetica_80_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50_t10.qpf, /usr/qt/lib/fonts/helvetica_80_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50_t15.qpf, /usr/qt/lib/fonts/helvetica_80_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50_t5.qpf, /usr/qt/lib/fonts/helvetica_80_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50i.qpf, /usr/qt/lib/fonts/helvetica_80_50i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50i_t10.qpf, /usr/qt/lib/fonts/helvetica_80_50i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50i_t15.qpf, /usr/qt/lib/fonts/helvetica_80_50i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_50i_t5.qpf, /usr/qt/lib/fonts/helvetica_80_50i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75.qpf, /usr/qt/lib/fonts/helvetica_80_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75_t10.qpf, /usr/qt/lib/fonts/helvetica_80_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75_t15.qpf, /usr/qt/lib/fonts/helvetica_80_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75_t5.qpf, /usr/qt/lib/fonts/helvetica_80_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75i.qpf, /usr/qt/lib/fonts/helvetica_80_75i.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75i_t10.qpf, /usr/qt/lib/fonts/helvetica_80_75i_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75i_t15.qpf, /usr/qt/lib/fonts/helvetica_80_75i_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/helvetica_80_75i_t5.qpf, /usr/qt/lib/fonts/helvetica_80_75i_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/micro_40_50.qpf, /usr/qt/lib/fonts/micro_40_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/micro_40_50_t10.qpf, /usr/qt/lib/fonts/micro_40_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/micro_40_50_t15.qpf, /usr/qt/lib/fonts/micro_40_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/micro_40_50_t5.qpf, /usr/qt/lib/fonts/micro_40_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smallsmooth_90_50.qpf, /usr/qt/lib/fonts/smallsmooth_90_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smallsmooth_90_50_t10.qpf, /usr/qt/lib/fonts/smallsmooth_90_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smallsmooth_90_50_t15.qpf, /usr/qt/lib/fonts/smallsmooth_90_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smallsmooth_90_50_t5.qpf, /usr/qt/lib/fonts/smallsmooth_90_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_100_50.qpf, /usr/qt/lib/fonts/smoothtimes_100_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_100_50_t10.qpf, /usr/qt/lib/fonts/smoothtimes_100_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_100_50_t15.qpf, /usr/qt/lib/fonts/smoothtimes_100_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_100_50_t5.qpf, /usr/qt/lib/fonts/smoothtimes_100_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_160_50.qpf, /usr/qt/lib/fonts/smoothtimes_160_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_160_50_t10.qpf, /usr/qt/lib/fonts/smoothtimes_160_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_160_50_t15.qpf, /usr/qt/lib/fonts/smoothtimes_160_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_160_50_t5.qpf, /usr/qt/lib/fonts/smoothtimes_160_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_50.qpf, /usr/qt/lib/fonts/smoothtimes_170_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_50_t10.qpf, /usr/qt/lib/fonts/smoothtimes_170_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_50_t15.qpf, /usr/qt/lib/fonts/smoothtimes_170_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_50_t5.qpf, /usr/qt/lib/fonts/smoothtimes_170_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_75.qpf, /usr/qt/lib/fonts/smoothtimes_170_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_75_t10.qpf, /usr/qt/lib/fonts/smoothtimes_170_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_75_t15.qpf, /usr/qt/lib/fonts/smoothtimes_170_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_170_75_t5.qpf, /usr/qt/lib/fonts/smoothtimes_170_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_220_50.qpf, /usr/qt/lib/fonts/smoothtimes_220_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_220_50_t10.qpf, /usr/qt/lib/fonts/smoothtimes_220_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_220_50_t15.qpf, /usr/qt/lib/fonts/smoothtimes_220_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_220_50_t5.qpf, /usr/qt/lib/fonts/smoothtimes_220_50_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_250_75.qpf, /usr/qt/lib/fonts/smoothtimes_250_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_250_75_t10.qpf, /usr/qt/lib/fonts/smoothtimes_250_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_250_75_t15.qpf, /usr/qt/lib/fonts/smoothtimes_250_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_250_75_t5.qpf, /usr/qt/lib/fonts/smoothtimes_250_75_t5.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_440_75.qpf, /usr/qt/lib/fonts/smoothtimes_440_75.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_440_75_t10.qpf, /usr/qt/lib/fonts/smoothtimes_440_75_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_440_75_t15.qpf, /usr/qt/lib/fonts/smoothtimes_440_75_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/smoothtimes_440_75_t5.qpf, /usr/qt/lib/fonts/smoothtimes_440_75_t5.qpf, 0)
ifdef PTXCONF_QTE_INSTALL_UNIFONT
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/unifont_160_50.qpf, /usr/qt/lib/fonts/unifont_160_50.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/unifont_160_50_t10.qpf, /usr/qt/lib/fonts/unifont_160_50_t10.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/unifont_160_50_t15.qpf, /usr/qt/lib/fonts/unifont_160_50_t15.qpf, 0)
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/unifont_160_50_t5.qpf, /usr/qt/lib/fonts/unifont_160_50_t5.qpf, 0)
endif
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/fonts/fontdir, /usr/qt/lib/fonts/fontdir, 0)
ifdef PTXCONF_QTE_SHARED
ifdef PTXCONF_QTE_THREAD
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/libqte-mt.so.$(QTE_VERSION), /lib/libqte-mt.so.$(QTE_VERSION))
	@$(call install_link, qte, libqte-mt.so.$(QTE_VERSION), /lib/libqte-mt.so)
	@$(call install_link, qte, libqte-mt.so.$(QTE_VERSION), /lib/libqte-mt.so.$(QTE_MAJOR))
	@$(call install_link, qte, libqte-mt.so.$(QTE_VERSION), /lib/libqte-mt.so.$(QTE_MAJOR).$(QTE_MINOR))
else
	@$(call install_copy, qte, 0, 0, 0755, $(QTE_DIR)/lib/libqte.so.$(QTE_VERSION), /lib/libqte.so.$(QTE_VERSION))
	@$(call install_link, qte, libqte.so.$(QTE_VERSION), /lib/libqte.so)
	@$(call install_link, qte, libqte.so.$(QTE_VERSION), /lib/libqte.so.$(QTE_MAJOR))
	@$(call install_link, qte, libqte.so.$(QTE_VERSION), /lib/libqte.so.$(QTE_MAJOR).$(QTE_MINOR))
endif
endif

	@$(call install_finish, qte)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qte_clean:
	rm -rf $(STATEDIR)/qte.*
	rm -rf $(IMAGEDIR)/qte_*
	rm -rf $(QTE_DIR)

# vim: syntax=make
