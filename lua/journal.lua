local utils = require("orgmode.utils")
local config = require("orgmode.config")
local Files = require("orgmode.parser.files")
local File = require("orgmode.parser.file")
local Templates = require("orgmode.capture.templates")
local ClosingNote = require("orgmode.capture.closing_note")
local Date = require("orgmode.objects.date")
local Menu = require("orgmode.ui.menu")
local Calendar = require("orgmode.objects.calendar")

---@class Journal
---@field templates Templates
---@field closing_note ClosingNote
local Journal = {}

function Journal:new()
  local data = {}
  data.templates = Templates:new()
  data.closing_note = ClosingNote:new()
  setmetatable(data, self)
  self.__index = self
  return data
end

---@param date? Date
function Journal.open(date)
  local cfg = config.journal
  if not date then
    date = Date:now()
  end

  local file_path = cfg.directory .. date:format(cfg.file_format)
  local file = vim.fn.resolve(vim.fn.fnamemodify(file_path, ":p"))

  if vim.fn.expand("%:p") ~= vim.fn.expand(file) then
    utils.open_window(file, 16, config.win_split_mode, config.win_border)
  end
end

function Journal.open_yesterday()
  return Journal.open(Date:today():adjust("-1d"))
end

function Journal.new_entry()
  local cfg = config.journal
  local date = Date:now()
  local file_path = cfg.directory .. date:format(cfg.file_format)
  local file = vim.fn.resolve(vim.fn.fnamemodify(file_path, ":p"))

  if vim.fn.expand("%:p") ~= vim.fn.expand(file) then
    utils.open_window(file, 16, config.win_split_mode, config.win_border)
  end

  local is_empty = vim.fn.filereadable(file) == 0 or #vim.fn.readfile(file) == 0
  if is_empty then
    local content = cfg.date.prefix .. date:format(cfg.date.format)
    vim.api.nvim_buf_set_lines(0, 0, -1, true, vim.split(content, "\n", true))
  else
    vim.api.nvim_buf_set_lines(0, vim.fn.line("$"), -1, true, { "" })
  end

  local row = vim.fn.line("$")
  if is_empty then
    row = row - 1
  end

  local content = cfg.time.prefix .. date:format(cfg.time.format)
  content = vim.split(content, "\n", true)

  vim.api.nvim_buf_set_lines(0, row, -1, true, content)
  vim.api.nvim_win_set_cursor(0, { row + #content, 0 })
  vim.cmd("startinsert!")
end

function Journal.menu()
  local items = {
    {
      label = "Today journal",
      key = "c",
      action = function()
        Journal.open()
      end,
    },
    {
      label = "Yesterday journal",
      key = "p",
      action = function()
        Journal.open_yesterday()
      end,
    },
    {
      label = "New entry",
      key = "C",
      action = function()
        Journal.new_entry()
      end,
    },
    {
      label = "Open calendar",
      key = "o",
      action = function()
        Calendar:new({}):open():next(function(selected_date)
          if selected_date then
            Journal.open(selected_date)
          end
        end)
      end,
    },
  }

  Menu:new({ title = "Journal", items = items, prompt = "Enter choice: " }):open()
end

return Journal
