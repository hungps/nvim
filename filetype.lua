vim.filetype.add {
  filename = {
    Brewfile = "ruby",
    Gemfile = "ruby",
    Podfile = "ruby",
    Fastfile = "ruby",
    Pluginfile = "ruby",
  },
}

vim.filetype.add {
  pattern = {
    [".env.*"] = "sh",
  },
}
