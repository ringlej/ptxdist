# -*-makefile-*-

get: $(addprefix $(STATEDIR)/,$(addsuffix .get,$(PTX_PACKAGES_SELECTED)))

urlcheck: $(addprefix $(STATEDIR)/,$(addsuffix .urlcheck,$(PTX_PACKAGES_SELECTED)))

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
