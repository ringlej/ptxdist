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
	@$(call patchin, BOOST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

boost_prepare: $(STATEDIR)/boost.prepare

BOOST_PATH	:=  PATH=$(CROSS_PATH)
BOOST_ENV 	:=  $(CROSS_ENV)

# they reinvent their own wheel^Hmake: jam
# -q: quit on error
# -d: debug level, default=1

BOOST_JAM	:= \
	$(BOOST_DIR)/tools/build/jam_src/bjam \
	-q \
	-d 1 \
	-sTOOLS=gcc \
	-sGCC=$(COMPILER_PREFIX)gcc \
	-sGXX=$(COMPILER_PREFIX)g++ \
	-sOBJCOPY=$(COMPILER_PREFIX)objcopy

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

ifdef PTXCONF_BOOST_FILESYSTEM
	cd $(BOOST_DIR)/libs/filesystem/build && $(BOOST_JAM)
endif
ifdef PTXCONF_BOOST_REGEX
	cd $(BOOST_DIR)/libs/regex/build && $(BOOST_JAM)
endif
ifdef PTXCONF_BOOST_THREAD
	cd $(BOOST_DIR)/libs/thread/build && $(BOOST_JAM)
endif
ifdef PTXCONF_BOOST_PROGRAM_OPTIONS
	cd $(BOOST_DIR)/libs/program_options/build && $(BOOST_JAM)
endif
ifdef PTXCONF_BOOST_SERIALIZATION
	cd $(BOOST_DIR)/libs/serialization/build && $(BOOST_JAM)
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

boost_install: $(STATEDIR)/boost.install

$(STATEDIR)/boost.install: $(boost_install_deps_default)
	@$(call targetinfo, $@)

	@cd $(BOOST_DIR)/boost; \
	for i in `find . -type d ! -path "*regex/*" ! -path "*thread/*" ! -path "*program_options/*" \
		! -path "serialization/*" ! -path "filessystem/*"`; do \
		if [ ! `ls $$i/*.hpp 2>/dev/null 1>/dev/null; echo $$?` -gt 0 ]; then \
			[ ! -d $(SYSROOT)/usr/include/boost/$$i ] && \
			mkdir -p $(SYSROOT)/usr/include/boost/$$i; \
			cp -f $$i/*.hpp $(SYSROOT)/usr/include/boost/$$i/; \
		fi \
	done

ifdef PTXCONF_BOOST_FILESYSTEM
	@cp -a $(BOOST_DIR)/boost/filesystem/ $(SYSROOT)/usr/include/boost/
endif
ifdef PTXCONF_BOOST_REGEX
	@cp -a \
	  $(BOOST_DIR)/bin/boost/libs/regex/build/libboost_regex.so/gcc/release/shared-linkable-true/libboost_regex-gcc-1_33_1.so \
	  $(SYSROOT)/usr/lib/
	@cp -a $(BOOST_DIR)/boost/regex/ $(BOOST_DIR)/boost/regex.hpp $(SYSROOT)/usr/include/boost/
endif
ifdef PTXCONF_BOOST_THREAD
	@cp -a $(BOOST_DIR)/libs/thread/build/bin-stage/libboost_thread* $(SYSROOT)/usr/lib/
	@cp -a $(BOOST_DIR)/boost/thread/ $(BOOST_DIR)/boost/thread.hpp $(SYSROOT)/usr/include/boost/
endif
ifdef PTXCONF_BOOST_PROGRAM_OPTIONS
	@cp -a $(BOOST_DIR)/boost/program_options/ $(BOOST_DIR)/boost/program_options.hpp $(SYSROOT)/usr/include/boost/
endif
ifdef PTXCONF_BOOST_SERIALIZATION
	@cp -a $(BOOST_DIR)/boost/serialization/ $(SYSROOT)/usr/include/boost/
endif
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

ifdef PTXCONF_BOOST_FILESYSTEM
	@$(call install_copy, boost, 0, 0, 0644, \
		$(BOOST_DIR)/stage/lib/libboost_filesystem-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_filesystem-gcc-d-1_33_1.so.1.33.1)
	@$(call install_link, boost, \
		libboost_filesystem-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_filesystem-gcc-d-1_33_1.so)
endif

ifdef PTXCONF_BOOST_REGEX
	@$(call install_copy, boost, 0, 0, 0644, \
		$(BOOST_DIR)/stage/lib/libboost_regex-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_regex-gcc-d-1_33_1.so.1.33.1)
	@$(call install_link, boost, \
		libboost_regex-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_regex-gcc-d-1_33_1.so)
endif

ifdef PTXCONF_BOOST_THREAD
	@$(call install_copy, boost, 0, 0, 0644, \
		$(BOOST_DIR)/libs/thread/build/bin-stage/libboost_thread-gcc-mt-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_thread-gcc-mt-d-1_33_1.so.1.33.1)
	@$(call install_link, boost, \
		libboost_thread-gcc-mt-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_thread-gcc-mt-d-1_33_1.so)
endif

ifdef PTXCONF_BOOST_PROGRAM_OPTIONS
	@$(call install_copy, boost, 0, 0, 0644, \
		$(BOOST_DIR)/stage/lib/libboost_program_options-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_program_options-gcc-d-1_33_1.so.1.33.1)
	@$(call install_link, boost, \
		libboost_program_options-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_program_options-gcc-d-1_33_1.so)
endif
ifdef PTXCONF_BOOST_SERIALIZATION
	@$(call install_copy, boost, 0, 0, 0644, \
		$(BOOST_DIR)/stage/lib/libboost_serialization-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_serialization-gcc-d-1_33_1.so.1.33.1)
	@$(call install_copy, boost, 0, 0, 0644, \
		$(BOOST_DIR)/stage/lib/libboost_wserialization-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_wserialization-gcc-d-1_33_1.so.1.33.1)

	@$(call install_link, boost, \
		libboost_serialization-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_serialization-gcc-d-1_33_1.so)
	@$(call install_link, boost, \
		libboost_wserialization-gcc-d-1_33_1.so.1.33.1, \
		/usr/lib/libboost_wserialization-gcc-d-1_33_1.so)
endif

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
