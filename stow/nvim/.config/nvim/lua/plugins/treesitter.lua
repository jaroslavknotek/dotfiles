return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    main = "nvim-treesitter.config",
    opts = {
      ensure_install = {
        "python",
        "lua",
        "vim",
        "vimdoc",
        "rust",
        "json",
        "toml",
        "yaml",
        "bash",
        "markdown",
        "markdown_inline",
      },
    },
  },
}
