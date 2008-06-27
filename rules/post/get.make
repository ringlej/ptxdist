# -*-makefile-*-

_ptx_get_packages_target:= $(addprefix $(STATEDIR)/,$(addsuffix .get,$(PACKAGES)))
_ptx_get_packages_host	:= $(addprefix $(STATEDIR)/,$(addsuffix .get,$(HOST_PACKAGES)))
_ptx_get_packages_cross	:= $(addprefix $(STATEDIR)/,$(addsuffix .get,$(CROSS_PACKAGES)))

get: $(_ptx_get_packages_target) $(_ptx_get_packages_host) $(_ptx_get_packages_cross)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
