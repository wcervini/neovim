return {
  "Allaman/emoji.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- requerido
    "hrsh7th/nvim-cmp",              -- opcional para completado
    "nvim-telescope/telescope.nvim", -- opcional
  },
  opts = { enable_cmp_integration = true },
  config = function(_, opts)
    require("emoji").setup(opts)
    -- Opcional Telescope:
    require("telescope").load_extension("emoji")
  end,
}
