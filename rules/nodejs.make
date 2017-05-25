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
NODEJS_VERSION	:= v6.9.5
NODEJS_MD5	:= a2a820b797fb69ffb259b479c7f5df32
NODEJS		:= node-$(NODEJS_VERSION)
NODEJS_SUFFIX	:= tar.gz
NODEJS_URL	:= http://nodejs.org/dist/$(NODEJS_VERSION)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_SOURCE	:= $(SRCDIR)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_DIR	:= $(BUILDDIR)/$(NODEJS)
NODEJS_LICENSE	:= unknown

NODEJS_SRCDIR		:= $(PTXDIST_WORKSPACE)/local_src
NODEJS_MODULE_LIST	:= $(call remove_quotes, $(PTXCONF_NODEJS_MODULE_LIST))
NODEJS_NPMBOXES		:= $(foreach module,$(NODEJS_MODULE_LIST), \
	$(addprefix $(NODEJS_SRCDIR)/,$(addsuffix .npmbox,$(module))))

node/env = \
	$(CROSS_ENV) \
	npm_config_arch=$(NODEJS_ARCH) \
	npm_prefix=$(NODEJS_PKGDIR)/usr/lib \
	npm_config_cache=$(HOST_NODEJS_PKGDIR)/npm \
	npm_config_tmp=$(PTXDIST_TEMPDIR)/nodejs \
	npm_config_nodedir=$(NODEJS_DIR) \
	$(1)

# remove version number from package string
define rmversion
$(shell echo $(1) | sed 's-\<\([^ @]*\)@[^ @]*\>-\1-g')
endef

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nodejs-get: $(NODEJS_NPMBOXES)
PHONY += nodejs-get

$(NODEJS_SRCDIR)/%.npmbox:| $(STATEDIR)/host-nodejs.install.post
	@$(call targetinfo)
	mkdir -p $(NODEJS_SRCDIR)
	cd $(NODEJS_SRCDIR) && \
		$(call node/env, npmbox $(*) --verbose)

# Map package sources and md5sums for world/check_src
NODEJS_MODULE_MD5	:= $(call remove_quotes, $(PTXCONF_NODEJS_MODULE_MD5))
define def_mod
$(call rmversion,$(1))_SOURCE	:= $(addprefix $(NODEJS_SRCDIR)/,$(addsuffix .npmbox,$(1)))
$(call rmversion,$(1))_MD5	:= $(firstword $(NODEJS_MODULE_MD5))
NODEJS_MODULE_MD5 := $(filter-out $(firstword $(NODEJS_MODULE_MD5)),$(NODEJS_MODULE_MD5))
endef
$(foreach module,$(NODEJS_MODULE_LIST),$(eval $(call def_mod,$(module))))

$(STATEDIR)/nodejs.get:
	@$(call targetinfo)
	@$(call world/get, NODEJS)
	@$(call world/check_src, NODEJS)
	@$(foreach npmbox,$(NODEJS_NPMBOXES), \
		if [ ! -e $(npmbox) ]; then \
			echo "NodeJS modules must be downloaded with 'ptxdist make nodejs-get'"; \
			echo ; \
			exit 1; \
		fi;)
	@$(foreach module,$(NODEJS_MODULE_LIST), \
		$(call world/check_src, $(call rmversion,$(module)))$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_X86
ifdef PTXCONF_ARCH_X86_64
NODEJS_ARCH := "x64"
else
NODEJS_ARCH := "ia32"
endif
else
NODEJS_ARCH := $(PTXCONF_ARCH_STRING)
endif

ifdef PTXCONF_ARCH_ARM
NODEJS_ARM_FLOAT_ABI = $(shell ptxd_cross_cc_v | sed -n "s/COLLECT_GCC_OPTIONS=.*'-mfloat-abi=\([^']*\)'.*/\1/p" | tail -n1)
NODEJS_ARM_FPU = $(shell ptxd_cross_cc_v | sed -n "s/COLLECT_GCC_OPTIONS=.*'-mfpu=\([^']*\)'.*/\1/p" | tail -n1)
endif

NODEJS_CONF_TOOL := autoconf
# Use '=' to delay $(shell ...) calls until this is needed
NODEJS_CONF_OPT = \
	--prefix=/usr \
	--dest-cpu=$(NODEJS_ARCH) \
	--dest-os=linux \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM,--with-arm-float-abi=$(NODEJS_ARM_FLOAT_ABI)) \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM,--with-arm-fpu=$(NODEJS_ARM_FPU)) \
	--without-dtrace \
	$(call ptx/ifdef,PTXCONF_NODEJS_NPM,,--without-npm) \
	--shared-openssl \
	--shared-zlib \
	--with-intl=none \
	--without-snapshot

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nodejs.install:
	@$(call targetinfo)
	@$(call install, NODEJS)
	@$(foreach npmbox, $(NODEJS_NPMBOXES), \
		cd $(NODEJS_PKGDIR)/usr/lib/ && \
		$(call node/env, npmunbox -build-from-source $(npmbox))$(ptx/nl))
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

ifneq ($(NODEJS_MODULE_LIST),)
	@$(foreach module, $(call rmversion, $(NODEJS_MODULE_LIST)), \
		$(call install_tree, nodejs, 0, 0, -, /usr/lib/node_modules/$(module))$(ptx/nl))
endif
	@$(call install_finish, nodejs)

	@$(call touch)

# vim: syntax=make
