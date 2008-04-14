# -*-makefile-*-

# ----------------------------------------------------------------------------
# Simulation
# ----------------------------------------------------------------------------

uml_cmdline=
ifdef PTXCONF_KERNEL_HOST_ROOT_HOSTFS
uml_cmdline += root=/dev/root rootflags=$(ROOTDIR) rootfstype=hostfs
endif
ifdef PTXCONF_KERNEL_HOST_CONSOLE_STDSERIAL
uml_cmdline += ssl0=fd:0,fd:1
endif
#uml_cmdline += eth0=slirp
uml_cmdline += $(PTXCONF_KERNEL_HOST_CMDLINE)

run: world
	@$(call targetinfo, "Run Simulation")
ifdef NATIVE
	@echo "starting Linux..."
	@echo
	@$(ROOTDIR)/boot/linux $(call remove_quotes,$(uml_cmdline))
else
	@echo
	@echo "cannot run simulation if not in NATIVE=1 mode"
	@echo
	@exit 1
endif


# vim600:set foldmethod=marker:
# vim600:set syntax=make:
