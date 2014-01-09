package = "LuaFileSystem"

version = "cvs-2"

source = {
   url = "https://github.com/keplerproject/luafilesystem/archive/master.zip",
   dir = "luafilesystem-master",
}

description = {
   summary = "File System Library for the Lua Programming Language",
   detailed = [[
      LuaFileSystem is a Lua library developed to complement the set of
      functions related to file systems offered by the standard Lua
      distribution. LuaFileSystem offers a portable way to access the
      underlying directory structure and file attributes.
   ]]
}

dependencies = {
   "lua >= 5.1, < 5.3"
}

build = {
   type = "builtin",
   modules = { lfs = "src/lfs.c" },
   copy_directories = { "doc", "tests" }
}
