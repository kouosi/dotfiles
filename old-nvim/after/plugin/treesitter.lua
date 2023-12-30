require('nvim-treesitter.configs').setup {
  ensure_installed = { "vimdoc", "nasm", "make", "c", "zig"},
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
}

