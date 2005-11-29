#

BEGIN {}

/^.*$/ {
	printf("line=%s\n",$0)
	split($0, a, "[:blank:]")
	printf("a0=%s\n", a[0])
	printf("a1=%s\n", a[1])
}

END {}
