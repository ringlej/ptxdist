# -*-makefile-*-
# $Id: gmp3.make,v 1.2 2003/07/22 13:39:15 mkl Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# Paths and names 
#
GMP3_VERSION	= 3.1.1
GMP3		= gmp-$(GMP3_VERSION)
GMP3_SUFFIX	= tar.gz
GMP3_URL	= ftp://ftp.gnu.org/gnu/gmp/$(GMP3).$(GMP3_SUFFIX)
GMP3_SOURCE	= $(SRCDIR)/$(GMP3).$(GMP3_SUFFIX)
GMP3_DIR 	= $(BUILDDIR)/$(GMP3)
GMP3_EXTRACT	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gmp3_get: $(STATEDIR)/gmp3.get

$(STATEDIR)/gmp3.get: $(GMP3_SOURCE)
	@$(call targetinfo, gmp3.get)
	touch $@

$(GMP3_SOURCE):
	@$(call targetinfo, $(GMP3_SOURCE))
	@$(call get, $(GMP3_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gmp3_extract: $(STATEDIR)/gmp3.extract

$(STATEDIR)/gmp3.extract: $(STATEDIR)/gmp3.get
	@$(call targetinfo, gmp3.extract)
	@$(call clean, $(GMP3_DIR))
	@$(call extract, $(GMP3_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gmp3_prepare: $(STATEDIR)/gmp3.prepare

gmp3_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/gmp3.extract

GMP3_PATH	= PATH=$(CROSS_PATH)
GMP3_ENV	= $(CROSS_ENV)

GMP3_AUTOCONF	=
GMP3_AUTOCONF	+= --build=$(GNU_HOST)
GMP3_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
GMP3_AUTOCONF	+= --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/gmp3.prepare: $(gmp3_prepare_deps)
	@$(call targetinfo, gmp3.prepare)
	cd $(GMP3_DIR) && \
		$(GMP3_PATH) $(GMP3_ENV) ./configure $(GMP3_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gmp3_compile: $(STATEDIR)/gmp3.compile

$(STATEDIR)/gmp3.compile: $(STATEDIR)/gmp3.prepare 
	@$(call targetinfo, gmp3.compile)
	$(GMP3_PATH) make -C $(GMP3_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gmp3_install: $(STATEDIR)/gmp3.install

$(STATEDIR)/gmp3.install: $(STATEDIR)/gmp3.compile
	@$(call targetinfo, gmp3.install)
	$(GMP3_PATH) make -C $(GMP3_DIR) install 
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gmp3_targetinstall: $(STATEDIR)/gmp3.targetinstall

$(STATEDIR)/gmp3.targetinstall: $(STATEDIR)/gmp3.install
	@$(call targetinfo, gmp3.targetinstall)
	mkdir -p $(ROOTDIR)/lib
	cp -a $(CROSS_LIB_DIR)/lib/libgmp.so* $(ROOTDIR)/lib
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libgmp.so*
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gmp3_clean: 
	rm -rf $(STATEDIR)/gmp3.* 
	rm -rf $(GMP3_DIR)

# vim: syntax=make
