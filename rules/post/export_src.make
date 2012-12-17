# -*-makefile-*-

# input: source=PACKAGE_NAME_SOURCE, output: full path to the source archive
# [HOST|CROSS]_FOO_SOURCE may be empty; try FOO_SOURCE in that case
define ptx/export/get_source
$(if $($(source)),$($(source)),$($(subst CROSS_,,$(subst HOST_,,$(source)))))
endef

# iterate over $(PACKAGES_SELECTED) "bash busybox" ->
# convert to "BASH_SOURCE BUSYBOX_SOURCE"
_ptx_export_packages := $(foreach source,$(PTX_PACKAGES_SELECTED),$(PTX_MAP_TO_PACKAGE_$(source))_SOURCES)

# iterate over $(_ptx_export_packages) "BASH_SOURCES BUSYBOX_SOURCES" ->
# convert to "/path/to/bash.tar.bz2 /path/to/busybox.tar.bz2"
# remove duplicates
_ptx_export_packages_src := $(sort $(foreach source,$(_ptx_export_packages),$(ptx/export/get_source)))

# iterate over $(_ptx_export_packages_src) "/path/to/bash.tar.bz2 /path/to/busybox.tar.bz2" ->
# convert to "/export/bash.tar.bz2 /export/busybox.tar.bz2"
_ptx_export_packages_dst := $(subst $(SRCDIR),$(EXPORTDIR),$(_ptx_export_packages_src))

# force copy
.PHONY: $(_ptx_export_packages_dst)
$(_ptx_export_packages_dst): $(_ptx_export_packages_src)
	@cp -av "$(SRCDIR)/$(@F)" "$@"

export_src: $(_ptx_export_packages_dst)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
