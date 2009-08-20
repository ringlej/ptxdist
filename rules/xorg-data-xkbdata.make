# -*-makefile-*-
# $Id: template 4761 2006-02-24 17:35:57Z sha $
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_DATA_XKBDATA) += xorg-data-xkbdata

#
# Paths and names
#
XORG_DATA_XKBDATA_VERSION	:= 1.0.1
XORG_DATA_XKBDATA		:= xkbdata-$(XORG_DATA_XKBDATA_VERSION)
XORG_DATA_XKBDATA_SUFFIX	:= tar.bz2
XORG_DATA_XKBDATA_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/data/$(XORG_DATA_XKBDATA).$(XORG_DATA_XKBDATA_SUFFIX)
XORG_DATA_XKBDATA_SOURCE	:= $(SRCDIR)/$(XORG_DATA_XKBDATA).$(XORG_DATA_XKBDATA_SUFFIX)
XORG_DATA_XKBDATA_DIR		:= $(BUILDDIR)/$(XORG_DATA_XKBDATA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-data-xkbdata_get: $(STATEDIR)/xorg-data-xkbdata.get

$(STATEDIR)/xorg-data-xkbdata.get: $(xorg-data-xkbdata_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DATA_XKBDATA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DATA_XKBDATA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-data-xkbdata_extract: $(STATEDIR)/xorg-data-xkbdata.extract

$(STATEDIR)/xorg-data-xkbdata.extract: $(xorg-data-xkbdata_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DATA_XKBDATA_DIR))
	@$(call extract, XORG_DATA_XKBDATA)
	@$(call patchin, XORG_DATA_XKBDATA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-data-xkbdata_prepare: $(STATEDIR)/xorg-data-xkbdata.prepare

XORG_DATA_XKBDATA_PATH	:=  PATH=$(CROSS_PATH)
XORG_DATA_XKBDATA_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
# define where to install all data files
#
XORG_DATA_XKBDATA_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-data-xkbdata.prepare: $(xorg-data-xkbdata_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DATA_XKBDATA_DIR)/config.cache)
	cd $(XORG_DATA_XKBDATA_DIR) && \
		$(XORG_DATA_XKBDATA_PATH) $(XORG_DATA_XKBDATA_ENV) \
		./configure $(XORG_DATA_XKBDATA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# Note: This step needs an installed xkbcomp on the host
# ----------------------------------------------------------------------------

xorg-data-xkbdata_compile: $(STATEDIR)/xorg-data-xkbdata.compile

$(STATEDIR)/xorg-data-xkbdata.compile: $(xorg-data-xkbdata_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DATA_XKBDATA_DIR) && $(XORG_DATA_XKBDATA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-data-xkbdata_install: $(STATEDIR)/xorg-data-xkbdata.install

$(STATEDIR)/xorg-data-xkbdata.install: $(xorg-data-xkbdata_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DATA_XKBDATA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-data-xkbdata_targetinstall: $(STATEDIR)/xorg-data-xkbdata.targetinstall

$(STATEDIR)/xorg-data-xkbdata.targetinstall: $(xorg-data-xkbdata_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-data-xkbdata)
	@$(call install_fixup, xorg-data-xkbdata,PACKAGE,xorg-data-xkbdata)
	@$(call install_fixup, xorg-data-xkbdata,PRIORITY,optional)
	@$(call install_fixup, xorg-data-xkbdata,VERSION,$(XORG_APP_XKBCOMP_VERSION))
	@$(call install_fixup, xorg-data-xkbdata,SECTION,base)
	@$(call install_fixup, xorg-data-xkbdata,AUTHOR,"Sascha Hauer")
	@$(call install_fixup, xorg-data-xkbdata,DEPENDS,)
	@$(call install_fixup, xorg-data-xkbdata,DESCRIPTION,missing)
#
# create all the required directories
#
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0755, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11)
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0755, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb)
	@for dir in compat compiled geometry keycodes keymap rules semantics \
		symbols torture types; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0755, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/$$dir); \
	done
#
# Install the required files for "compat"
#
	@for file in accessx complete iso9995 keypad lednum misc norepeat pc98 \
		xfree86 basic default japan ledcaps ledscroll mousekeys pc \
		xtest; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/compat/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/compat/$$file,n); \
	done
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
		$(XORG_DATA_XKBDATA_DIR)/compat/compat.dir, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/compat.dir,n)
#
# Install the required files for "geometry"
#
	@for file in amiga chicony fujitsu kinesis microsoft northgate sony \
		winbook ataritt dell everex hp keytronic macintosh nec pc sun; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/geometry/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/geometry/$$file,n); \
	done
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
		$(XORG_DATA_XKBDATA_DIR)/geometry/geometry.dir, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/geometry.dir,n)
#
# Install the required files for "keycodes"
#
	@for file in aliases ataritt fujitsu ibm powerpcps2 sun xfree98 amiga \
		hp macintosh sony xfree86; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/keycodes/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/keycodes/$$file,n); \
	done
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
		$(XORG_DATA_XKBDATA_DIR)/keycodes/keycodes.dir, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/keycodes.dir,n)
#
# Install the required files for "keymap"
#
	@for file in amiga ataritt macintosh sony xfree86 xfree98; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/keymap/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/keymap/$$file,n); \
	done
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
		$(XORG_DATA_XKBDATA_DIR)/keymap/keymap.dir, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/keymap.dir,n)
#
# Install the required files for "rules"
#
	@for file in sgi.lst sun.lst xfree98.lst xml2lst.pl xorg-it.lst \
		xorg.xml sgi sun xfree98 xkb.dtd xorg xorg.lst; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/rules/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/rules/$$file,n); \
	done
#
# Install the required files for "semantics"
#
	@for file in basic complete default xtest; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/semantics/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/semantics/$$file,n); \
	done
#
# Install the required files for "symbols"
# FIXME: Some subdirs are omitted! Add them, if really required
#
	@for file in al ca_enhanced ee group ir lt_a no sapmi syr us_group3 \
		altwin capslock el guj is lt_p ogham se syr_phonetic us_intl \
		am compose en_US gur iso9995-3 lt_std ori se_FI tel uz apple \
		ctrl es it lv se_NO th vn ar cz eurosign hr iu pc104 se_SE \
		th_pat az cz_qwerty fi hr_US jp mk pl th_tis yu be czsk fo \
		hu kan ml pl2 si tj ben de fr hu_qwerty keypad mm pt sk tml bg \
		de_CH  fr_CH hu_US la mn ralt sk_qwerty tr br dev ie level3 mt \
		tr_f bs gb il lo mt_us ro sr ua by dk ge_la il_phonetic lock \
		ro2 srvr_ctrl us ca dvorak ge_ru inet lt nl ru us_group2; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/symbols/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/symbols/$$file,n); \
	done
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
		$(XORG_DATA_XKBDATA_DIR)/symbols/symbols.dir, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/symbols.dir,n)
#
# Install the required files for "symbols/pc"
#
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0755, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/symbols/pc)
	@for file in al az be bt ch dk fi gb hr il is kg latin lv mm nl pk ro \
		si sy tr uz am ba bg by cz ee fo ge hu in it la lk mao mn no pl \
		ru sk th ua vn ara bd br ca de es fr gr ie ir jp latam lt mkd \
		mt pc pt se srp tj us; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/symbols/pc/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/symbols/pc/$$file,n); \
	done
#
# Install the required files for "torture"
#
	@for file in indicator indicator2 mod_compat mod_compat2 mod_compat4 \
		sym_interp1 sym_interp3 types indicator1 indicator3 mod_compat1 \
		mod_compat3 sym_interp sym_interp2 sym_interp4; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/torture/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/torture/$$file,n); \
	done
#
# Install the required files for "types"
#
	@for file in basic cancel caps complete default extra iso9995 mousekeys \
		numpad pc; do \
		$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
			$(XORG_DATA_XKBDATA_DIR)/types/$$file, \
			$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/types/$$file,n); \
	done
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
		$(XORG_DATA_XKBDATA_DIR)/types/types.dir, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb/types.dir,n)
#
# The files above are used by xkbcomp at runtime. It is called whenever you
# configure your keyboard in the xorg.conf. So to make keyboard configuring work
# also xkbcomp is required on the target.
# To make xkbcomp happy with these files an additional symbol definition file
# is required (don't ask my why it is located in a different X package!):
# -> XKeysymDB from the X11 lib package
#
	@$(call install_copy, xorg-data-xkbdata, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/src/XKeysymDB, \
		$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/XKeysymDB,n)
#
# Ready for now
#
	@$(call install_finish, xorg-data-xkbdata)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-data-xkbdata_clean:
	rm -rf $(STATEDIR)/xorg-data-xkbdata.*
	rm -rf $(PKGDIR)/xorg-data-xkbdata_*
	rm -rf $(XORG_DATA_XKBDATA_DIR)

# vim: syntax=make
