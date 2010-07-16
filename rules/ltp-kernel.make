# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTP_KERNEL) += ltp-kernel

#
# Paths and names
#
LTP_KERNEL_VERSION	:= $(LTP_BASE_VERSION)
LTP_KERNEL		:= ltp-kernel-$(LTP_BASE_VERSION)
LTP_KERNEL_PKGDIR	= $(PKGDIR)/$(LTP_KERNEL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kernel.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kernel.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ifdef PTXCONF_LTP_KERNEL_NUMA
LTP_KERNEL_BUILD_TARGETS += numa
endif
ifdef PTXCONF_LTP_KERNEL_CONTAINERS
LTP_KERNEL_BUILD_TARGETS += containers
endif
ifdef PTXCONF_LTP_KERNEL_CONTROLLERS
LTP_KERNEL_BUILD_TARGETS += controllers
endif
ifdef PTXCONF_LTP_KERNEL_INCLUDE
LTP_KERNEL_BUILD_TARGETS += include
endif
ifdef PTXCONF_LTP_KERNEL_FS
LTP_KERNEL_BUILD_TARGETS += fs
endif
ifdef PTXCONF_LTP_KERNEL_IO
LTP_KERNEL_BUILD_TARGETS += io
endif
ifdef PTXCONF_LTP_KERNEL_IPC
LTP_KERNEL_BUILD_TARGETS += ipc
endif
ifdef PTXCONF_LTP_KERNEL_MEM
LTP_KERNEL_BUILD_TARGETS += mem
endif
ifdef PTXCONF_LTP_KERNEL_PTY
LTP_KERNEL_BUILD_TARGETS += pty
endif
ifdef PTXCONF_LTP_KERNEL_SCHED
LTP_KERNEL_BUILD_TARGETS += sched
endif
ifdef PTXCONF_LTP_KERNEL_SECURITY
LTP_KERNEL_BUILD_TARGETS += security
endif
ifdef PTXCONF_LTP_KERNEL_SYSCALLS
LTP_KERNEL_BUILD_TARGETS += syscalls
endif
ifdef PTXCONF_LTP_KERNEL_TIMERS
LTP_KERNEL_BUILD_TARGETS += timers
endif

$(STATEDIR)/ltp-kernel.compile:
	@$(call targetinfo)
	@for target in $(LTP_KERNEL_BUILD_TARGETS); do \
		cd $(LTP_BASE_DIR)/testcases/kernel/$$target; \
		$(LTP_ENV) $(MAKE) $(PARALLELMFLAGS); \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kernel.install:
	@$(call targetinfo)
	mkdir -p $(LTP_KERNEL_PKGDIR)/bin
	ln -sf $(LTP_KERNEL_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	for target in $(LTP_KERNEL_BUILD_TARGETS); do \
		cd $(LTP_BASE_DIR)/testcases/kernel/$$target; \
		$(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install; \
	done
	rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kernel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-kernel)
	@$(call install_fixup, ltp-kernel,PRIORITY,optional)
	@$(call install_fixup, ltp-kernel,SECTION,base)
	@$(call install_fixup, ltp-kernel,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-kernel,DESCRIPTION,missing)

	@cd $(LTP_KERNEL_PKGDIR)/bin; \
	for file in `find -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-kernel, 0, 0, $$PER, \
			$(LTP_KERNEL_PKGDIR)/bin/$$file, \
			$(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-kernel)

	@$(call touch)

# vim: syntax=make
