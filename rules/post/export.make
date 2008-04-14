# -*-makefile-*-

# input: source=PACKAGE_NAME_SOURCE, output: full path to the source archive
# [HOST|CROSS]_FOO_SOURCE may be empty; try FOO_SOURCE in that case
get_source = $(if $($(source)), $($(source)), $($(subst CROSS_,,$(subst HOST_,,$(source)))))

#FIXME? now copies files twice if selected for host _and_ target. 
export:
	@for i in $(foreach source,$(sources),$(get_source)); do \
		cp -v "$${i}" "$(EXPORTDIR)"; \
	done

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
