deps_config := \
	Kconfig

.config include/linux/autoconf.h: $(deps_config)

$(deps_config):
