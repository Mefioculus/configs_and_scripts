require("base") -- базовые настройки
require("keys") -- настройки комбинаций клавиш
require("rocks") -- настройки менеджера планинов neorocs
require("theme") -- настройки темы редактора

-- Плагины
require("plugins/treesitter-config") -- настройки плагина treesitter для более корректной подсветки синтаксиса
require("plugins/telescope-config") -- настройки плагина fzf поиска telescope
require("plugins/cmp-config") -- настройки плагина автозаполнения cmp
require("plugins/neorg-config") -- настройки плагина ведения заметок и работы с org файлами для neovim
require("plugins/lualine-config") -- настройка плагина удобной нижней панели lualine
require("plugins/oil-config") -- настройка плагина работы с файловой системой в парадигме редактирования текста в  vim
require("plugins/surround-config") -- плагин для работы с парными оборачивающими символами, такими, как кавычки, разного рода скобки
--require("plugins/which-key-config") -- отображение возможных комбинаций клавиш
--require("plugins/flash-config") -- плагин для быстрого перемещения по файлу

--print(vim.inspect(vim.api.nvim_list_runtime_paths()))
