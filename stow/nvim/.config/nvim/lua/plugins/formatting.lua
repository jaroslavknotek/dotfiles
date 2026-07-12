return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_format" },
          -- lua = { "stylua" },
          rust = { "rustfmt" },
          -- javascript = { "prettier" },
          -- typescript = { "prettier" },
        },
      })

      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
        })
      end, { desc = "Format file" })
    end,
  },
}
