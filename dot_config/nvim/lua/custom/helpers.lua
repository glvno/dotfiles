local M = {}
-- must be inside or below the folder containing the csproj for this to work
function M.sln_helper_omni(omnisharp_bin, pid)
	local utils = require('lspconfig.util')
	local curr_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	local proj_file_path = utils.root_pattern('*.csproj')(curr_path)
	if proj_file_path == nil then
		proj_file_path = vim.loop.cwd()
	end
	local proj_file_name
	for i in string.gmatch(proj_file_path, "([^\\/]+)") do
		proj_file_name = i
	end
	-- hardcoded exceptions
	if proj_file_name == 'CCI.Public_v3' or proj_file_name == 'CCI.Public_v3.Tests' or proj_file_name == 'CCI.Commerce.CheckoutAntiCorruption' then
			return {omnisharp_bin, '--languageserver', '-s', 'CCI.Commerce'  .. '.sln', '--hostPID', tostring(pid)  }
	elseif proj_file_name == 'CCI.WebUI.RetailAtTarget' then
			return {omnisharp_bin, '--languageserver', '-s', 'WebUI.RetailAtTarget'  .. '.sln', '--hostPID', tostring(pid)  }
		else
			return {omnisharp_bin, '--languageserver', '-s', proj_file_name .. '.sln', '--hostPID', tostring(pid)  }
		end
	end
	return M

