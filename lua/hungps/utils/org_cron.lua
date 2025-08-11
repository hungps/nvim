local orgmode = vim.fn.stdpath("data") .. "/site/pack/core/opt/orgmode"
vim.opt.runtimepath:append(orgmode)
-- vim.cmd("packadd orgmode")

local dir = os.getenv("HOME") .. "/Documents/OrgMode"

require("orgmode").cron({
  org_agenda_files = dir .. "/**/*.org",
  org_default_notes_file = dir .. "/refile.org",
  notifications = {
    enabled = true,
    cron_enabled = true,
    repeater_reminder_time = 0,
    deadline_warning_reminder_time = 0,
    reminder_time = { 0, 5, 10 },
    deadline_reminder = true,
    scheduled_reminder = true,
  },
})

--[[
Open the crontab with: crontab -e

Add this line:
* * * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /opt/homebrew/bin/nvim -u NONE --noplugin --headless -c 'lua require("hungps.utils.org_cron")'

Change the nvim & org_cron path to the correct path

See: https://nvim-orgmode.github.io/configuration#cron
]]
