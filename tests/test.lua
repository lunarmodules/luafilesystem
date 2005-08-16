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
local tmpdir = tmp.."/lfs_tmp_dir"
assert (lfs.mkdir (tmpdir), "could not make a new directory")
local attrib, errmsg = lfs.attributes (tmpdir)
if not attrib then
	error ("could not get attributes of file `"..tmpdir.."':\n"..errmsg)
end
-- Change access time
assert (lfs.touch (tmpdir, 11))
local new_att = assert (lfs.attributes (tmpdir))
assert (new_att.access == 11, "could not set access time")
assert (new_att.modification == 11, "could not set modification time")
-- Change access and modification time
assert (lfs.touch (tmpdir, 33, 22))
local new_att = assert (lfs.attributes (tmpdir))
assert (new_att.access == 33, "could not set access time")
assert (new_att.modification == 22, "could not set modification time")
-- Restore access time to current value
assert (lfs.touch (tmpdir))
new_att = assert (lfs.attributes (tmpdir))
assert (new_att.access == attrib.access)
assert (new_att.modification == attrib.modification)
-- Remove new directory
assert (lfs.rmdir (tmpdir), "could not remove new directory")
assert (lfs.mkdir (tmpdir.."/lfs_tmp_dir") == false, "could create a directory inside a non-existent one")
-- Trying to get attributes of a non-existent file
assert (lfs.attributes ("this couldn't be an actual file") == nil, "could get attributes of a non-existent file")
assert (type(lfs.attributes (upper)) == "table", "couldn't get attributes of upper directory")
-- Stressing directory iterator
count = 0
for i = 1, 4000 do
	for file in lfs.dir (tmp) do
		count = count + 1
	end
end
print"Ok!"
