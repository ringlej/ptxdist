# -*-makefile-*-

GET_PACKAGES		:= $(addsuffix _get,$(PACKAGES))
GET_HOST_PACKAGES	:= $(addsuffix _get,$(HOST_PACKAGES))
GET_CROSS_PACKAGES	:= $(addsuffix _get,$(CROSS_PACKAGES))

get: $(GET_PACKAGES) $(GET_HOST_PACKAGES) $(GET_CROSS_PACKAGES)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
