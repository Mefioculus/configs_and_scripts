-- Данная часть необходима для того, что без нее появление нужного пути проиходит слишком поздно и lualine завершается с ошибкой,
-- потому что не может получить файл темы.
-- Вообще данный код должен отрабатывать в файле adapter.lua, строка 26, но, видимо, код там запускается после инициализации
-- плагинов, что приводит к некорректному поведению
local rocksconfig = require("rocks.config.internal")
local rtp_dir = vim.fs.joinpath(rocksconfig.rocks_path, "rocks_rtp")
vim.opt.runtimepath:append(rtp_dir)

require('lualine').setup {
    --[[
  options = {
    theme = 'gruvbox-material',
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
  --]]
}
