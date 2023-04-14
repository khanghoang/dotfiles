--- Check if a file or directory exists in this path
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

--- Check if a directory exists in this path
local function is_dir(path)
	-- "/" works on both Unix and Windows
	return exists(path .. "/")
end

local function mkdir(path)
	os.execute("mkdir " .. path)
end

local function write_file(path, content, mode)
	local fp = io.open(path, mode)
	-- parse object back to json
	local str = string.format("%s", content)
	if fp then
		fp:write(str)
		fp:close()
	end
end

return {
	exists = exists,
	is_dir = is_dir,
	mkdir = mkdir,
	write_file = write_file,
}
