-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/khanghoang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/khanghoang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/khanghoang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/khanghoang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/khanghoang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\nO\0\0\2\1\2\0\t-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\3�-\0\0\0009\0\1\0B\0\1\1K\0\1\0\0�\19expand_or_jump\23expand_or_jumpableC\0\0\3\1\2\0\v-\0\0\0009\0\0\0)\2��B\0\2\2\15\0\0\0X\1\4�-\0\0\0009\0\1\0)\2��B\0\2\1K\0\1\0\0�\tjump\rjumpableM\0\0\3\1\2\0\n-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4�-\0\0\0009\0\1\0)\2\1\0B\0\2\1K\0\1\0\0�\18change_choice\18choice_active�\2\1\0\a\0\21\0$6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0026\1\a\0009\1\b\0019\1\t\0015\3\n\0'\4\v\0003\5\f\0005\6\r\0B\1\5\0016\1\a\0009\1\b\0019\1\t\0015\3\14\0'\4\15\0003\5\16\0005\6\17\0B\1\5\0016\1\a\0009\1\b\0019\1\t\1'\3\18\0'\4\19\0003\5\20\0B\1\4\0012\0\0�K\0\1\0\0\n<c-l>\6i\1\0\1\vsilent\2\0\n<c-j>\1\3\0\0\6i\6s\1\0\1\vsilent\2\0\n<c-k>\1\3\0\0\6i\6s\bset\vkeymap\bvim\fluasnip\npaths\1\0\0\1\2\0\0D/home/khanghoang/.config/nvim/lua/snippets/vscode-jest-snippets\14lazy_load luasnip.loaders.from_vscode\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["aerial.nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\b\0\19\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\0016\0\f\0009\0\r\0009\0\14\0005\1\15\0\18\2\0\0'\4\16\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1K\0\1\0\22:AerialToggle<CR>\aso\6n\1\0\1\fnoremap\1\20nvim_set_keymap\bapi\bvim\rbackends\1\4\0\0\blsp\15treesitter\rmarkdown\vguides\1\0\4\rmid_item\v├─\15nested_top\t│ \14last_item\v└─\15whitespace\a  \nicons\1\0\25\rConstant\n  \rVariable\n  \vStruct\n  \nField\n  \16Constructor\n  \rFunction\n  \15EnumMember\n  \vMethod\n  \vFolder\n  \tText\n  \14Reference\n  \nEvent\n  \tFile\n  \rOperator\n  \nColor\n  \18TypeParameter\n  \fSnippet\n  \fKeyword\n  \tEnum\n  \nValue\n  \tUnit\n  \rProperty\n  \vModule\n  \14Interface\n  \nClass\n  \16filter_kind\1\n\0\0\nClass\16Constructor\rConstant\tEnum\rFunction\14Interface\vModule\vMethod\vStruct\1\0\1\14nerd_font\1\nsetup\vaerial\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["bclose.vim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/bclose.vim",
    url = "https://github.com/rbgrouleff/bclose.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  fzf = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.lightline\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/galaxyline.nvim",
    url = "https://github.com/NTBBloodbath/galaxyline.nvim"
  },
  ["gitlinker.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/gitlinker.nvim",
    url = "https://github.com/ruifm/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n�\a\0\0\5\0\28\0\"6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4�6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0029\0\b\0005\2\20\0005\3\n\0005\4\t\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\3=\3\21\0025\3\22\0005\4\23\0=\4\24\0035\4\25\0=\4\26\3=\3\27\2B\0\2\1K\0\1\0\fkeymaps\tn [g\1\2\1\0@&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]g\1\2\1\0@&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\t\vbuffer\2\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\tx ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\to ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\17n <leader>hb0<cmd>lua require\"gitsigns\".blame_line()<CR>\fnoremap\2\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\nsigns\1\0\0\17changedelete\1\0\1\ttext\b│\14topdelete\1\0\1\ttext\b│\vdelete\1\0\1\ttext\b│\vchange\1\0\1\ttext\b│\badd\1\0\0\1\0\1\ttext\b│\nsetup\rgitsigns\frequire\25packadd plenary.nvim\bcmd\bvim\vloaded\17plenary.nvim\19packer_plugins\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/glow.nvim",
    url = "https://github.com/ellisonleao/glow.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n�\24\0\0\3\0\16\0%6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\1\0=\1\5\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0006\0\0\0009\0\1\0+\1\1\0=\1\n\0006\0\0\0009\0\1\0+\1\2\0=\1\v\0006\0\0\0009\0\1\0005\1\r\0=\1\f\0006\0\0\0009\0\14\0'\2\15\0B\0\2\1K\0\1\0001autocmd CursorMoved * IndentBlanklineRefresh\bcmd\1�\1\0\0\31abstract_class_declaration\30abstract_method_signature\27accessibility_modifier\24ambient_declaration\14arguments\narray\18array_pattern\15array_type\19arrow_function\18as_expression\fasserts\26assignment_expression\23assignment_pattern$augmented_assignment_expression\21await_expression\22binary_expression\20break_statement\20call_expression\19call_signature\17catch_clause\nclass\15class_body\22class_declaration\19class_heritage\27computed_property_name\21conditional_type\15constraint\24construct_signature\21constructor_type\23continue_statement\23debugger_statement\16declaration\14decorator\17default_type\17do_statement\16else_clause\20empty_statement\20enum_assignment\14enum_body\21enum_declaration\21existential_type\18export_clause\21export_specifier\21export_statement\15expression\25expression_statement\19extends_clause\19finally_clause\20flow_maybe_type\21for_in_statement\18for_statement\22formal_parameters\rfunction\25function_declaration\23function_signature\18function_type\23generator_function#generator_function_declaration\17generic_type\17if_statement\22implements_clause\vimport\17import_alias\18import_clause\26import_require_clause\21import_specifier\21import_statement\20index_signature\21index_type_query\15infer_type\26interface_declaration\20internal_module\22intersection_type\18jsx_attribute\24jsx_closing_element\16jsx_element\19jsx_expression\17jsx_fragment\23jsx_namespace_name\24jsx_opening_element\29jsx_self_closing_element\22labeled_statement\24lexical_declaration\17literal_type\16lookup_type\23mapped_type_clause\22member_expression\18meta_property\22method_definition\21method_signature\vmodule\18named_imports\21namespace_import\22nested_identifier\27nested_type_identifier\19new_expression\24non_null_expression\vobject\30object_assignment_pattern\19object_pattern\16object_type\29omitting_type_annotation\27opting_type_annotation\23optional_parameter\18optional_type\tpair\17pair_pattern\29parenthesized_expression\23parenthesized_type\fpattern\20predefined_type\23primary_expression\fprogram\23property_signature\28public_field_definition\18readonly_type\nregex\23required_parameter\17rest_pattern\14rest_type\21return_statement\24sequence_expression\19spread_element\14statement\20statement_block\vstring\25subscript_expression\16switch_body\16switch_case\19switch_default\21switch_statement\20template_string\26template_substitution\23ternary_expression\20throw_statement\18try_statement\15tuple_type\27type_alias_declaration\20type_annotation\19type_arguments\19type_parameter\20type_parameters\19type_predicate\30type_predicate_annotation\15type_query\21unary_expression\15union_type\22update_expression\25variable_declaration\24variable_declarator\20while_statement\19with_statement\21yield_expression&indent_blankline_context_patterns*indent_blankline_show_current_context4indent_blankline_show_trailing_blankline_indent\1\3\0\0\rterminal\vnofile%indent_blankline_buftype_exclude\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5&indent_blankline_filetype_exclude#show_trailing_blankline_indent-indent_blankline_show_first_indent_level\b│\26indent_blankline_char\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\5\0\a\0\v6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\4\0=\1\5\4B\2\2\0019\2\6\0B\2\1\1K\0\1\0\22register_progress\16kind_labels\1\0\2\16diagnostics\1\18status_symbol\5\vconfig\1\0\25\rConstant\n  \rVariable\n  \vStruct\n  \nField\n  \16Constructor\n  \rFunction\n  \15EnumMember\n  \vMethod\n  \vFolder\n  \tText\n  \14Reference\n  \nEvent\n  \tFile\n  \rOperator\n  \nColor\n  \18TypeParameter\n  \fSnippet\n  \fKeyword\n  \tEnum\n  \nValue\n  \tUnit\n  \rProperty\n  \vModule\n  \14Interface\n  \nClass\n  \15lsp-status\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  neotest = {
    config = { "\27LJ\2\n�\6\0\0\t\0%\1Y6\0\0\0009\0\1\0)\1d\0=\1\2\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\n\0004\4\3\0006\5\3\0'\a\6\0B\5\2\0025\a\b\0005\b\a\0=\b\t\aB\5\2\0?\5\0\0=\4\v\3B\1\2\0016\1\0\0009\1\f\1'\3\r\0B\1\2\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\17\0'\5\18\0005\6\19\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\20\0'\5\18\0005\6\21\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\22\0'\5\18\0005\6\23\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\24\0'\5\25\0005\6\26\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\24\0'\5\25\0005\6\27\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\28\0'\5\29\0005\6\30\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\31\0'\5 \0005\6!\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\"\0'\5#\0005\6$\0B\1\5\1K\0\1\0\1\0\1\fnoremap\2/:lua require('neotest').summary.open()<CR>\15<leader>to\1\0\1\fnoremap\2<:lua require('neotest').run.run(vim.fn.expand('%'))<CR>\15<leader>tt\1\0\1\fnoremap\2*:lua require('neotest').run.run()<CR>\15<leader>tr\1\0\1\fnoremap\2\1\0\1\fnoremap\2\18:TestLast<CR>\15<leader>tl\1\0\1\fnoremap\2\15<leader>ts\1\0\1\fnoremap\2\15<leader>tf\1\0\1\fnoremap\2\21:TestNearest<CR>\15<leader>tn\6n\20nvim_set_keymap\bapi\26tmap <C-o> <C-\\><C-n>\bcmd\radapters\1\0\0\21ignore_filetypes\1\0\0\1\3\0\0\vpython\blua\21neotest-vim-test\nsetup\fneotest\frequire\26cursorhold_updatetime\6g\bvim\3����\4\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/rcarriga/neotest"
  },
  ["neotest-plenary"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/neotest-plenary",
    url = "https://github.com/rcarriga/neotest-plenary"
  },
  ["neotest-vim-test"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/neotest-vim-test",
    url = "https://github.com/rcarriga/neotest-vim-test"
  },
  ["neovim-colors-solarized-truecolor-only"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/neovim-colors-solarized-truecolor-only",
    url = "https://github.com/frankier/neovim-colors-solarized-truecolor-only"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\t\0\14\0\0296\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1�K\0\1\0009\2\3\0019\2\4\0029\3\3\0019\3\5\0039\4\6\0015\6\a\0004\a\5\0009\b\3\0019\b\b\b9\b\t\b>\b\1\a9\b\3\0019\b\b\b9\b\n\b>\b\2\a9\b\v\2>\b\3\a9\b\f\2>\b\4\a=\a\r\6B\4\2\1K\0\1\0\fsources\23google_java_format\vstylua\rgitsigns\16refactoring\17code_actions\1\0\1\ndebug\1\nsetup\16diagnostics\15formatting\rbuiltins\fnull-ls\frequire\npcall\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\0�\21select_next_item\fvisible�\3\0\2\b\0\5\0\n5\2\0\0006\3\2\0009\3\3\3'\5\4\0009\6\1\0018\6\6\0029\a\1\1B\3\4\2=\3\1\1L\1\2\0\n%s %s\vformat\vstring\tkind\1\0\25\rConstant\n  \rVariable\n  \vStruct\n  \nField\n  \16Constructor\n  \rFunction\n  \15EnumMember\n  \vMethod\n  \vFolder\n  \tText\n  \14Reference\n  \nEvent\n  \tFile\n  \rOperator\n  \nColor\n  \18TypeParameter\n  \fSnippet\n  \fKeyword\n  \tEnum\n  \nValue\n  \tUnit\n  \rProperty\n  \vModule\n  \14Interface\n  \nClass\n  �\3\1\0\n\0\"\0;6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0039\4\b\0009\4\t\0049\4\n\0045\6\f\0009\a\b\0009\a\v\a)\t��B\a\2\2=\a\r\0069\a\b\0009\a\v\a)\t\4\0B\a\2\2=\a\14\0069\a\b\0009\a\15\aB\a\1\2=\a\16\0069\a\b\0009\a\17\aB\a\1\2=\a\18\0069\a\b\0009\a\19\a5\t\20\0B\a\2\2=\a\21\0063\a\22\0=\a\23\6B\4\2\2=\4\b\0034\4\6\0005\5\24\0>\5\1\0045\5\25\0>\5\2\0045\5\26\0>\5\3\0045\5\27\0>\5\4\0045\5\28\0>\5\5\4=\4\29\0035\4\31\0003\5\30\0=\5 \4=\4!\3B\1\2\0012\0\0�K\0\1\0\15formatting\vformat\1\0\0\0\fsources\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\fluasnip\n<Tab>\0\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n�\2\0\0\4\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0=\3\17\2B\0\2\1K\0\1\0\thtml\1\0\1\tmode\15foreground\ttmux\1\0\1\nnames\1\bvim\1\0\1\nnames\2\vstylus\1\0\1\vrgb_fn\2\tsass\1\0\1\vrgb_fn\2\tscss\1\0\1\vrgb_fn\2\bcss\1\5\0\0\15javascript\20javascriptreact\15typescript\20typescriptreact\1\0\1\vrgb_fn\2\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-gps"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rnvim-gps\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-gps",
    url = "https://github.com/SmiteshP/nvim-gps"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tmux-navigation"] = {
    config = { "\27LJ\2\n�\6\0\0\6\0\26\00076\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0005\5\n\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\23\0'\4\24\0005\5\25\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2B:lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>\14<C-Space>\1\0\2\fnoremap\2\vsilent\2H:lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>\n<C-\\>\1\0\2\fnoremap\2\vsilent\2C:lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>\n<C-l>\1\0\2\fnoremap\2\vsilent\2@:lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>\n<C-k>\1\0\2\fnoremap\2\vsilent\2B:lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>\n<C-j>\1\0\2\fnoremap\2\vsilent\2B:lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>\n<C-h>\6n\20nvim_set_keymap\bapi\bvim\1\0\1\24disable_when_zoomed\2\nsetup\25nvim-tmux-navigation\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-tmux-navigation",
    url = "https://github.com/alexghergh/nvim-tmux-navigation"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { "\27LJ\2\n�\b\0\0\a\0+\00096\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0005\4\v\0=\4\f\3=\3\r\0025\3\14\0=\3\15\0025\3\20\0005\4\16\0005\5\17\0005\6\18\0=\6\19\5=\5\f\4=\4\21\0035\4\22\0005\5\23\0=\5\24\0045\5\25\0=\5\26\0045\5\27\0=\5\28\0045\5\29\0=\5\30\4=\4\31\3=\3 \2B\0\2\0016\0\0\0'\2!\0B\0\2\0029\0\"\0B\0\1\0029\1#\0'\2%\0=\2$\0016\1&\0009\1'\1'\3(\0B\1\2\0016\1&\0009\1'\1'\3)\0B\1\2\0016\1&\0009\1'\1'\3*\0B\1\2\1K\0\1\0\21set nofoldenable,set foldexpr=nvim_treesitter#foldexpr()\24set foldmethod=expr\bcmd\bvim\20typescriptreact\fused_by\15typescript\23get_parser_configs\28nvim-treesitter.parsers\16textobjects\tmove\22goto_previous_end\1\0\2\a[M\20@function.outer\a[]\17@class.outer\24goto_previous_start\1\0\2\a[[\17@class.outer\a[m\20@function.outer\18goto_next_end\1\0\2\a]M\20@function.outer\a][\17@class.outer\20goto_next_start\1\0\2\a]]\17@class.outer\a]m\20@function.outer\1\0\2\venable\2\14set_jumps\2\vselect\1\0\0\aiF\1\0\1\20typescriptreact$(function_definition) @function\1\0\5\aic\17@class.inner\aac\17@class.outer\aif\20@function.inner\aaf\20@function.outer\auc\19@comment.outer\1\0\2\venable\2\14lookahead\2\vindent\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\21node_decremental\f<S-TAB>\21node_incremental\f<space>\22scope_incremental\t<CR>\19init_selection\t<CR>\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\b\0\0\15javascript\blua\tbash\ago\tjson\15typescript\vpython\fmatchup\1\0\0\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/oceanic-next",
    url = "https://github.com/mhartington/oceanic-next"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["tabline.nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\b\0\24\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\2B\0\2\0016\0\n\0009\0\v\0'\2\f\0B\0\2\0016\0\0\0'\2\r\0B\0\2\0029\0\2\0005\2\23\0005\3\14\0004\4\0\0=\4\15\0034\4\0\0=\4\16\0034\4\3\0006\5\0\0'\a\1\0B\5\2\0029\5\17\5>\5\1\4=\4\18\0034\4\3\0006\5\0\0'\a\1\0B\5\2\0029\5\19\5>\5\1\4=\4\20\0034\4\0\0=\4\21\0034\4\0\0=\4\22\3=\3\1\2B\0\2\1K\0\1\0\1\0\0\14lualine_z\14lualine_y\14lualine_x\17tabline_tabs\14lualine_c\20tabline_buffers\14lualine_b\14lualine_a\1\0\0\flualine�\1        set guioptions-=e \" Use showtabline in gui vim\n        set sessionoptions+=tabpages,globals \" store tabpages and globals in session\n      \bcmd\bvim\foptions\25component_separators\1\3\0\0\6|\6|\23section_separators\1\0\5\21show_tabs_always\2\18show_devicons\1\15show_bufnr\1\23show_filename_only\2\27max_bufferline_percent\3B\1\3\0\0\6|\6|\1\0\1\venable\2\nsetup\ftabline\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/tabline.nvim",
    url = "https://github.com/kdheepak/tabline.nvim"
  },
  tabular = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["telescope-fzf-native.nvim"] = {
    cond = { true },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tig-explorer.vim"] = {
    commands = { "Tig" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/tig-explorer.vim",
    url = "https://github.com/iberianpig/tig-explorer.vim"
  },
  ["tree-sitter-typescript"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/tree-sitter-typescript",
    url = "https://github.com/tree-sitter/tree-sitter-typescript"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\no\0\0\b\0\a\0\v6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1K\0\1\0\23:TroubleToggle<CR>\att\6n\1\0\1\fnoremap\1\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vifm.vim"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vifm.vim",
    url = "https://github.com/vifm/vifm.vim"
  },
  ["vim-cursorword"] = {
    config = { "\27LJ\2\n�\3\0\0\3\0\n\0$6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0B\0\2\1K\0\1\0\16augroup END/autocmd InsertLeave * let b:cursorword = 1/autocmd InsertEnter * let b:cursorword = 0Gautocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endifQautocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0\rautocmd!#augroup user_plugin_cursorword\17nvim_command\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-cursorword",
    url = "https://github.com/itchyny/vim-cursorword"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-dadbod",
    url = "https://github.com/tpope/vim-dadbod"
  },
  ["vim-dadbod-completion"] = {
    config = { "\27LJ\2\n�\5\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\5        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })\n        \" Source is automatically added, you just need to include it in the chain complete list\n        let g:completion_chain_complete_list = {\n            \\   'sql': [\n            \\    {'complete_items': ['vim-dadbod-completion']},\n            \\   ],\n            \\ }\n        \" Make sure `substring` is part of this list. Other items are optional for this completion source\n        let g:completion_matching_strategy_list = ['exact', 'substring']\n        \" Useful if there's a lot of camel case items\n        let g:completion_matching_ignore_case = 1\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-dadbod-completion",
    url = "https://github.com/kristijanhusak/vim-dadbod-completion"
  },
  ["vim-dadbod-ui"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-dadbod-ui",
    url = "https://github.com/kristijanhusak/vim-dadbod-ui"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-eft"] = {
    config = { "\27LJ\2\n0\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\19eft_ignorecase\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-eft",
    url = "https://github.com/hrsh7th/vim-eft"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/preservim/vim-markdown"
  },
  ["vim-matchup"] = {
    after_files = { "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-prisma"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-prisma",
    url = "https://github.com/pantharshit00/vim-prisma"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  vimspector = {
    config = { "\27LJ\2\n�\5\0\0\b\0\23\0;6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\21\0'\6\22\0\18\a\1\0B\2\5\1K\0\1\0%<Plug>VimspectorToggleBreakpoint\16<leader>dbp <Plug>VimspectorRunToCursor\16<leader>drc$:call vimspector#Continue()<CR>\15<leader>dc$:call vimspector#StopOver()<CR>\15<leader>dj#:call vimspector#StepOut()<CR>\15<leader>dh$:call vimspector#StepInto()<CR>\15<leader>dl#:call vimspector#Restart()<CR>\15<leader>dr!:call vimspector#Reset()<CR>\15<leader>de\":call vimspector#Launch()<CR>\15<leader>dd\6n\1\0\1\fnoremap\1\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/vimspector",
    url = "https://github.com/puremourning/vimspector"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zk-nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\a\0\31\0@6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\0035\4\t\0005\5\n\0=\5\v\4=\4\f\3=\3\r\2B\0\2\0015\0\14\0006\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\19\0'\5\20\0\18\6\0\0B\1\5\0016\1\0\0'\3\21\0B\1\2\0029\1\22\1'\3\1\0B\1\2\0016\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\23\0'\5\24\0\18\6\0\0B\1\5\0016\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\25\0'\5\26\0\18\6\0\0B\1\5\0016\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\27\0'\5\28\0\18\6\0\0B\1\5\0016\1\15\0009\1\16\0019\1\17\1'\3\29\0'\4\27\0'\5\30\0\18\6\0\0B\1\5\1K\0\1\0\22:'<,'>ZkMatch<CR>\6vQ<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>\15<leader>zf\27:Telescope zk tags<CR>\15<leader>zt\28:Telescope zk notes<CR>\15<leader>zo\19load_extension\14telescope7<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>\15<leader>zn\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\1\blsp\16auto_attach\14filetypes\1\2\0\0\rmarkdown\1\0\1\fenabled\2\vconfig\1\0\0\bcmd\1\0\1\tname\azk\1\3\0\0\azk\blsp\1\0\1\vpicker\vselect\nsetup\azk\frequire\0" },
    loaded = true,
    path = "/home/khanghoang/.local/share/nvim/site/pack/packer/start/zk-nvim",
    url = "https://github.com/mickael-menu/zk-nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-tmux-navigation
time([[Config for nvim-tmux-navigation]], true)
try_loadstring("\27LJ\2\n�\6\0\0\6\0\26\00076\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0005\5\n\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\23\0'\4\24\0005\5\25\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2B:lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>\14<C-Space>\1\0\2\fnoremap\2\vsilent\2H:lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>\n<C-\\>\1\0\2\fnoremap\2\vsilent\2C:lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>\n<C-l>\1\0\2\fnoremap\2\vsilent\2@:lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>\n<C-k>\1\0\2\fnoremap\2\vsilent\2B:lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>\n<C-j>\1\0\2\fnoremap\2\vsilent\2B:lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>\n<C-h>\6n\20nvim_set_keymap\bapi\bvim\1\0\1\24disable_when_zoomed\2\nsetup\25nvim-tmux-navigation\frequire\0", "config", "nvim-tmux-navigation")
time([[Config for nvim-tmux-navigation]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n�\a\0\0\5\0\28\0\"6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4�6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0029\0\b\0005\2\20\0005\3\n\0005\4\t\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\3=\3\21\0025\3\22\0005\4\23\0=\4\24\0035\4\25\0=\4\26\3=\3\27\2B\0\2\1K\0\1\0\fkeymaps\tn [g\1\2\1\0@&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]g\1\2\1\0@&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\t\vbuffer\2\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\tx ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\to ih2:<C-U>lua require\"gitsigns\".text_object()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\17n <leader>hb0<cmd>lua require\"gitsigns\".blame_line()<CR>\fnoremap\2\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\nsigns\1\0\0\17changedelete\1\0\1\ttext\b│\14topdelete\1\0\1\ttext\b│\vdelete\1\0\1\ttext\b│\vchange\1\0\1\ttext\b│\badd\1\0\0\1\0\1\ttext\b│\nsetup\rgitsigns\frequire\25packadd plenary.nvim\bcmd\bvim\vloaded\17plenary.nvim\19packer_plugins\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\t\0\14\0\0296\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1�K\0\1\0009\2\3\0019\2\4\0029\3\3\0019\3\5\0039\4\6\0015\6\a\0004\a\5\0009\b\3\0019\b\b\b9\b\t\b>\b\1\a9\b\3\0019\b\b\b9\b\n\b>\b\2\a9\b\v\2>\b\3\a9\b\f\2>\b\4\a=\a\r\6B\4\2\1K\0\1\0\fsources\23google_java_format\vstylua\rgitsigns\16refactoring\17code_actions\1\0\1\ndebug\1\nsetup\16diagnostics\15formatting\rbuiltins\fnull-ls\frequire\npcall\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\no\0\0\b\0\a\0\v6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1K\0\1\0\23:TroubleToggle<CR>\att\6n\1\0\1\fnoremap\1\20nvim_set_keymap\bapi\bvim\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\0�\21select_next_item\fvisible�\3\0\2\b\0\5\0\n5\2\0\0006\3\2\0009\3\3\3'\5\4\0009\6\1\0018\6\6\0029\a\1\1B\3\4\2=\3\1\1L\1\2\0\n%s %s\vformat\vstring\tkind\1\0\25\rConstant\n  \rVariable\n  \vStruct\n  \nField\n  \16Constructor\n  \rFunction\n  \15EnumMember\n  \vMethod\n  \vFolder\n  \tText\n  \14Reference\n  \nEvent\n  \tFile\n  \rOperator\n  \nColor\n  \18TypeParameter\n  \fSnippet\n  \fKeyword\n  \tEnum\n  \nValue\n  \tUnit\n  \rProperty\n  \vModule\n  \14Interface\n  \nClass\n  �\3\1\0\n\0\"\0;6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0039\4\b\0009\4\t\0049\4\n\0045\6\f\0009\a\b\0009\a\v\a)\t��B\a\2\2=\a\r\0069\a\b\0009\a\v\a)\t\4\0B\a\2\2=\a\14\0069\a\b\0009\a\15\aB\a\1\2=\a\16\0069\a\b\0009\a\17\aB\a\1\2=\a\18\0069\a\b\0009\a\19\a5\t\20\0B\a\2\2=\a\21\0063\a\22\0=\a\23\6B\4\2\2=\4\b\0034\4\6\0005\5\24\0>\5\1\0045\5\25\0>\5\2\0045\5\26\0>\5\3\0045\5\27\0>\5\4\0045\5\28\0>\5\5\4=\4\29\0035\4\31\0003\5\30\0=\5 \4=\4!\3B\1\2\0012\0\0�K\0\1\0\15formatting\vformat\1\0\0\0\fsources\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\fluasnip\n<Tab>\0\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: lsp-status.nvim
time([[Config for lsp-status.nvim]], true)
try_loadstring("\27LJ\2\n�\3\0\0\5\0\a\0\v6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\4\0=\1\5\4B\2\2\0019\2\6\0B\2\1\1K\0\1\0\22register_progress\16kind_labels\1\0\2\16diagnostics\1\18status_symbol\5\vconfig\1\0\25\rConstant\n  \rVariable\n  \vStruct\n  \nField\n  \16Constructor\n  \rFunction\n  \15EnumMember\n  \vMethod\n  \vFolder\n  \tText\n  \14Reference\n  \nEvent\n  \tFile\n  \rOperator\n  \nColor\n  \18TypeParameter\n  \fSnippet\n  \fKeyword\n  \tEnum\n  \nValue\n  \tUnit\n  \rProperty\n  \vModule\n  \14Interface\n  \nClass\n  \15lsp-status\frequire\0", "config", "lsp-status.nvim")
time([[Config for lsp-status.nvim]], false)
-- Config for: vimspector
time([[Config for vimspector]], true)
try_loadstring("\27LJ\2\n�\5\0\0\b\0\23\0;6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\21\0'\6\22\0\18\a\1\0B\2\5\1K\0\1\0%<Plug>VimspectorToggleBreakpoint\16<leader>dbp <Plug>VimspectorRunToCursor\16<leader>drc$:call vimspector#Continue()<CR>\15<leader>dc$:call vimspector#StopOver()<CR>\15<leader>dj#:call vimspector#StepOut()<CR>\15<leader>dh$:call vimspector#StepInto()<CR>\15<leader>dl#:call vimspector#Restart()<CR>\15<leader>dr!:call vimspector#Reset()<CR>\15<leader>de\":call vimspector#Launch()<CR>\15<leader>dd\6n\1\0\1\fnoremap\1\20nvim_set_keymap\bapi\bvim\0", "config", "vimspector")
time([[Config for vimspector]], false)
-- Config for: vim-dadbod-completion
time([[Config for vim-dadbod-completion]], true)
try_loadstring("\27LJ\2\n�\5\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\5        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })\n        \" Source is automatically added, you just need to include it in the chain complete list\n        let g:completion_chain_complete_list = {\n            \\   'sql': [\n            \\    {'complete_items': ['vim-dadbod-completion']},\n            \\   ],\n            \\ }\n        \" Make sure `substring` is part of this list. Other items are optional for this completion source\n        let g:completion_matching_strategy_list = ['exact', 'substring']\n        \" Useful if there's a lot of camel case items\n        let g:completion_matching_ignore_case = 1\n      \bcmd\bvim\0", "config", "vim-dadbod-completion")
time([[Config for vim-dadbod-completion]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\n�\5\0\0\b\0\19\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\0016\0\f\0009\0\r\0009\0\14\0005\1\15\0\18\2\0\0'\4\16\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1K\0\1\0\22:AerialToggle<CR>\aso\6n\1\0\1\fnoremap\1\20nvim_set_keymap\bapi\bvim\rbackends\1\4\0\0\blsp\15treesitter\rmarkdown\vguides\1\0\4\rmid_item\v├─\15nested_top\t│ \14last_item\v└─\15whitespace\a  \nicons\1\0\25\rConstant\n  \rVariable\n  \vStruct\n  \nField\n  \16Constructor\n  \rFunction\n  \15EnumMember\n  \vMethod\n  \vFolder\n  \tText\n  \14Reference\n  \nEvent\n  \tFile\n  \rOperator\n  \nColor\n  \18TypeParameter\n  \fSnippet\n  \fKeyword\n  \tEnum\n  \nValue\n  \tUnit\n  \rProperty\n  \vModule\n  \14Interface\n  \nClass\n  \16filter_kind\1\n\0\0\nClass\16Constructor\rConstant\tEnum\rFunction\14Interface\vModule\vMethod\vStruct\1\0\1\14nerd_font\1\nsetup\vaerial\frequire\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: tabline.nvim
time([[Config for tabline.nvim]], true)
try_loadstring("\27LJ\2\n�\5\0\0\b\0\24\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\2B\0\2\0016\0\n\0009\0\v\0'\2\f\0B\0\2\0016\0\0\0'\2\r\0B\0\2\0029\0\2\0005\2\23\0005\3\14\0004\4\0\0=\4\15\0034\4\0\0=\4\16\0034\4\3\0006\5\0\0'\a\1\0B\5\2\0029\5\17\5>\5\1\4=\4\18\0034\4\3\0006\5\0\0'\a\1\0B\5\2\0029\5\19\5>\5\1\4=\4\20\0034\4\0\0=\4\21\0034\4\0\0=\4\22\3=\3\1\2B\0\2\1K\0\1\0\1\0\0\14lualine_z\14lualine_y\14lualine_x\17tabline_tabs\14lualine_c\20tabline_buffers\14lualine_b\14lualine_a\1\0\0\flualine�\1        set guioptions-=e \" Use showtabline in gui vim\n        set sessionoptions+=tabpages,globals \" store tabpages and globals in session\n      \bcmd\bvim\foptions\25component_separators\1\3\0\0\6|\6|\23section_separators\1\0\5\21show_tabs_always\2\18show_devicons\1\15show_bufnr\1\23show_filename_only\2\27max_bufferline_percent\3B\1\3\0\0\6|\6|\1\0\1\venable\2\nsetup\ftabline\frequire\0", "config", "tabline.nvim")
time([[Config for tabline.nvim]], false)
-- Config for: neotest
time([[Config for neotest]], true)
try_loadstring("\27LJ\2\n�\6\0\0\t\0%\1Y6\0\0\0009\0\1\0)\1d\0=\1\2\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\n\0004\4\3\0006\5\3\0'\a\6\0B\5\2\0025\a\b\0005\b\a\0=\b\t\aB\5\2\0?\5\0\0=\4\v\3B\1\2\0016\1\0\0009\1\f\1'\3\r\0B\1\2\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\17\0'\5\18\0005\6\19\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\20\0'\5\18\0005\6\21\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\22\0'\5\18\0005\6\23\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\24\0'\5\25\0005\6\26\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\24\0'\5\25\0005\6\27\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\28\0'\5\29\0005\6\30\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\31\0'\5 \0005\6!\0B\1\5\0016\1\0\0009\1\14\0019\1\15\1'\3\16\0'\4\"\0'\5#\0005\6$\0B\1\5\1K\0\1\0\1\0\1\fnoremap\2/:lua require('neotest').summary.open()<CR>\15<leader>to\1\0\1\fnoremap\2<:lua require('neotest').run.run(vim.fn.expand('%'))<CR>\15<leader>tt\1\0\1\fnoremap\2*:lua require('neotest').run.run()<CR>\15<leader>tr\1\0\1\fnoremap\2\1\0\1\fnoremap\2\18:TestLast<CR>\15<leader>tl\1\0\1\fnoremap\2\15<leader>ts\1\0\1\fnoremap\2\15<leader>tf\1\0\1\fnoremap\2\21:TestNearest<CR>\15<leader>tn\6n\20nvim_set_keymap\bapi\26tmap <C-o> <C-\\><C-n>\bcmd\radapters\1\0\0\21ignore_filetypes\1\0\0\1\3\0\0\vpython\blua\21neotest-vim-test\nsetup\fneotest\frequire\26cursorhold_updatetime\6g\bvim\3����\4\0", "config", "neotest")
time([[Config for neotest]], false)
-- Config for: nvim-gps
time([[Config for nvim-gps]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rnvim-gps\frequire\0", "config", "nvim-gps")
time([[Config for nvim-gps]], false)
-- Config for: zk-nvim
time([[Config for zk-nvim]], true)
try_loadstring("\27LJ\2\n�\5\0\0\a\0\31\0@6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\0035\4\t\0005\5\n\0=\5\v\4=\4\f\3=\3\r\2B\0\2\0015\0\14\0006\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\19\0'\5\20\0\18\6\0\0B\1\5\0016\1\0\0'\3\21\0B\1\2\0029\1\22\1'\3\1\0B\1\2\0016\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\23\0'\5\24\0\18\6\0\0B\1\5\0016\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\25\0'\5\26\0\18\6\0\0B\1\5\0016\1\15\0009\1\16\0019\1\17\1'\3\18\0'\4\27\0'\5\28\0\18\6\0\0B\1\5\0016\1\15\0009\1\16\0019\1\17\1'\3\29\0'\4\27\0'\5\30\0\18\6\0\0B\1\5\1K\0\1\0\22:'<,'>ZkMatch<CR>\6vQ<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>\15<leader>zf\27:Telescope zk tags<CR>\15<leader>zt\28:Telescope zk notes<CR>\15<leader>zo\19load_extension\14telescope7<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>\15<leader>zn\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\1\blsp\16auto_attach\14filetypes\1\2\0\0\rmarkdown\1\0\1\fenabled\2\vconfig\1\0\0\bcmd\1\0\1\tname\azk\1\3\0\0\azk\blsp\1\0\1\vpicker\vselect\nsetup\azk\frequire\0", "config", "zk-nvim")
time([[Config for zk-nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.lightline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\nO\0\0\2\1\2\0\t-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\3�-\0\0\0009\0\1\0B\0\1\1K\0\1\0\0�\19expand_or_jump\23expand_or_jumpableC\0\0\3\1\2\0\v-\0\0\0009\0\0\0)\2��B\0\2\2\15\0\0\0X\1\4�-\0\0\0009\0\1\0)\2��B\0\2\1K\0\1\0\0�\tjump\rjumpableM\0\0\3\1\2\0\n-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4�-\0\0\0009\0\1\0)\2\1\0B\0\2\1K\0\1\0\0�\18change_choice\18choice_active�\2\1\0\a\0\21\0$6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0026\1\a\0009\1\b\0019\1\t\0015\3\n\0'\4\v\0003\5\f\0005\6\r\0B\1\5\0016\1\a\0009\1\b\0019\1\t\0015\3\14\0'\4\15\0003\5\16\0005\6\17\0B\1\5\0016\1\a\0009\1\b\0019\1\t\1'\3\18\0'\4\19\0003\5\20\0B\1\4\0012\0\0�K\0\1\0\0\n<c-l>\6i\1\0\1\vsilent\2\0\n<c-j>\1\3\0\0\6i\6s\1\0\1\vsilent\2\0\n<c-k>\1\3\0\0\6i\6s\bset\vkeymap\bvim\fluasnip\npaths\1\0\0\1\2\0\0D/home/khanghoang/.config/nvim/lua/snippets/vscode-jest-snippets\14lazy_load luasnip.loaders.from_vscode\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Conditional loads
time([[Conditional loading of telescope-fzf-native.nvim]], true)
  require("packer.load")({"telescope-fzf-native.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of telescope-fzf-native.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Tig lua require("packer.load")({'tig-explorer.vim'}, { cmd = "Tig", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-treesitter-textobjects', 'tree-sitter-typescript'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-treesitter-textobjects', 'tree-sitter-typescript'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'nvim-treesitter-textobjects', 'tree-sitter-typescript'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType prisma ++once lua require("packer.load")({'vim-prisma'}, { ft = "prisma" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'glow.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType json ++once lua require("packer.load")({'nvim-treesitter-textobjects'}, { ft = "json" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'nvim-treesitter-textobjects'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType bash ++once lua require("packer.load")({'nvim-treesitter-textobjects'}, { ft = "bash" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'nvim-treesitter-textobjects'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "sass" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-treesitter-textobjects'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-treesitter-textobjects', 'tree-sitter-typescript'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'vim-cursorword'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'vim-cursorword'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-matchup'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'indent-blankline.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]], true)
vim.cmd [[source /home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]]
time([[Sourcing ftdetect script at: /home/khanghoang/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
