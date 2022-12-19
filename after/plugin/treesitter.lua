require'nvim-treesitter.configs'.setup {
  ensure_installed = {"elixir", "heex", "eex",
    "lua",
    "vim",
    "help",
    "javascript", "svelte", "typescript",
    "ruby",
    "python"
  },
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false;
  },
}

