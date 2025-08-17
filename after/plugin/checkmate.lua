local local_todo_dir = vim.fn.stdpath("data") .. "/projects/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
local local_todo_path = local_todo_dir .. "/TODO.md"

local get_local_todo_path = function()
  vim.fn.mkdir(local_todo_dir, "p")
  return local_todo_path
end

local get_todo_path = function()
  local todo_path = vim.fn.getcwd() .. "/TODO.md"
  if vim.loop.fs_stat(todo_path) then return todo_path end

  return get_local_todo_path()
end

vim.schedule(function()
  local checkmate = require("checkmate")

  local toggle_state = function(new_state)
    if new_state ~= "checked" then checkmate.remove_metadata("done") end

    if new_state == "started" then checkmate.add_metadata("started") end
    if new_state == "checked" then checkmate.add_metadata("done") end

    checkmate.toggle(new_state)
  end

  checkmate.setup({
    files = {
      "TODO.md",
      local_todo_path,
    },
    todo_states = {
      unchecked = {
        marker = "□",
        order = 1,
      },
      started = {
        marker = "◐",
        markdown = ".",
        type = "incomplete",
        order = 2,
      },
      checked = {
        marker = "✔",
        order = 3,
      },
      cancelled = {
        marker = "✗",
        markdown = "-",
        type = "complete",
        order = 10,
      },
      hold = {
        marker = "⏸",
        markdown = "/",
        type = "inactive",
        order = 11,
      },
    },
    smart_toggle = {
      enabled = true,
      check_down = "all_children",
      uncheck_down = "none",
      check_up = "direct_children",
      uncheck_up = "direct_children",
    },
    keys = {
      ["<leader>Tc"] = false,
      ["<leader>Tu"] = false,
      ["<leader>T-"] = false,
      ["<leader>TR"] = false,
      ["<leader>Tt"] = false,
      ["<leader>Tn"] = false,
      ["<leader>Tv"] = false,
      ["<leader>T="] = false,
      ["<leader>T]"] = false,
      ["<leader>T["] = false,
      ["<leader>TA"] = false,
      -- Basic mappings
      ["<Tab>"] = {
        rhs = function()
          local todo = checkmate.get_todo({ bufnr = 0, row = vim.fn.line(".") - 1 })
          if not todo then return end

          if todo.is_checked() then
            toggle_state("unchecked")
          else
            toggle_state("checked")
          end
        end,
        desc = "Toggle todo/done",
        modes = { "n", "v" },
      },
      ["<S-Tab>"] = {
        rhs = function() checkmate.cycle() end,
        desc = "Cycle todo states",
        modes = { "n", "v" },
      },
      ["<Enter>"] = {
        rhs = function() checkmate.create() end,
        desc = "Create todo",
        modes = { "n" },
      },
      ["<leader>Ta"] = {
        rhs = function() checkmate.archive() end,
        desc = "Archive checked/completed todos",
        modes = { "n" },
      },
      ["<leader>Tr"] = {
        rhs = function() checkmate.remove_all_metadata() end,
        desc = "Remove all metadata",
        modes = { "n", "v" },
      },
      ["]m"] = {
        rhs = function() checkmate.jump_next_metadata() end,
        desc = "Move cursor to next metadata tag",
        modes = { "n" },
      },
      ["[m"] = {
        rhs = function() checkmate.jump_previous_metadata() end,
        desc = "Move cursor to previous metadata tag",
        modes = { "n" },
      },
      -- Toggle state
      ["<Leader>Ttt"] = {
        rhs = function() toggle_state("unchecked") end,
        desc = "Todo",
        modes = { "n", "v" },
      },
      ["<Leader>Ttd"] = {
        rhs = function() toggle_state("checked") end,
        desc = "Done",
        modes = { "n", "v" },
      },
      ["<Leader>Tti"] = {
        rhs = function() toggle_state("started") end,
        desc = "In progress",
        modes = { "n", "v" },
      },
      ["<Leader>Ttc"] = {
        rhs = function() toggle_state("cancelled") end,
        desc = "Cancelled",
        modes = { "n", "v" },
      },
      ["<Leader>Tth"] = {
        rhs = function() toggle_state("hold") end,
        desc = "On hold",
        modes = { "n", "v" },
      },
      -- Toggle priority
      ["<leader>Tpl"] = {
        rhs = function() checkmate.toggle_metadata("priority", "low") end,
        desc = "Low",
        modes = { "n" },
      },
      ["<leader>Tpn"] = {
        rhs = function() checkmate.remove_metadata("priority") end,
        desc = "Normal",
        modes = { "n" },
      },
      ["<leader>Tph"] = {
        rhs = function() checkmate.toggle_metadata("priority", "high") end,
        desc = "Low",
        modes = { "n" },
      },
    },
    metadata = {
      priority = {
        style = function(context)
          local value = context.value:lower()
          if value == "high" then return { fg = "#ff5555", bold = true } end
          return { fg = "#8be9fd", bold = true }
        end,
        get_value = function() return "high" end,
        choices = function() return { "low", "high" } end,
        sort_order = 1,
      },
      started = {
        aliases = { "when" },
        style = { fg = "#9fd6d5", bold = true },
        get_value = function() return tostring(os.date("%d/%m/%y %H:%M")) end,
        sort_order = 10,
      },
      due = {
        aliases = { "deadline", "end" },
        style = { fg = "#ebcb8b", bold = true },
        get_value = function() return tostring(os.date("%d/%m/%y %H:%M")) end,
        sort_order = 11,
      },
      done = {
        aliases = { "completed", "finished" },
        style = { fg = "#96de7a", bold = true },
        get_value = function() return tostring(os.date("%m/%d/%y %H:%M")) end,
        sort_order = 12,
      },
    },
  })

  map("n", "<Leader>T", "<nop>", "+Todo")
  map("n", "<Leader>Tt", "<nop>", "+Toggle")
  map("n", "<Leader>Tm", "<nop>", "+Metadata")
  map("n", "<Leader>To", function() vim.cmd("15split | edit " .. get_todo_path()) end, "Open todo")
  map("n", "<Leader>TO", function() vim.cmd("15split | edit " .. get_local_todo_path()) end, "Open todo (local)")

  vim.api.nvim_set_hl(0, "CheckmateStartedMarker", { fg = "#88c0d0" })
  vim.api.nvim_set_hl(0, "CheckmateStartedMainContent", { fg = "#88c0d0" })
  vim.api.nvim_set_hl(0, "CheckmateCheckedMarker", { fg = "#b1c89d" })
  vim.api.nvim_set_hl(0, "CheckmateCheckedMainContent", { fg = "#4c566a", strikethrough = true })
  vim.api.nvim_set_hl(0, "CheckmateCancelledMarker", { fg = "#c5727a" })
  vim.api.nvim_set_hl(0, "CheckmateCancelledMainContent", { fg = "#c5727a", strikethrough = true })
  vim.api.nvim_set_hl(0, "CheckmateHoldMarker", { fg = "#ebcb8b" })
  vim.api.nvim_set_hl(0, "CheckmateHoldMainContent", { fg = "#ebcb8b" })
end)
