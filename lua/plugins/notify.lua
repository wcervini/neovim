return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      timeout = 400,
      top_down = false,
      stages = "fade_in_slide_out",
      render = "default",
      max_width = 60,
    })
    vim.notify = function(msg, level, opts)
      if msg:match("treesitter") then return end
      require("notify")(msg, level, opts)
    end
  end,
} 
