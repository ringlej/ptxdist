# -*-makefile-*-
# $Id: template,v 1.14 2004/07/01 16:08:08 rsc Exp $
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CROSSTOOL) += crosstool

#
# Paths and names
#
ifdef PTXCONF_CROSSTOOL_VERSION_0_32
CROSSTOOL_VERSION	= 0.32
endif
ifdef PTXCONF_CROSSTOOL_VERSION_0_38
CROSSTOOL_VERSION       = 0.38
endif
CROSSTOOL		= crosstool-$(CROSSTOOL_VERSION)
CROSSTOOL_SUFFIX	= tar.gz
CROSSTOOL_URL		= http://www.kegel.com/crosstool/$(CROSSTOOL).$(CROSSTOOL_SUFFIX)
CROSSTOOL_SOURCE	= $(SRCDIR)/$(CROSSTOOL).$(CROSSTOOL_SUFFIX)
CROSSTOOL_DIR		= $(CROSS_BUILDDIR)/$(CROSSTOOL)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

crosstool_get: $(STATEDIR)/crosstool.get

$(STATEDIR)/crosstool.get: $(crosstool_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CROSSTOOL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CROSSTOOL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

crosstool_extract: $(STATEDIR)/crosstool.extract

$(STATEDIR)/crosstool.extract: $(crosstool_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSSTOOL_DIR))
	@$(call extract, $(CROSSTOOL_SOURCE), $(CROSS_BUILDDIR))
	@$(call patchin, $(CROSSTOOL),$(CROSSTOOL_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

crosstool_prepare: $(STATEDIR)/crosstool.prepare

CROSSTOOL_PATH	=  PATH=$(CROSS_PATH)

#
# Configuration
#

# FIXME: where do we get this from? 
CROSSTOOL_TARGET_CFLAGS		=  -O

# BSP: I like --with-cpu=strongarm on my x86...
ifdef PTXCONF_ARCH_ARM
CROSSTOOL_GCC_EXTRA_CONFIG	=  "--with-float=soft --with-cpu=strongarm"
endif

ifdef PTXCONF_OPT_PPC405
CROSSTOOL_GCC_EXTRA_CONFIG	= "--with-cpu=405 --enable-cxx-flags=-mcpu=405"
CROSSTOOL_TARGET_CFLAGS		= "-O -mcpu=405"
endif

CROSSTOOL_GCCLANG		=  c
ifdef PTXCONF_CROSSTOOL_GCCLANG_CC
CROSSTOOL_GCCLANG		+= ,c++
endif
CROSSTOOL_GCCLANG		:= $(subst $(quote),,$(CROSSTOOL_GCCLANG)) 
CROSSTOOL_GCCLANG		:= `echo $(CROSSTOOL_GCCLANG) | perl -p -e 's/\s//g'`

ifdef PTXCONF_SOFTFLOAT
CROSSTOOL_GLIBC_EXTRA_CONFIG 	+= --without-fp
endif

ifdef PTXCONF_GLIBC
CROSSTOOL_LIBC_DIR		= glibc-$(GLIBC_VERSION)
CROSSTOOL_LIBC			= glibc
else
ifdef PTXCONF_UCLIBC
CROSSTOOL_LIBC_DIR		= ulibc-$(GLIBC_VERSION)
CROSSTOOL_LIBC			= uclibc
endif
endif

#
# Environment 
#
CROSSTOOL_ENV	=  export ptx_http_proxy=$(PTXCONF_SETUP_HTTP_PROXY); \
	export ptx_ftp_proxy=$(PTXCONF_SETUP_FTP_PROXY); \
	eval export \
	$${ptx_http_proxy:+http_proxy=$${ptx_http_proxy}} \
	$${ptx_ftp_proxy:+ftp_proxy=$${ptx_ftp_proxy}}; \
	TARBALLS_DIR=$(SRCDIR) \
	RESULT_TOP=$(call remove_quotes,$(PTXCONF_PREFIX)) \
	GCC_LANGUAGES="$(CROSSTOOL_GCCLANG)" \
	KERNELCONFIG=$(call remove_quotes,$(CROSSTOOL_DIR)/$(PTXCONF_CROSSTOOL_KERNELCONFIG)) \
	TARGET=$(call remove_quotes,$(PTXCONF_GNU_TARGET)) \
	TARGET_CFLAGS="$(call remove_quotes,$(CROSSTOOL_TARGET_CFLAGS))" \
	GCC_EXTRA_CONFIG=$(CROSSTOOL_GCC_EXTRA_CONFIG) \
	GLIBC_EXTRA_CONFIG=$(CROSSTOOL_GLIBC_EXTRA_CONFIG) \
	BINUTILS_DIR=binutils-$(BINUTILS_VERSION) \
	GCC_DIR=gcc-$(GCC_VERSION) \
	LIBC_DIR=$(CROSSTOOL_LIBC_DIR) \
	C_LIBRARY=$(CROSSTOOL_LIBC) \
	LINUX_DIR=linux-$(PTXCONF_KERNEL_TARGET_VERSION) \
	GLIBCTHREADS_FILENAME=glibc-linuxthreads-$(GLIBC_VERSION)

ifdef PTXCONF_UCLIBC
CROSSTOOL_ENV	+= UCLIBCCONFIG=$(CROSSTOOL_DIR)/uclibc_config
endif

$(STATEDIR)/crosstool.prepare: $(crosstool_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#
# Crosstool installs on 'compile', so we put everything into the install
# target. 
#

crosstool_compile: $(STATEDIR)/crosstool.compile

$(STATEDIR)/crosstool.compile: $(crosstool_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

crosstool_install: $(STATEDIR)/crosstool.install

$(STATEDIR)/crosstool.install: $(crosstool_install_deps_default)
	@$(call targetinfo, $@)
ifdef PTXCONF_UCLIBC
	grep -e PTXCONF_UC_ $(PTXDIST_WORKSPACE)/.config > $(CROSSTOOL_DIR)/uclibc_config
	perl -i -p -e 's/PTXCONF_UC_//g' $(CROSSTOOL_DIR)/uclibc_config
endif

#
# We set all the stuff crosstool expects in it's environment
#
	(	cd $(CROSSTOOL_DIR); 					\
		set -ex; 						\
		mkdir -p $(call remove_quotes,$(PTXCONF_PREFIX)); 	\
		$(CROSSTOOL_ENV) sh $(CROSSTOOL_DIR)/all.sh --notest; 	\
		echo "done" 						\
		exit 1;							\
	)
ifdef PTXCONF_CROSSTOOL_VERSION_0_32
	touch $(call remove_quotes,$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/gcc-$(GCC_VERSION)-$(CROSSTOOL_LIBC_DIR)/$(PTXCONF_GNU_TARGET)/include/linux/autoconf.h)
endif
ifdef PTXCONF_CROSSTOOL_VERSION_0_38
	touch $(call remove_quotes,$(PTXCONF_PREFIX)/gcc-$(GCC_VERSION)-$(CROSSTOOL_LIBC_DIR)/$(PTXCONF_GNU_TARGET)/$(PTXCONF_GNU_TARGET)/include/linux/autoconf.h)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

crosstool_targetinstall: $(STATEDIR)/crosstool.targetinstall

$(STATEDIR)/crosstool.targetinstall: $(crosstool_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

crosstool_clean:
	rm -rf $(STATEDIR)/crosstool.*
	rm -rf $(CROSSTOOL_DIR)

# vim: syntax=make
