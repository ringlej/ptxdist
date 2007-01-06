# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
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
PACKAGES-$(PTXCONF_MYSQL) += mysql

#
# Paths and names
#
MYSQL_VERSION	:= 5.1.14-beta
MYSQL		:= mysql-$(MYSQL_VERSION)
MYSQL_SUFFIX	:= tar.gz
MYSQL_URL	:= ftp://ftp.gwdg.de/pub/misc/mysql/Downloads/MySQL-5.1/$(MYSQL).$(MYSQL_SUFFIX)
MYSQL_SOURCE	:= $(SRCDIR)/$(MYSQL).$(MYSQL_SUFFIX)
MYSQL_DIR	:= $(BUILDDIR)/$(MYSQL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mysql_get: $(STATEDIR)/mysql.get

$(STATEDIR)/mysql.get: $(mysql_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MYSQL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MYSQL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mysql_extract: $(STATEDIR)/mysql.extract

$(STATEDIR)/mysql.extract: $(mysql_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MYSQL_DIR))
	@$(call extract, MYSQL)
	@$(call patchin, MYSQL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mysql_prepare: $(STATEDIR)/mysql.prepare

MYSQL_PATH	:= PATH=$(HOST_MYSQL_DIR)/extra:$(HOST_MYSQL_DIR)/sql:$(CROSS_PATH)

# no := here, please!
MYSQL_ENV = \
	$(CROSS_ENV) \
	ac_cv_path_COMP_ERR=$(HOST_MYSQL_DIR)/extra/comp_err \
	ac_cv_path_GEN_LEX_HASH=$(HOST_MYSQL_DIR)/sql/gen_lex_hash
#
# autoconf
#
MYSQL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-build-mysql=$(HOST_MYSQL_DIR) \
	--without-extra-tools \
	--with-zlib-dir=$(SYSROOT)/usr \
	--without-debug

ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_ARMSCII8
MYSQL_AUTOCONF += --with-charset=armscii8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_ASCII
MYSQL_AUTOCONF += --with-charset=ascii
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_BIG5
MYSQL_AUTOCONF += --with-charset=big5
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1250
MYSQL_AUTOCONF += --with-charset=cp1250
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1251
MYSQL_AUTOCONF += --with-charset=cp1251
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1256
MYSQL_AUTOCONF += --with-charset=cp1256
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1257
MYSQL_AUTOCONF += --with-charset=cp1257
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP850
MYSQL_AUTOCONF += --with-charset=cp850
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP852
MYSQL_AUTOCONF += --with-charset=cp852
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP866
MYSQL_AUTOCONF += --with-charset=cp866
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP932
MYSQL_AUTOCONF += --with-charset=cp932
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_DEC8
MYSQL_AUTOCONF += --with-charset=dec8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_EUCJPMS
MYSQL_AUTOCONF += --with-charset=eucjpms
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_EUCR
MYSQL_AUTOCONF += --with-charset=eucr
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GB2312
MYSQL_AUTOCONF += --with-charset=gb2312
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GBK
MYSQL_AUTOCONF += --with-charset=gbk
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GEOSTD8
MYSQL_AUTOCONF += --with-charset=geostd8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GREEK
MYSQL_AUTOCONF += --with-charset=greek
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_HEBREW
MYSQL_AUTOCONF += --with-charset=hebrew
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_HP8
MYSQL_AUTOCONF += --with-charset=hp8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_KEYBCS2
MYSQL_AUTOCONF += --with-charset=keybcs2
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_KOI8R
MYSQL_AUTOCONF += --with-charset=koi8r
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_KOI8U
MYSQL_AUTOCONF += --with-charset=koi8u
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN1
MYSQL_AUTOCONF += --with-charset=latin1
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN2
MYSQL_AUTOCONF += --with-charset=latin2
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN5
MYSQL_AUTOCONF += --with-charset=latin5
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN7
MYSQL_AUTOCONF += --with-charset=latin7
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_MACCE
MYSQL_AUTOCONF += --with-charset=macce
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_MACROMAN
MYSQL_AUTOCONF += --with-charset=macroman
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_SJIS
MYSQL_AUTOCONF += --with-charset=sjis
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_UCS2
MYSQL_AUTOCONF += --with-charset=ucs2
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_UJIS
MYSQL_AUTOCONF += --with-charset=ujis
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_UTF8
MYSQL_AUTOCONF += --with-charset=utf8
endif

MYSQL_EXTRA_CHARSETS=
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_ARMSCII8
MYSQL_EXTRA_CHARSETS+=armscii8,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_ASCII
MYSQL_EXTRA_CHARSETS+=ascii,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_BIG5
MYSQL_EXTRA_CHARSETS+=big5,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP1250
MYSQL_EXTRA_CHARSETS+=cp1250,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP1251
MYSQL_EXTRA_CHARSETS+=cp1251,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP1256
MYSQL_EXTRA_CHARSETS+=cp1256,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP1257
MYSQL_EXTRA_CHARSETS+=cp1257,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP850
MYSQL_EXTRA_CHARSETS+=cp850,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP852
MYSQL_EXTRA_CHARSETS+=cp852,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP866
MYSQL_EXTRA_CHARSETS+=cp866,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_CP932
MYSQL_EXTRA_CHARSETS+=cp932,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_DEC8
MYSQL_EXTRA_CHARSETS+=dec8,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_EUCJPMS
MYSQL_EXTRA_CHARSETS+=eucjpms,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_EUCR
MYSQL_EXTRA_CHARSETS+=eucr,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_GB2312
MYSQL_EXTRA_CHARSETS+=gb2312,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_GBK
MYSQL_EXTRA_CHARSETS+=gbk,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_GEOSTD8
MYSQL_EXTRA_CHARSETS+=geostd8,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_GREEK
MYSQL_EXTRA_CHARSETS+=greek,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_HEBREW
MYSQL_EXTRA_CHARSETS+=hebrew,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_HP8
MYSQL_EXTRA_CHARSETS+=hp8,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_KEYBCS2
MYSQL_EXTRA_CHARSETS+=keybcs2,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_KOI8R
MYSQL_EXTRA_CHARSETS+=koi8r,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_KOI8U
MYSQL_EXTRA_CHARSETS+=koi8u,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_LATIN1
MYSQL_EXTRA_CHARSETS+=latin1,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_LATIN2
MYSQL_EXTRA_CHARSETS+=latin2,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_LATIN5
MYSQL_EXTRA_CHARSETS+=latin5,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_LATIN7
MYSQL_EXTRA_CHARSETS+=latin7,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_MACCE
MYSQL_EXTRA_CHARSETS+=macce,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_MACROMAN
MYSQL_EXTRA_CHARSETS+=macroman,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_SJIS
MYSQL_EXTRA_CHARSETS+=sjis,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_UCS2
MYSQL_EXTRA_CHARSETS+=ucs2,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_UJIS
MYSQL_EXTRA_CHARSETS+=ujis,
endif
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_UTF8
MYSQL_EXTRA_CHARSETS+=utf8,
endif
MYSQL_EXTRA_CHARSETS_LIST=$(subst $(space),,$(MYSQL_EXTRA_CHARSETS))

ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_NONE
MYSQL_AUTOCONF += --with-extra-charsets=none
else
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_COMPLEX
MYSQL_AUTOCONF += --with-extra-charsets=complex
else
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_ALL
MYSQL_AUTOCONF += --with-extra-charsets=all
else
ifdef PTXCONF_MYSQL_EXTRA_CHARSETS_LIST
ifneq ($(MYSQL_EXTRA_CHARSETS),"")
MYSQL_AUTOCONF += --with-extra-charsets=$(MYSQL_EXTRA_CHARSETS_LIST)
else
MYSQL_AUTOCONF += --with-extra-charsets=none
endif
endif
endif
endif
endif

ifndef PTXCONF_MYSQL_UCA
MYSQL_AUTOCONF += --without-uca
endif
ifneq ($(PTXCONF_MYSQL_SOCKET_PATH),"")
MYSQL_AUTOCONF += --with-unix-socket-path=$(PTXCONF_MYSQL_SOCKET_PATH)
endif
ifneq ($(PTXCONF_MYSQL_TCP_PORT),"")
MYSQL_AUTOCONF += --with-tcp-port=$(PTXCONF_MYSQL_TCP_PORT)
endif
ifdef PTXCONF_MYSQL_WITHOUT_SERVER
MYSQL_AUTOCONF += --without-server
endif
ifdef PTXCONF_MYSQL_WITH_EMBEDDED_SERVER
MYSQL_AUTOCONF += --with-embedded-server
endif
ifndef PTXCONF_MYSQL_QUERY_CACHE
MYSQL_AUTOCONF += --without-query-cache
endif


$(STATEDIR)/mysql.prepare: $(mysql_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MYSQL_DIR)/config.cache)
	cd $(MYSQL_DIR) && \
		$(MYSQL_PATH) $(MYSQL_ENV) \
		./configure $(MYSQL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mysql_compile: $(STATEDIR)/mysql.compile

$(STATEDIR)/mysql.compile: $(mysql_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MYSQL_DIR) && $(MYSQL_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mysql_install: $(STATEDIR)/mysql.install

$(STATEDIR)/mysql.install: $(mysql_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, MYSQL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mysql_targetinstall: $(STATEDIR)/mysql.targetinstall

$(STATEDIR)/mysql.targetinstall: $(mysql_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mysql)
	@$(call install_fixup,mysql,PACKAGE,mysql)
	@$(call install_fixup,mysql,PRIORITY,optional)
	@$(call install_fixup,mysql,VERSION,$(MYSQL_VERSION))
	@$(call install_fixup,mysql,SECTION,base)
	@$(call install_fixup,mysql,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,mysql,DEPENDS,)
	@$(call install_fixup,mysql,DESCRIPTION,missing)

	@$(call install_copy, mysql, 0, 0, 0755, $(MYSQL_DIR)/sql/mysqld, /sbin/mysqld)

	@$(call install_finish,mysql)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mysql_clean:
	rm -rf $(STATEDIR)/mysql.*
	rm -rf $(IMAGEDIR)/mysql_*
	rm -rf $(MYSQL_DIR)

# vim: syntax=make
