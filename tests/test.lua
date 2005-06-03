#!/usr/local/bin/lua

local tmp = "/tmp"
local sep = "/"
local upper = ".."

require"lfs"

function attrdir (path)
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local f = path..sep..file
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
local tmpdir = tmp..sep.."lfs_tmp_dir"
assert (lfs.mkdir (tmpdir), "could not make a new directory")
-- create a new file
local tmpfile = tmpdir..sep.."lfs_tmp_file"
assert (io.open(tmpfile, "w"), "could not make a new file")
local attrib, errmsg = lfs.attributes (tmpfile)
if not attrib then
	error ("could not get attributes of file `"..tmpfile.."':\n"..errmsg)
else
	-- Change access time
	assert (lfs.touch (tmpfile, 11))
	local new_att = assert (lfs.attributes (tmpfile))
	assert (new_att.access == 11, string.format("could not set access time: %s", tostring(new_att.access)))
	assert (new_att.modification == 11, "could not set modification time")
	-- Change access and modification time
	assert (lfs.touch (tmpfile, 33, 22))
	local new_att = assert (lfs.attributes (tmpfile))
	assert (new_att.access == 33, "could not set access time")
	assert (new_att.modification == 22, "could not set modification time")
	-- Restore access time to current value
	assert (lfs.touch (tmpfile))
	new_att = assert (lfs.attributes (tmpfile))
	assert (new_att.access == attrib.access)
	assert (new_att.modification == attrib.modification)
end
assert (os.remove (tmpfile), "could not remove file")
assert (lfs.rmdir (tmpdir), "could not remove new directory")
assert (lfs.mkdir (tmpdir..sep.."lfs_tmp_dir") == false, "could create a directory inside a non-existent one")
-- 
assert (lfs.attributes ("this couldn't be an actual file") == nil, "could get attributes of a non-existent file")
assert (type(lfs.attributes (upper)) == "table", "couldn't get attributes of upper directory")
print"Ok!"
