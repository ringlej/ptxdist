# -*-makefile-*-
# $Id: qte.make,v 1.2 2003/11/13 04:28:40 mkl Exp $
#
# (c) 2003 by Marco Cavallini <m.cavallini@koansoftware.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_QTE
PACKAGES += qte
endif

#
# Paths and names
#
QTE_VERSION	= 3.2.2
QTE		= qt-embedded-free-$(QTE_VERSION)
QTE_SUFFIX	= tar.gz
QTE_URL		= ftp://ftp.trolltech.com/qt/source/$(QTE).$(QTE_SUFFIX)
QTE_SOURCE	= $(SRCDIR)/$(QTE).$(QTE_SUFFIX)
QTE_DIR		= $(BUILDDIR)/$(QTE)
QTDIR		= $(BUILDDIR)/$(QTE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

qte_get: $(STATEDIR)/qte.get

qte_get_deps = $(QTE_SOURCE)

$(STATEDIR)/qte.get: $(qte_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(QTE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(QTE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

qte_extract: $(STATEDIR)/qte.extract

qte_extract_deps = $(STATEDIR)/qte.get

$(STATEDIR)/qte.extract: $(qte_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(QTE_DIR))
	@$(call extract, $(QTE_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

qte_prepare: $(STATEDIR)/qte.prepare

#
# dependencies
#
qte_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/qte.extract

QTE_PATH	=  PATH=$(CROSS_PATH)
QTE_ENV 	=  $(CROSS_ENV)
QTE_ENV		+= QTDIR=$(QT_DIR)

#
# autoconf
#
QTE_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)
# QTE_AUTOCONF	+= --build=$(GNU_HOST)
# QTE_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

QTE_AUTOCONF	+= -no-gif
QTE_AUTOCONF	+= -qt-libpng
QTE_AUTOCONF	+= -no-libjpeg
QTE_AUTOCONF	+= -no-thread 
QTE_AUTOCONF	+= -no-cups 
QTE_AUTOCONF	+= -no-stl 
QTE_AUTOCONF	+= -release
QTE_AUTOCONF	+= -no-g++-exceptions 
#QTE_AUTOCONF	+= -I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
#QTE_AUTOCONF	+= -R$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
#QTE_AUTOCONF	+= -L/usr/X11R6/lib
QTE_AUTOCONF	+= -depths 8,16
# QTE_AUTOCONF	+= -qconfig local 
QTE_AUTOCONF	+= -no-qvfb 
QTE_AUTOCONF	+= -xplatform linux-g++
QTE_AUTOCONF	+= -embedded x86
QTE_AUTOCONF	+= -disable-opengl
QTE_AUTOCONF	+= -disable-sql
QTE_AUTOCONF	+= -disable-workspace

### QTE_AUTOCONF	+= -shared 
QTE_AUTOCONF	+= -static 

$(STATEDIR)/qte.prepare: $(qte_prepare_deps)
	@$(call targetinfo, $@)
	cd $(QTE_DIR) && \
		echo yes | $(QTE_PATH) $(QTE_ENV) \
		./configure $(QTE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

qte_compile: $(STATEDIR)/qte.compile

qte_compile_deps = $(STATEDIR)/qte.prepare

$(STATEDIR)/qte.compile: $(qte_compile_deps)
	@$(call targetinfo, $@)
	$(QTE_PATH) $(QTE_ENV) make -C $(QTE_DIR) $(QTE_ENV)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

qte_install: $(STATEDIR)/qte.install

$(STATEDIR)/qte.install: $(STATEDIR)/qte.compile
	@$(call targetinfo, $@)
	$(QTE_PATH) $(QTE_ENV) make -C $(QTE_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

qte_targetinstall: $(STATEDIR)/qte.targetinstall

qte_targetinstall_deps = $(STATEDIR)/qte.compile

$(STATEDIR)/qte.targetinstall: $(qte_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qte_clean:
	rm -rf $(STATEDIR)/qte.*
	rm -rf $(QTE_DIR)

# vim: syntax=make
