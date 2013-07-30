#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)
AC_INIT(cram, 0.1, yzhou7@gmail.com)
AC_CONFIG_SRCDIR([src/cram.h])
AM_INIT_AUTOMAKE
AM_CONFIG_HEADER([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.
#LIBS="-lSDL"
#AC_ARG_WITH(SDL,
#	AC_HELP_STRING(
#		[--with-SDL=prefix],
#		[/usr/local/SDL/]
#	),
#	SDL_PATHSET=1,
#	SDL_PATHSET=0
#)

#if test $SDL_PATHSET = 1; then
#	CXXFLAGS="$CXXFLAGS -I$with_SDL/include"
#	CFLAGS="$CFLAGS -I$with_SDL/include"
#	LDFLAGS="$LDFLAGS -L$with_SDL/lib"
#fi
#
#AC_SUBST(GLOBALCXXFLAGS, $CXXFLAGS )
#AC_SUBST(GLOBALLDFLAGS, $LDFLAGS )

#AC_MSG_CHECKING([for the SDL header])
#AC_COMPILE_IFELSE(
#	[ #include ],
#	[
#		AC_MSG_RESULT(yes)
#		SDL_NOTFOUND=0;	
#	],
#	[
#		AC_MSG_RESULT(no)
#		SDL_NOTFOUND=1;
#	]
#)

SDL_VERSION=1.0.8
AM_PATH_SDL($SDL_VERSION,
            :,
	    AC_MSG_ERROR([*** SDL version $SDL_VERSION not found!])
)
# Add the SDL preprocessor flags and libraries to the build process
CFLAGS="$CFLAGS $SDL_CFLAGS -lSDL_ttf"
CXXFLAGS="$CXXFLAGS $SDL_CFLAGS"
LIBS="$LIBS $SDL_LIBS"

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([string.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
