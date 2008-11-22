# $Id: template 2516 2005-04-25 10:29:55Z rsc $
#
# Copyright (C) 2005 by Oscar Peredo
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CKERMIT) += ckermit

#
# Paths and names
#
CKERMIT_VERSION	= 211
CKERMIT		= cku$(CKERMIT_VERSION)
CKERMIT_SUFFIX	= tar.gz
CKERMIT_URL	= http://www.columbia.edu/kermit/ftp/archives/$(CKERMIT).$(CKERMIT_SUFFIX)
CKERMIT_SOURCE	= $(SRCDIR)/$(CKERMIT).$(CKERMIT_SUFFIX)
CKERMIT_DIR	= $(BUILDDIR)/$(CKERMIT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ckermit_get: $(STATEDIR)/ckermit.get

$(STATEDIR)/ckermit.get: $(ckermit_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CKERMIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CKERMIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ckermit_extract: $(STATEDIR)/ckermit.extract

$(STATEDIR)/ckermit.extract: $(ckermit_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CKERMIT_DIR))
	mkdir -p $(CKERMIT_DIR)
	@$(call extract, CKERMIT, $(CKERMIT_DIR))
	@$(call patchin, CKERMIT, $(CKERMIT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ckermit_prepare: $(STATEDIR)/ckermit.prepare

CKERMIT_PATH	=  PATH=$(CROSS_PATH)
CKERMIT_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
CKERMIT_AUTOCONF =  $(CROSS_AUTOCONF_USR)
CKERMIT_DEPS	= $(ckermit_prepare_deps_default)

$(STATEDIR)/ckermit.prepare: $(CKERMIT_DEPS)
	@$(call targetinfo, $@)
	@$(call clean, $(CKERMIT_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ckermit_compile: $(STATEDIR)/ckermit.compile

#CKERMIT_BUILD_OPTS	=  make xermit KTARGET=linuxa CC=powerpc-linux-gcc CC2=gcc CFLAGS="-O -DLINUX -pipe -funsigned-char -DFNFLOAT -DCK_POSIX_SIG -DCK_NEWTERM -DTCPSOCKET -DLINUXFSSTND -DNOCOTFMC -DPOSIX -DUSE_STRERROR -DCK_NCURSES -I/usr/include/ncurses -DHAVE_PTMX -DHAVE_BAUDBOY -DHAVE_CRYPT_H" -k HOST_CC=gcc
CKERMIT_BUILD_OPTS	=  xermit KTARGET=linuxa 
CKERMIT_BUILD_OPTS	+= CC=$(CROSS_CC) CC2=$(CROSS_CC)
CKERMIT_BUILD_OPTS	+= CFLAGS="$(CROSS_CPPFLAGS) -DLINUX -DFNFLOAT -DCK_POSIX_SIG -DCK_NEWTERM -DTCPSOCKET -DLINUXFSSTND -DNOCOTFMC -DPOSIX -DUSE_STRERROR -DCK_NCURSES -DHAVE_PTMX" 
CKERMIT_BUILD_OPTS	+= LNKFLAGS="$(CROSS_LDFLAGS)"
CKERMIT_BUILD_OPTS	+= LIBS="-lncurses -lm -lcrypt -lresolv"
CKERMIT_BUILD_OPTS	+= HOST_CC=gcc

$(STATEDIR)/ckermit.compile: $(ckermit_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CKERMIT_DIR) && $(CKERMIT_ENV) $(CKERMIT_PATH) make $(CKERMIT_BUILD_OPTS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ckermit_install: $(STATEDIR)/ckermit.install

$(STATEDIR)/ckermit.install: $(ckermit_install_deps_default)
	@$(call targetinfo, $@)
	#@$(call install, CKERMIT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ckermit_targetinstall: $(STATEDIR)/ckermit.targetinstall

$(STATEDIR)/ckermit.targetinstall: $(ckermit_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  ckermit)
	@$(call install_fixup, ckermit,PACKAGE,ckermit)
	@$(call install_fixup, ckermit,PRIORITY,optional)
	@$(call install_fixup, ckermit,VERSION,$(CKERMIT_VERSION))
	@$(call install_fixup, ckermit,SECTION,base)
	@$(call install_fixup, ckermit,AUTHOR,"Oscar Peredo <oscar\@exis.cl>")
	@$(call install_fixup, ckermit,DEPENDS,)
	@$(call install_fixup, ckermit,DESCRIPTION,missing)

	@$(call install_copy, ckermit, 0, 0, 0755, $(CKERMIT_DIR)/wermit, /bin/ckermit)

	@$(call install_finish, ckermit)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ckermit_clean:
	rm -rf $(STATEDIR)/ckermit.*
	rm -rf $(IMAGEDIR)/ckermit_*
	rm -rf $(CKERMIT_DIR)

# vim: syntax=make
