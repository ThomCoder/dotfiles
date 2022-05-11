local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14', -- adjust as needed
  name = "lldb"
}
