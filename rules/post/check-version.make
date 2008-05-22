#-*-makefile-*-

#
# some black-make-magick:
#
# var					example		meaning
# ----------------------------------------------------------------------------------------------------
# $(1)					"PTX_CV_GTK"	the input
# $($(1))				"2.10.14"	the "should" be version number
# $(subst PTX_CV_,,$(1))_VERSION	"GTK_VERSION"	the variable that holds the is version number
# $($(subst PTX_CV_,,$(1))_VERSION)	"2.10.14"	the "is" version number
#
# we try substitute the "is" version number
# with "" (nothing) in the "should" version number string.
# if this equals "" (nothing) we have the right version,
# if not we bail out with an error
#
# BTW: if someone has a different, better or more elegant solution,
#      I'm courious to see :)
#
define ptx/cv/check
$(if $(subst $($(subst PTX_CV_,,$(1))_VERSION),,$($(1))), \
	$(error Wrong $(subst PTX_CV_,,$(1)) version, you should have "$($(1))", but "$($(subst PTX_CV_,,$(1))_VERSION)" is selected), )
endef

ptx/cv/programs := $(filter PTX_CV_%,$(.VARIABLES))
$(foreach program,$(ptx/cv/programs),$(call ptx/cv/check,$(program)))

# vim: syntax=make
