return {
  "404pilo/aicommits.nvim",
  config = function()
    require("aicommits").setup({
      -- Conventional commits: header should be <= 72 chars
      providers = {
        openai = {
          max_length = 72,
          generate = 3,  -- Generate multiple options
        },
      },
    })
  end,
}
