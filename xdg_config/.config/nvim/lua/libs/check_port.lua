local M = {}

local function is_port_available(port)
  local socket_available = pcall(require, "socket")
  assert(socket_available, 'luasocket is not installed')
  if socket_available then
    local socket = require"socket"
    local server = socket.tcp()
    server:settimeout(5)
    local result = server:bind("127.0.0.1", port)
    server:close()
    if result then
      return true
    else
      return false
    end
  end

end

M.is_port_available = is_port_available

return M
