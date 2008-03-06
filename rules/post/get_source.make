# input: source=PACKAGE_NAME_SOURCE, output: full path to the source archive
# [HOST|CROSS]_FOO_SOURCE may be empty; try FOO_SOURCE in that case
get_source = $(if $($(source)), $($(source)), $($(subst CROSS_,,$(subst HOST_,,$(source)))))

