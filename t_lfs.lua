-- $Id: t_lfs.lua,v 1.1 2004/07/29 14:26:33 tomas Exp $
if not lfs and loadlib then
	local libname = "LIB_NAME"
	local libopen = "luaopen_lfs"
	local init, err1, err2 = loadlib (libname, libopen)
	assert (init, (err1 or '')..(err2 or ''))
	init ()
end
