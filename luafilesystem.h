/* Define 'chdir' for systems that do not implement it */
/* $Id: luafilesystem.h,v 1.1 2004/07/27 14:15:24 tomas Exp $ */
#ifdef NO_CHDIR
#define chdir(p)	(-1)
#define chdir_error	"Function 'chdir' not provided by system"
#else
#define chdir_error	strerror(errno)
#endif

int luaopen_filesystem (lua_State *L);
