# 
# $Id$
#
# Copyright (C) 2004 by Ladislav Michl
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_SQLITE
PACKAGES += sqlite
endif

#
# Paths and names
#
SQLITE_VERSION		= 3.0.8
SQLITE			= sqlite-$(SQLITE_VERSION)
SQLITE_SUFFIX		= tar.gz
SQLITE_URL		= http://www.sqlite.org/$(SQLITE).$(SQLITE_SUFFIX)
SQLITE_SOURCE		= $(SRCDIR)/$(SQLITE).$(SQLITE_SUFFIX)
SQLITE_DIR		= $(BUILDDIR)/$(SQLITE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sqlite_get: $(STATEDIR)/sqlite.get

sqlite_get_deps = $(SQLITE_SOURCE)

$(STATEDIR)/sqlite.get: $(sqlite_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(SQLITE))
	touch $@

$(SQLITE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SQLITE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sqlite_extract: $(STATEDIR)/sqlite.extract

sqlite_extract_deps = $(STATEDIR)/sqlite.get

$(STATEDIR)/sqlite.extract: $(sqlite_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SQLITE_DIR))
	@$(call extract, $(SQLITE_SOURCE))
	mv $(BUILDDIR)/sqlite $(SQLITE_DIR)
	@$(call patchin, $(SQLITE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sqlite_prepare: $(STATEDIR)/sqlite.prepare

#
# dependencies
#
sqlite_prepare_deps = \
	$(STATEDIR)/sqlite.extract \
	$(STATEDIR)/virtual-xchain.install

SQLITE_PATH	= PATH=$(CROSS_PATH)
SQLITE_ENV 	= $(CROSS_ENV)
SQLITE_MK	= $(SQLITE_DIR)/Makefile.PTXdist

ifdef PTXCONF_SQLITE_ISO8859
SQLITE_ENCODING	= ISO8859
endif
ifdef PTXCONF_SQLITE_UTF8
SQLITE_ENCODING	= UTF8
endif
ifdef PTXCONF_SQLITE_THREADSAFE
SQLITE_THREADSAFE = -DTHREADSAFE=1
endif
ifdef PTXCONF_SQLITE_DISABLE_LFS
SQLITE_DISABLE_LFS = -DSQLITE_DISABLE_LFS
endif

SQLITE_CFLAGS = $(call remove_quotes,$(TARGET_CFLAGS)) -fpic
SQLITE_LDFLAGS = $(call remove_quotes,$(TARGET_LDFLAGS)) -shared -o libsqlite3.so

$(STATEDIR)/sqlite.prepare: $(sqlite_prepare_deps)
	@$(call targetinfo, $@)
	# Create Makefile
	echo "TOP = $(SQLITE_DIR)"				>  $(SQLITE_MK)
	echo "BCC = $(HOSTCC)"					>> $(SQLITE_MK)
	echo "USLEEP = -DHAVE_USLEEP=1"				>> $(SQLITE_MK)
	echo "THREADSAFE = $(SQLITE_THREADSAFE)"		>> $(SQLITE_MK)
	echo "THREADLIB = "					>> $(SQLITE_MK)
	echo "OPTS = -DNDEBUG=1 $(SQLITE_DISABLE_LFS)"		>> $(SQLITE_MK)
	echo "EXE = "						>> $(SQLITE_MK)
	echo "TCC = $(CROSS_CC) $(SQLITE_CFLAGS)"		>> $(SQLITE_MK)
	echo "AR = $(CROSS_AR) cr"				>> $(SQLITE_MK)
	echo "RANLIB = $(CROSS_RANLIB)"				>> $(SQLITE_MK)
	echo "TCL_FLAGS = -DNO_TCL=1"				>> $(SQLITE_MK)
	echo "LIBTCL = "					>> $(SQLITE_MK)
	echo "READLINE_FLAGS = "				>> $(SQLITE_MK)
	echo "LIBREADLINE = "					>> $(SQLITE_MK)
	echo "ENCODING = $(SQLITE_ENCODING)"			>> $(SQLITE_MK)
	echo 'include $$(TOP)/main.mk'				>> $(SQLITE_MK)
	echo 'libsqlite:   $$(LIBOBJ) libsqlite3.a'		>> $(SQLITE_MK)
	echo -e '\t$$(TCCX) $(SQLITE_LDFLAGS) $$(LIBOBJ)'	>> $(SQLITE_MK)
	touch $@
		

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sqlite_compile: $(STATEDIR)/sqlite.compile

sqlite_compile_deps = $(STATEDIR)/sqlite.prepare

$(STATEDIR)/sqlite.compile: $(sqlite_compile_deps)
	@$(call targetinfo, $@)
	cd $(SQLITE_DIR) && $(SQLITE_PATH) make -f $(SQLITE_MK) libsqlite
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sqlite_install: $(STATEDIR)/sqlite.install

$(STATEDIR)/sqlite.install: $(STATEDIR)/sqlite.compile
	@$(call targetinfo, $@)
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	cp $(SQLITE_DIR)/sqlite3.h \
		$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
	cp $(SQLITE_DIR)/libsqlite3.a \
		$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	cp $(SQLITE_DIR)/libsqlite3.so \
		$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sqlite_targetinstall: $(STATEDIR)/sqlite.targetinstall

$(STATEDIR)/sqlite.targetinstall: $(STATEDIR)/sqlite.install
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/lib

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,sqlite)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SQLITE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Ladislav Michl <ladis\@linux-mips.org>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(SQLITE_DIR)/libsqlite3.so, /usr/lib/libsqlite3.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sqlite_clean:
	rm -rf $(STATEDIR)/sqlite.* $(SQLITE_DIR)
	rm -rf $(IMAGEDIR)/sqlite_*

# vim: syntax=make
