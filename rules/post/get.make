# -*-makefile-*-

get: $(addprefix $(STATEDIR)/,$(addsuffix .get,$(PACKAGES) $(HOST_PACKAGES) $(CROSS_PACKAGES) $(LAZY_PACKAGES)))

urlcheck: $(addprefix $(STATEDIR)/,$(addsuffix .urlcheck,$(PACKAGES) $(HOST_PACKAGES) $(CROSS_PACKAGES) $(LAZY_PACKAGES)))

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
