-- $Id: t_luafilesystem.lua,v 1.1 2004/07/27 14:15:24 tomas Exp $
if not luafilesystem and loadlib then
	local libname = "LIB_NAME"
	local libopen = "luaopen_luafilesystem"
	local init, err1, err2 = loadlib (libname, libopen)
	assert (init, (err1 or '')..(err2 or ''))
	init ()
end
