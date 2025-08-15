local orgmode = require("orgmode")
local menu = require("org-modern.menu")

orgmode.setup({
  org_agenda_files = Config.org_path .. "/**/*.org",
  org_default_notes_file = Config.org_path .. "/inbox.org",
  org_todo_keywords = { "TODO(t)", "WAITING(w)", "|", "DONE(d)", "CANCELLED(c)", "DELEGATED(d)" },
  org_startup_folded = "inherit",
  org_todo_keyword_faces = {
    TODO = ":foreground #89dcec :slant bold",
    NEXT = ":background #89dcec :foreground #1e1e2f :slant bold",
    WAITING = ":background #f9e2b0 :foreground #1e1e2f :slant bold",
    DONE = ":background #94e2d6 :foreground #1e1e2f :slant bold",
    CANCELLED = ":foreground #9399b3 :slant italic",
    DELEGATED = ":foreground #9399b3 :slant italic",
  },
  org_cycle_separator_lines = 1,
  org_todo_repeat_to_state = "TODO",
  org_tags_column = 0,
  notifications = {
    enabled = true,
    cron_enabled = true,
    repeater_reminder_time = 0,
    deadline_warning_reminder_time = 0,
    reminder_time = { 0, 5, 10 },
    deadline_reminder = true,
    scheduled_reminder = true,
  },
  org_capture_templates = {
    t = {
      description = "Task",
      template = "** TODO %?\n  %u",
      headline = "Inbox",
      properties = { empty_lines = 1 },
    },
    e = {
      description = "Event",
      template = "** 🗓️️ %?\n  %^T",
      headline = "Inbox",
      properties = { empty_lines = 1 },
    },
  },
  mappings = {
    org = {
      org_add_note = { "<Leader>on" },
      org_babel_tangle = { "<Leader>ob" },
      org_refile = { "<Leader>om" },
    },
  },
  ui = {
    menu = {
      ---@diagnostic disable-next-line: redundant-parameter
      handler = function(data)
        menu
          :new({
            window = {
              margin = { 1, 0, 1, 0 },
              padding = { 0, 1, 0, 1 },
              title_pos = "center",
              border = "single",
              zindex = 1000,
            },
            icons = {
              separator = "➜",
            },
          })
          :open(data)
      end,
    },
  },
})

vim.schedule(function()
  vim.api.nvim_set_hl(0, "@org.headline.level1.org", { link = "@markup.heading.1" })
  vim.api.nvim_set_hl(0, "@org.headline.level2.org", { link = "@markup.heading.2" })
  vim.api.nvim_set_hl(0, "@org.headline.level3.org", { link = "@markup.heading.3" })
  vim.api.nvim_set_hl(0, "@org.headline.level4.org", { link = "@markup.heading.4" })
  vim.api.nvim_set_hl(0, "@org.headline.level5.org", { link = "@markup.heading.5" })
  vim.api.nvim_set_hl(0, "@org.headline.level6.org", { link = "@markup.heading.6" })
  vim.api.nvim_set_hl(0, "@org.headline.level7.org", { link = "@markup.heading.7" })
  vim.api.nvim_set_hl(0, "@org.headline.level8.org", { link = "@markup.heading.8" })
  vim.api.nvim_set_hl(0, "@org.agenda.day", { link = "@markup.link.label" })
  vim.api.nvim_set_hl(0, "@org.agenda.weekend", { link = "@markup.environment" })
  vim.api.nvim_set_hl(0, "@org.agenda.today", { link = "@markup.raw", bold = true })
end)

local has_blinkcmp, blinkcmp = pcall(require, "blink.cmp")
if has_blinkcmp then
  pcall(blinkcmp.add_source_provider, "orgmode", {
    name = "Orgmode",
    module = "orgmode.org.autocompletion.blink",
    fallbacks = { "buffer" },
  })
  pcall(blinkcmp.add_filetype_source, "org", "orgmode")
end

local has_minifiles, minifiles = pcall(require, "mini.files")
if has_minifiles then map("n", "<Leader>fn", function() minifiles.open(Config.org_path) end, "Open notes folder") end

map("n", "<Leader>o", "<nop>", "+Orgmode")

autocmd("Orgmode", augroup("OrgAgenda"), "FileType", { "org", "orgagenda" }, function(ev)
  map("n", "<Leader>oi", "<nop>", "+insert", { buffer = ev.buf })
  map("n", "<Leader>ox", "<nop>", "+time", { buffer = ev.buf })

  vim.b.minihipatterns_disable = true
end)

autocmd("Orgmode", augroup("Org"), "FileType", "org", function(ev)
  map("n", "<Leader>ol", "<nop>", "+link", { buffer = ev.buf })
  map("n", "<Leader>od", "<nop>", "+date", { buffer = ev.buf })
end)

-- stylua: ignore
autocmd("Reindent *.org file on save", augroup("ReindentOrg"), "BufWritePre", "*.org", function()
  vim.cmd([[normal! mzgg=G'z]])
end)

require("org-roam").setup({
  directory = Config.org_path .. "/notes",
  immediate = {
    target = "%<%y%m%d%H%M>-%[slug].org",
  },
  templates = {
    d = {
      description = "Default",
      template = "%?",
      target = "%<%y%m%d%H%M>-%[slug].org",
    },
  },
  bindings = {
    prefix = "<Leader>or",
    add_alias = "<prefix>a",
    remove_alias = "<prefix>A",
    add_origin = "<prefix>o",
    remove_origin = "<prefix>O",
    insert_node = "<prefix>i",
    insert_node_immediate = "<prefix>I",
    capture = "<prefix>c",
    complete_at_point = "<prefix>.",
    find_node = "<prefix>f",
    goto_next_node = "<prefix>n",
    goto_prev_node = "<prefix>p",
    quickfix_backlinks = "<prefix>q",
    toggle_roam_buffer_fixed = "<prefix>b",
    toggle_roam_buffer = "<prefix>B",
  },
})

map("n", "<Leader>or", "<nop>", "+Roam")
map("n", "<Leader>ord", "<nop>", "+Dailies")
