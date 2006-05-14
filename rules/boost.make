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
PACKAGES-$(PTXCONF_BOOST) += boost

#
# Paths and names
#
BOOST_VERSION	:= 1_33_1
BOOST		:= boost_$(BOOST_VERSION)
BOOST_SUFFIX	:= tar.bz2
BOOST_URL	:= $(PTXCONF_SETUP_SFMIRROR)/boost/$(BOOST).$(BOOST_SUFFIX)
BOOST_SOURCE	:= $(SRCDIR)/$(BOOST).$(BOOST_SUFFIX)
BOOST_DIR	:= $(BUILDDIR)/$(BOOST)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

boost_get: $(STATEDIR)/boost.get

$(STATEDIR)/boost.get: $(boost_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BOOST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BOOST)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

boost_extract: $(STATEDIR)/boost.extract

$(STATEDIR)/boost.extract: $(boost_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BOOST_DIR))
	@$(call extract, BOOST)
	@$(call patchin, $(BOOST))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

boost_prepare: $(STATEDIR)/boost.prepare

BOOST_PATH	:=  PATH=$(CROSS_PATH)
BOOST_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
# ifdef PTXCONF_BOOST_REGEXP
# ifdef PTXCONF_BOOST_SIGNALS
# ifdef PTXCONF_BOOST_SERIALIZATION
# ifdef PTXCONF_BOOST_THREAD
# ifdef PTXCONF_BOOST_PYTHON
# ifdef PTXCONF_BOOST_FILESYSTEM
# ifdef PTXCONF_BOOST_WAVE
# ifdef PTXCONF_BOOST_DATE_TIME
# ifdef PTXCONF_BOOST_IOSTREAMS
# ifdef PTXCONF_BOOST_TEST
# ifdef PTXCONF_BOOST_PROGRAM_OPTIONS
# ifdef PTXCONF_BOOST_GRAPH

$(STATEDIR)/boost.prepare: $(boost_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(BOOST_DIR)/tools/build/jam_src && \
		sh build.sh gcc && mv bin.*/bjam .
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

boost_compile: $(STATEDIR)/boost.compile

$(STATEDIR)/boost.compile: $(boost_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BOOST_DIR) && \
		tools/build/jam_src/bjam \
		-sTOOLS=gcc \
		-sGCC=$(COMPILER_PREFIX)gcc \
		-sGXX=$(COMPILER_PREFIX)g++
	@$(call touch, $@)

#		-sPYTHON_VERSION=2.3 \
#		-sPYTHON_ROOT=/usr

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

boost_install: $(STATEDIR)/boost.install

$(STATEDIR)/boost.install: $(boost_install_deps_default)
	@$(call targetinfo, $@)
	#@$(call install, BOOST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

boost_targetinstall: $(STATEDIR)/boost.targetinstall

$(STATEDIR)/boost.targetinstall: $(boost_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, boost)
	@$(call install_fixup,boost,PACKAGE,boost)
	@$(call install_fixup,boost,PRIORITY,optional)
	@$(call install_fixup,boost,VERSION,$(BOOST_VERSION))
	@$(call install_fixup,boost,SECTION,base)
	@$(call install_fixup,boost,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,boost,DEPENDS,)
	@$(call install_fixup,boost,DESCRIPTION,missing)

	@$(call install_copy, boost, 0, 0, 0755, $(BOOST_DIR)/foobar, /dev/null)

	@$(call install_finish,boost)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

boost_clean:
	rm -rf $(STATEDIR)/boost.*
	rm -rf $(IMAGEDIR)/boost_*
	rm -rf $(BOOST_DIR)

# vim: syntax=make
