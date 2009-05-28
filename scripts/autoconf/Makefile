CONFIG_SUB_SRC="http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD"
CONFIG_SUB="config.sub"
CONFIG_GUESS_SRC="http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD"
CONFIG_GUESS="config.guess"

all: $(CONFIG_SUB) $(CONFIG_GUESS)

$(CONFIG_SUB):
	@wget $(CONFIG_SUB_SRC) -O $@
	@chmod u+rwx,go+rx-w $@

$(CONFIG_GUESS):
	@wget $(CONFIG_GUESS_SRC) -O $@
	@chmod u+rwx,go+rx-w $@
