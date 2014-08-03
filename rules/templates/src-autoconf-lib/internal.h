/*
 * (C) Copyright <year> <your name> <your mail address>
 *
 * <define the license of the file or refer to the main COPYING file>
 */

#include <assert.h>

#ifdef DSO_HIDDEN
# define DSO_VISIBLE __attribute__ ((visibility("default")))
#else
# define DSO_VISIBLE
#endif

#ifdef PRERUN
# define INIT_LIB __attribute__((constructor))
# define EXIT_LIB __attribute__((destructor))
#else
# define INIT_LIB
# define EXIT_LIB
#endif

/* from @name@.c */
void @name@_library_private_function(void);
