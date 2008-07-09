# -*-makefile-*-
# $Id: template-make 7759 2008-02-12 21:05:07Z mkl $
#
# Copyright (C) 2008 by mol@pengutronix.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QTOPIA_EXAMPLES) += qtopia-examples

#
# Paths and names
#
QTOPIA_EXAMPLES_VERSION	:= 4.4.0
QTOPIA_EXAMPLES		:= qt-embedded-linux-opensource-src-$(QTOPIA_EXAMPLES_VERSION)
QTOPIA_EXAMPLES_DIR	:= $(BUILDDIR)/$(QTOPIA_EXAMPLES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

qtopia-examples_get: $(STATEDIR)/qtopia-examples.get

$(STATEDIR)/qtopia-examples.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

qtopia-examples_extract: $(STATEDIR)/qtopia-examples.extract

$(STATEDIR)/qtopia-examples.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

qtopia-examples_prepare: $(STATEDIR)/qtopia-examples.prepare

QTOPIA_EXAMPLES_PATH		:= PATH=$(CROSS_PATH)
QTOPIA_EXAMPLES_MAKEVARS	:= INSTALL_ROOT=$(SYSROOT)

#
# autoconf
#
QTOPIA_EXAMPLES_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/qtopia-examples.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ifdef PTXCONF_QTOPIA_EXAMPLES_EXAMPLES
QTOPIA_EXAMPLES_BUILD_TARGETS += sub-examples
QTOPIA_EXAMPLES_INSTALL_TARGETS += sub-examples-install_subtargets
endif
ifdef PTXCONF_QTOPIA_EXAMPLES_DEMOS
QTOPIA_EXAMPLES_BUILD_TARGETS += sub-demos
QTOPIA_EXAMPLES_INSTALL_TARGETS += sub-demos-install_subtargets
endif

ifdef PTXCONF_QTOPIA_EXAMPLES_EXAMPLES
QTOPIA_EXAMPLES_LIST := $(call remove_quotes, $(PTXCONF_QTOPIA_EXAMPLES_EXAMPLES_LIST))
endif

ifdef PTXCONF_QTOPIA_EXAMPLES_DEMOS
QTOPIA_DEMOS_LIST := $(call remove_quotes, $(PTXCONF_QTOPIA_EXAMPLES_DEMOS_LIST))
endif


qtopia-examples_compile: $(STATEDIR)/qtopia-examples.compile

$(STATEDIR)/qtopia-examples.compile:
	@$(call targetinfo, $@)
ifdef PTXCONF_QTOPIA_EXAMPLES_EXAMPLES
ifeq ($(QTOPIA_EXAMPLES_LIST)), ALL)
	cd $(QTOPIA_EXAMPLES_DIR) && $(QTOPIA_EXAMPLES_PATH) $(MAKE) \
		$(PARALLELMFLAGS) sub-examples
else
	for example in $(QTOPIA_EXAMPLES_LIST); do \
		cd `dirname $(QTOPIA_EXAMPLES_DIR)/examples/$$example` && \
			$(QTOPIA_EXAMPLES_PATH) $(MAKE) $(PARALLELMFLAGS); \
	done
endif
endif
ifdef PTXCONF_QTOPIA_EXAMPLES_DEMOS
ifeq ($(QTOPIA_DEMOS_LIST)), ALL)
	cd $(QTOPIA_EXAMPLES_DIR) && $(QTOPIA_EXAMPLES_PATH) $(MAKE) \
		$(PARALLELMFLAGS) sub-demos
else
	for demo in shared/Makefile $(QTOPIA_DEMOS_LIST); do \
		cd `dirname $(QTOPIA_EXAMPLES_DIR)/demos/$$demo` && \
			$(QTOPIA_EXAMPLES_PATH) $(MAKE) $(PARALLELMFLAGS); \
	done
endif
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

qtopia-examples_install: $(STATEDIR)/qtopia-examples.install

$(STATEDIR)/qtopia-examples.install:
	@$(call targetinfo, $@)
ifdef PTXCONF_QTOPIA_EXAMPLES_EXAMPLES
ifeq ($(QTOPIA_EXAMPLES_LIST)), ALL)
	cd $(QTOPIA_EXAMPLES_DIR) && $(QTOPIA_EXAMPLES_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-examples-install_subtargets $(QTOPIA_EXAMPLES_MAKEVARS)
else
	for example in $(QTOPIA_EXAMPLES_LIST); do \
		cd `dirname $(QTOPIA_EXAMPLES_DIR)/examples/$$example` && \
			$(QTOPIA_EXAMPLES_PATH) $(MAKE) $(PARALLELMFLAGS) \
			install $(QTOPIA_EXAMPLES_MAKEVARS); \
	done
endif
endif
ifdef PTXCONF_QTOPIA_EXAMPLES_DEMOS
ifeq ($(QTOPIA_DEMOS_LIST)), ALL)
	cd $(QTOPIA_EXAMPLES_DIR) && $(QTOPIA_EXAMPLES_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-demos-install_subtargets $(QTOPIA_EXAMPLES_MAKEVARS)
else
	for demo in $(QTOPIA_DEMOS_LIST); do \
		cd `dirname $(QTOPIA_EXAMPLES_DIR)/demos/$$demo` && \
			$(QTOPIA_EXAMPLES_PATH) $(MAKE) $(PARALLELMFLAGS) \
			install $(QTOPIA_EXAMPLES_MAKEVARS); \
	done
endif
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

qtopia-examples_targetinstall: $(STATEDIR)/qtopia-examples.targetinstall

$(STATEDIR)/qtopia-examples.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, qtopia-examples)
	@$(call install_fixup, qtopia-examples,PACKAGE,qtopia-examples)
	@$(call install_fixup, qtopia-examples,PRIORITY,optional)
	@$(call install_fixup, qtopia-examples,VERSION,$(QTOPIA_EXAMPLES_VERSION))
	@$(call install_fixup, qtopia-examples,SECTION,base)
	@$(call install_fixup, qtopia-examples,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, qtopia-examples,DEPENDS,)
	@$(call install_fixup, qtopia-examples,DESCRIPTION,missing)

ifdef PTXCONF_QTOPIA_EXAMPLES_EXAMPLES
	if [ "$(QTOPIA_EXAMPLES_LIST)" = "ALL" ]; then \
		list=`cd $(QTOPIA_EXAMPLES_DIR)/examples/; find . -type f -perm /+x`; \
	else \
		list="$(QTOPIA_EXAMPLES_LIST)"; \
	fi; \
	for i in $$list; do \
		$(call install_copy, qtopia-examples, 0, 0, 0755, \
			$(QTOPIA_DIR)/examples/$$i, \
			/usr/bin/qt-examples/$$j/$$i); \
	done
endif

ifdef PTXCONF_QTOPIA_EXAMPLES_DEMOS
	if [ "$(QTOPIA_DEMOS_LIST)" = "ALL" ]; then \
		list=`cd $(QTOPIA_EXAMPLES_DIR)/demos/; find . -type f -perm /+x`; \
	else \
		list="$(QTOPIA_DEMOS_LIST)"; \
	fi; \
	for i in $$list; do \
		$(call install_copy, qtopia-examples, 0, 0, 0755, \
			$(QTOPIA_DIR)/demos/$$i, \
			/usr/bin/qt-demos/$$j/$$i); \
	done
endif


	@$(call install_finish, qtopia-examples)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qtopia-examples_clean:
	rm -rf $(STATEDIR)/qtopia-examples.*
	rm -rf $(IMAGEDIR)/qtopia-examples_*
	rm -rf $(QTOPIA_EXAMPLES_DIR)

# vim: syntax=make
