# -*-makefile-*-

GET_PACKAGES		:= $(addprefix $(STATEDIR)/,$(addsuffix .get,$(PACKAGES)))
GET_HOST_PACKAGES	:= $(addprefix $(STATEDIR)/,$(addsuffix .get,$(HOST_PACKAGES)))
GET_CROSS_PACKAGES	:= $(addprefix $(STATEDIR)/,$(addsuffix .get,$(CROSS_PACKAGES)))

get: $(GET_PACKAGES) $(GET_HOST_PACKAGES) $(GET_CROSS_PACKAGES)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
