# -*-makefile-*-

# ----------------------------------------------------------------------------
# environment export to plugins and shell scripts
# ----------------------------------------------------------------------------
# If you run 'ptxdist make dump', you will get two files:
# $(STATEDIR)/environment.symbols <- A list of all internal Variable
#                                    Symbols in the main PTXdist Makefile
# $(STATEDIR)/environment.bash    <- A selection of Variables in bash
#				     syntax. Please adjust M2B_DUMP_VARIABLES
#				     and M2B_DUMP_SUFFIXES to your needs.
# ----------------------------------------------------------------------------
#
# dump all internal make symbols
#

#
# Make to bash export (M2B):
#
M2B=$(STATEDIR)/environment

#
# Select make variables for export to shell (by full name)
#
M2B_DUMP_VARIABLES := \
	PTXCONF_CONFIGFILE_VERSION \
	PTXCONFIG PTXCONF_SYSROOT_TARGET PTXCONF_PROJECT PTXCONF_PROJECT_VERSION \
	PTXDIST_WORKSPACE PTXDIST_TOPDIR \
	PTXDIST PTXDIST_FULLVERSION \
	RULESDIR SCRIPTSDIR STATEDIR SYSROOT WORKDIR \
	PACKAGES- PACKAGES-y PACKAGES-m

#
# Select make variables for export to shell (by suffix)
#
M2B_DUMP_SUFFIXES := _URL _DIR _VERSION _SOURCE

$(M2B).symbols:
	@echo "$(.VARIABLES)" 		\
	| sed s/\ /\\n/g 		\
	| egrep -v "[^A-Z0-9_-]|^_$$" 	\
	| sort -u > $@

dump-symbols: $(M2B).symbols

#
# dump selected symbols with value
#
packages	:= $(PACKAGES-) $(PACKAGES-y) $(PACKAGES-m)
prefixes	:= $(shell echo $(packages) | tr "a-z-" "A-Z_")
symbols		:= $(foreach prefix,$(prefixes),$(foreach suffix,$(M2B_DUMP_SUFFIXES),$(prefix)$(suffix)))
allsymbols	:= $(prefixes) $(shell echo $(symbols) | tr "a-z-" "A-Z_") $(M2B_DUMP_VARIABLES)

$(addprefix dump-,$(sort $(allsymbols))): $(M2B).symbols
	@echo 'M2B_$(call remove_quotes,$(*))="$(call remove_quotes,$($(*)))"' >> $(M2B).bash.tmp
	@echo '$(call remove_quotes,$(*)) $(call remove_quotes,$($(*)))' >> $(M2B).tmp

dump: $(addprefix dump-,$(allsymbols))
	@mv $(M2B).bash.tmp $(M2B).bash
	@mv $(M2B).tmp $(M2B)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
