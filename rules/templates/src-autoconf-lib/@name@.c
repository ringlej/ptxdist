/*
 * (C) Copyright <year> <your name> <your mail address>
 *
 * <define the license of the file or refer to the main COPYING file>
 */

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

#include <stdlib.h>
#include <stdio.h>

#include "internal.h"
#include "lib@name@.h"

static void @name@_file_private_function(void)
{
}

void @name@_library_private_function(void)
{
}

DSO_VISIBLE int @name@_library_globally_visible_function(void)
{
	printf("lib@name@ opened\n");
	@name@_file_private_function();
	@name@_library_private_function();
	return EXIT_SUCCESS;
}

/* library's paper work */

/* this function will be called, when the library gets loaded */
void INIT_LIB init_function(void)
{
}

/* this function will be called, when the library gets unloaded */
void EXIT_LIB fini_function(void)
{
}
