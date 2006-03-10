/*
** LuaFileSystem
** Copyright Kepler Project 2003-2006 (http://www.keplerproject.org/luafilesystem)
**
** $Id: lfs.h,v 1.2 2006/03/10 22:38:11 carregal Exp $
*/

/* Define 'chdir' for systems that do not implement it */
#ifdef NO_CHDIR
#define chdir(p)	(-1)
#define chdir_error	"Function 'chdir' not provided by system"
#else
#define chdir_error	strerror(errno)
#endif

int luaopen_lfs (lua_State *L);
