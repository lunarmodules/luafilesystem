#!/usr/local/bin/lua5.1

local tmp = "/tmp"
local sep = "/"
local upper = ".."

require"lfs"
print (lfs._VERSION)

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
local tmpfile = tmpdir..sep.."tmp_file"
assert (lfs.mkdir (tmpdir), "could not make a new directory")
local attrib, errmsg = lfs.attributes (tmpdir)
if not attrib then
	error ("could not get attributes of file `"..tmpdir.."':\n"..errmsg)
end
local f = io.open(tmpfile, "w")
f:close()

-- Change access time
assert (lfs.touch (tmpfile, 86401))
local new_att = assert (lfs.attributes (tmpfile))
assert (new_att.access == 86401, "could not set access time")
assert (new_att.modification == 86401, "could not set modification time")

-- Change access and modification time
assert (lfs.touch (tmpfile, 86403, 86402))
local new_att = assert (lfs.attributes (tmpfile))
assert (new_att.access == 86403, "could not set access time")
assert (new_att.modification == 86402, "could not set modification time")

-- Restore access time to current value
assert (lfs.touch (tmpfile))
new_att = assert (lfs.attributes (tmpfile))
assert (new_att.access == attrib.access)
assert (new_att.modification == attrib.modification)

-- Remove new file and directory
assert (os.remove (tmpfile), "could not remove new file")
assert (lfs.rmdir (tmpdir), "could not remove new directory")
assert (lfs.mkdir (tmpdir..sep.."lfs_tmp_dir") == nil, "could create a directory inside a non-existent one")

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
