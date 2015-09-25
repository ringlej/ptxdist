# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_PPC
PACKAGES-$(PTXCONF_NODEJS) += nodejs
endif

#
# Paths and names
#
NODEJS_VERSION	:= v0.12.7
NODEJS_MD5	:= 5523ec4347d7fe6b0f6dda1d1c7799d5
NODEJS		:= node-$(NODEJS_VERSION)
NODEJS_SUFFIX	:= tar.gz
NODEJS_URL	:= http://nodejs.org/dist/$(NODEJS_VERSION)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_SOURCE	:= $(SRCDIR)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_DIR	:= $(BUILDDIR)/$(NODEJS)
NODEJS_LICENSE	:= unknown

NODEJS_SOURCES += $(foreach module,$(call remove_quotes, $(PTXCONF_NODEJS_MODULE_LIST)),$(addprefix $(SRCDIR)/,$(addsuffix .npmbox,$(module))))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifeq ($(PTXCONF_ARCH_STRING),i386)
NODEJS_ARCH := ia32
else
NODEJS_ARCH := $(PTXCONF_ARCH_STRING)
endif

NODEJS_CONF_TOOL := autoconf
NODEJS_CONF_OPT := \
	--prefix=/usr \
	--dest-cpu=$(NODEJS_ARCH) \
	--without-snapshot \
	--shared-openssl \
	--shared-zlib \
	--dest-os=linux

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# remove version number from package string
define rmversion
$(shell echo $(call remove_quotes, $(1)) | sed 's-\<\([^ @]*\)@[^ @]*\>-\1-g')
endef

node/env = \
	$(CROSS_ENV) \
	npm_config_arch=$(NODEJS_ARCH) \
	npm_prefix=$(NODEJS_PKGDIR)/usr/lib \
	npm_config_cache=$(HOST_NODEJS_PKGDIR)/npm \
	npm_config_tmp=$(PTXDIST_TEMPDIR)/nodejs \
	npm_config_nodedir=$(NODEJS_DIR) \
	$(1)

$(SRCDIR)/%.npmbox:| $(STATEDIR)/host-nodejs.install.post
	@$(call targetinfo)
	@cd $(SRCDIR) && \
		$(call node/env, npmbox $(*) --verbose)

$(STATEDIR)/nodejs.install:
	@$(call targetinfo)
	@$(call install, NODEJS)
	@$(foreach module, $(call remove_quotes, $(PTXCONF_NODEJS_MODULE_LIST)), \
		cd $(NODEJS_PKGDIR)/usr/lib/ && \
		$(call node/env, npmunbox -build-from-source $(SRCDIR)/$(module).npmbox);)
	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nodejs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nodejs)
	@$(call install_fixup, nodejs,PRIORITY,optional)
	@$(call install_fixup, nodejs,SECTION,base)
	@$(call install_fixup, nodejs,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, nodejs,DESCRIPTION,missing)

	@$(call install_copy, nodejs, 0, 0, 0755, -, /usr/bin/node)

#	# the place node searches for packages
	@$(call install_link, nodejs, node_modules, /usr/lib/node)

ifdef PTXCONF_NODEJS_NPM
	@$(call install_link, nodejs, ../lib/node_modules/npm/bin/npm-cli.js, /usr/bin/npm)
	@$(call install_tree, nodejs, 0, 0, -, /usr/lib/node_modules/npm/lib/)
	@$(call install_tree, nodejs, 0, 0, -, /usr/lib/node_modules/npm/bin)
	@$(call install_tree, nodejs, 0, 0, -, /usr/lib/node_modules/npm/scripts)
	@$(call install_tree, nodejs, 0, 0, -, /usr/lib/node_modules/npm/node_modules)
	@$(call install_copy, nodejs, 0, 0, 0644, -, /usr/lib/node_modules/npm/package.json)
endif

ifneq ($(call remove_quotes, $(PTXCONF_NODEJS_MODULE_LIST)),)
	@$(foreach module, $(call rmversion, $(PTXCONF_NODEJS_MODULE_LIST)), \
		$(call install_tree, nodejs, 0, 0, -, /usr/lib/node_modules/$(module));)
endif
	@$(call install_finish, nodejs)

	@$(call touch)

# vim: syntax=make
