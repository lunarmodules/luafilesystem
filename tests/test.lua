#!/usr/local/bin/lua

local tmp = "/tmp"
local sep = "/"
local upper = ".."

require"lfs"

function attrdir (path)
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = path..'/'..file
			print ("\t=> "..f.." <=")
			local attr = lfs.attributes (f)
			assert (type(attr) == "table")
			if attr.mode == "directory" then
				attrdir (f)
			else
				for name, value in pairs(attr) do
					print (name, value)
				end
			end
		end
	end
end

-- Checking changing directories
local current = assert (lfs.currentdir())
local reldir = string.gsub (current, "^.*%"..sep.."([^"..sep.."])$", "%1")
assert (lfs.chdir (upper), "could not change to upper directory")
assert (lfs.chdir (reldir), "could not change back to current directory")
assert (lfs.currentdir() == current, "error trying to change directories")
assert (lfs.chdir ("this couldn't be an actual directory") == nil, "could change to a non-existent directory")
-- Changing creating and removing directories
assert (lfs.mkdir (tmp.."/lfs_tmp_dir"), "could not make a new directory")
assert (os.remove (tmp.."/lfs_tmp_dir"), "could not remove new directory")
assert (lfs.mkdir (tmp.."/lfs_tmp_dir/lfs_tmp_dir") == false, "could create a directory inside a non-existent one")
-- 
assert (lfs.attributes ("this couldn't be an actual file") == nil, "could get attributes of a non-existent file")
assert (type(lfs.attributes (upper)) == "table", "couldn't get attributes of upper directory")
