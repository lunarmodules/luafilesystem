#!/usr/local/bin/lua -i

require"lfs"

print(lfs.version)

function p ()
	local fh = assert (io.open ("teste", 'r'))
	assert (lfs.lock (fh, 'r'))
	print (fh:read"*a")
	fh:close ()
end

function wr ()
	fh = assert (io.open ("teste", 'w'))
	assert (lfs.lock (fh, 'w'))
end

function op ()
	fh = assert (io.open ("teste", 'r'))
	assert (lfs.lock (fh, 'r'))
end

function fw (x)
	assert (fh:write (x))
end
