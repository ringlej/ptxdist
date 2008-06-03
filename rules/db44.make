# -*-makefile-*-
# $Id: db41.make 5497 2006-05-14 14:27:39Z rsc $
#
# Copyright (C) 2003 by Werner Schmitt mail2ws@gmx.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DB44) += db44

#
# Paths and names
#
DB44_VERSION	= 4.4.20.NC
DB44		= db-$(DB44_VERSION)
DB44_SUFFIX	= tar.gz
DB44_URL	= http://download.oracle.com/berkeley-db/$(DB44).$(DB44_SUFFIX)
DB44_SOURCE	= $(SRCDIR)/$(DB44).$(DB44_SUFFIX)
DB44_DIR	= $(BUILDDIR)/$(DB44)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

db44_get: $(STATEDIR)/db44.get

$(STATEDIR)/db44.get: $(db44_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DB44_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DB44)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

db44_extract: $(STATEDIR)/db44.extract

$(STATEDIR)/db44.extract: $(db44_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DB44_DIR))
	@$(call extract, DB44)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

db44_prepare: $(STATEDIR)/db44.prepare

DB44_PATH	=  PATH=$(CROSS_PATH)
DB44_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
#FIXME add menuconfig options for these
DB44_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
DB44_AUTOCONF   += --disable-cryptography 
DB44_AUTOCONF   += --enable-hash      
DB44_AUTOCONF   += --enable-queue      
DB44_AUTOCONF   += --disable-replication 
DB44_AUTOCONF   += --disable-statistics 
DB44_AUTOCONF   += --disable-verify   
DB44_AUTOCONF   += --enable-compat185  
DB44_AUTOCONF   += --enable-cxx      
DB44_AUTOCONF   += --disable-debug    
DB44_AUTOCONF   += --disable-debug_rop 
DB44_AUTOCONF   += --disable-debug_wop  
DB44_AUTOCONF   += --disable-diagnostic 
DB44_AUTOCONF   += --disable-dump185
DB44_AUTOCONF   += --disable-java 
DB44_AUTOCONF   += --disable-mingw      
DB44_AUTOCONF   += --enable-o_direct    
DB44_AUTOCONF   += --enable-posixmutexes 
DB44_AUTOCONF   += --enable-pthread_self 
DB44_AUTOCONF   += --disable-rpc        
DB44_AUTOCONF   += --enable-smallbuild  
DB44_AUTOCONF   += --disable-tcl 
DB44_AUTOCONF   += --disable-test     
DB44_AUTOCONF   += --disable-uimutexes 
DB44_AUTOCONF   += --disable-umrw
DB44_AUTOCONF   += --enable-shared
DB44_AUTOCONF   += --disable-static
DB44_AUTOCONF   += --enable-largefile


$(STATEDIR)/db44.prepare: $(db44_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DB44_BUILDDIR))
	cd $(DB44_DIR)/build_unix/ && \
		$(DB44_PATH) $(DB44_ENV) \
		../dist/configure $(DB44_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

db44_compile: $(STATEDIR)/db44.compile

$(STATEDIR)/db44.compile: $(db44_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DB44_DIR)/build_unix/ && \
		$(DB44_PATH) $(DB44_ENV) make 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

db44_install: $(STATEDIR)/db44.install

$(STATEDIR)/db44.install: $(db44_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, DB44)
	cd $(DB44_DIR)/build_unix/ && \
		$(DB44_PATH) $(DB44_ENV) make install
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

db44_targetinstall: $(STATEDIR)/db44.targetinstall

$(STATEDIR)/db44.targetinstall: $(db44_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, db44)
	@$(call install_fixup, db44,PACKAGE,db44)
	@$(call install_fixup, db44,PRIORITY,optional)
	@$(call install_fixup, db44,VERSION,$(DB44_VERSION))
	@$(call install_fixup, db44,SECTION,base)
	@$(call install_fixup, db44,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, db44,DEPENDS,)
	@$(call install_fixup, db44,DESCRIPTION,missing)
	
	# FIXME
	#@$(call install_copy, db44, 0, 0, 0755, $(SYSROOT)/bin/db_*, /usr/bin/)

	@$(call install_copy, db44, 0, 0, 0644, \
		$(DB44_DIR)/build_unix/.libs/libdb-4.4.so, \
		/usr/lib/libdb-4.4.so)

	@$(call install_copy, db44, 0, 0, 0644, \
		$(DB44_DIR)/build_unix/.libs/libdb_cxx-4.4.so, \
		/usr/lib/libdb_cxx-4.4.so)

	@$(call install_finish, db44)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

db44_clean:
	rm -rf $(STATEDIR)/db44.*
	rm -rf $(PKGDIR)/db44_*
	rm -rf $(DB44_DIR)

# vim: syntax=make
