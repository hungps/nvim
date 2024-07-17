return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    cmd = { "ObsidianNew", "ObsidianTemplate", "ObsidianSearch", "ObsidianWorkspace" },
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "hungps",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/HungPS",
        },
      },
      notes_subdir = "Notes",
      new_notes_location = "notes_subdir",
      templates = {
        folder = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown" },
    opts = function()
      local opts = {
        markdown = {
          headline_highlights = {},
        },
      }
      for i = 1, 6 do
        local hl = "Headline" .. i
        vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
        table.insert(opts.markdown.headline_highlights, hl)
      end
      return opts
    end,
    config = function(_, opts)
      vim.schedule(function()
        local hl = require "headlines"
        hl.setup(opts)
        local md = hl.config.markdown
        hl.refresh()

        -- Toggle markdown headlines on insert enter/leave
        vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
          callback = function(data)
            if vim.bo.filetype == "markdown" then
              hl.config.markdown = data.event == "InsertLeave" and md or nil
              hl.refresh()
            end
          end,
        })
      end)
    end,
  },
}
