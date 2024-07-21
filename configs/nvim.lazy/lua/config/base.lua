local opt = vim.opt

-- ТАБУЛЯЦИЯ
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.expandtab = true

-- ОТСТУПЫ
opt.autoindent = true
opt.smartindent = true

-- ПОИСК
opt.incsearch = true;
opt.hlsearch = true;

-- 
opt.encoding = "utf-8"

opt.number = true           -- включение нумерации строк
opt.relativenumber = true	-- относительная нумерация строк
opt.cursorline = true		-- подсветка строки, в которой находится курсор
opt.completeopt = 'menu,menuone,noselect,' -- включение встроенного функционала автозаполнения
