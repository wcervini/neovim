local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local git_tree = function(opts)
  opts = opts or {}
  local results = vim.fn.systemlist("git tree")

  pickers.new(opts, {
    prompt_title = "Git Tree",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return { value = entry, display = entry, ordinal = entry }
      end,
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

vim.api.nvim_create_user_command("GitTree", git_tree, {})

return {}
