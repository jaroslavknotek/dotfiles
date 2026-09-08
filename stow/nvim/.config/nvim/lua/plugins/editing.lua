return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

--  {
--    "numToStr/Comment.nvim",
--    main = "Comment",
--    keys = { "gc", "gb", "gcc", "gbc" },
--    opts = {},
--  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = {},
  -- },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
