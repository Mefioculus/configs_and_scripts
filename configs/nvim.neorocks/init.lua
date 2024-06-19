require("base") -- базовые настройки
require("keys") -- настройки комбинаций клавиш
require("rocks") -- настройки менеджера планинов neorocs
require("theme") -- настройки темы редактора

-- Плагины
require("plugins/treesitter") -- настройки плагина treesitter для более корректной подсветки синтаксиса
require("plugins/telescope") -- настройки плагина fzf поиска telescope
require("plugins/cmp") -- настройки плагина автозаполнения cmp
require("plugins/neorg") -- настройки плагина ведения заметок и работы с org файлами для neovim
require("plugins/lualine") -- настройка плагина удобной нижней панели lualine

--print(vim.inspect(vim.api.nvim_list_runtime_paths()))
