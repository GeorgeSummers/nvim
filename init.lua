-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    vim.g.mapleader      = ' '
    vim.o.backup         = false
    vim.o.number         = true
    vim.o.relativenumber = true
    vim.o.laststatus     = 2
    vim.o.list           = true
    vim.o.background     = 'dark'
    vim.o.listchars      = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',')
    vim.o.autoindent     = true
    vim.o.shiftwidth     = 4
    vim.o.tabstop        = 4
    vim.o.expandtab      = true
    vim.o.scrolloff      = 10
    vim.o.clipboard      = "unnamed,unnamedplus"
    -- vim.opt.statuscolumn = '%=%{v:lnum}│%{v:relnum}'
    vim.opt.iskeyword:append('-')
    vim.o.spelllang    = 'en,ru'
    vim.o.spelloptions = 'camel'
    vim.opt.complete:append('kspell')

    vim.o.guifont = "FiraCode Nerd Font:h12"

    vim.cmd('filetype plugin indent on')
    -- vim.cmd('colorscheme modus-tinted')
end)

require('plugins.mini-init')
require('plugins.mini-ai')
later(function()
    -- This is needed for mini.animate to work with mouse scrolling
    vim.opt.mousescroll = 'ver:1,hor:1'
    local animate = require('mini.animate')
    animate.setup {
        scroll = {
            -- Disable Scroll Animations, as the can interfer with mouse Scrolling
            enable = true,
        },
        cursor = {
            timing = animate.gen_timing.cubic({ duration = 50, unit = 'total' })
        },
    }
end)
-- Disabled Here. This is called directly from our Colorscheme in the colors/ folder
-- You can enable this by uncommenting.
-- We provide a basic Catppuccin Colorscheme here
-- later(function()
--     require('mini.base16').setup({
--         palette = {
--             base00 = '#1e1e2e',
--             base01 = '#181825',
--             base02 = '#313244',
--             base03 = '#45475a',
--             base04 = '#585b70',
--             base05 = '#cdd6f4',
--             base06 = '#f5e0dc',
--             base07 = '#b4befe',
--             base08 = '#f38ba8',
--             base09 = '#fab387',
--             base0A = '#f9e2af',
--             base0B = '#a6e3a1',
--             base0C = '#94e2d5',
--             base0D = '#89b4fa',
--             base0E = '#cba6f7',
--             base0F = '#f2cdcd'
--         }
--     })
-- end)
require('plugins.mini-basics')
require('plugins.mini-buffermove')
require('plugins.mini-clue')
-- later(function() require('mini.colors').setup() end)
require('plugins.mini-completion')
later(function()
    require('mini.diff').setup({
        view = {
            style = 'sign',
            signs = { add = '█', change = '▒', delete = '' }
        }
    })
end)
require('plugins.mini-files')
require('plugins.mini-hipatterns')
-- We disable this, as we use our own Colorscheme through mini.colors
-- You can enable this by uncommenting
-- We Provide a Modus Vivendi inspired setup here
later(function()
    require('mini.hues').setup({
        background = '#212030',
        foreground = '#c6c6cd',
        accent     = 'cyan',
        saturation = 'medium'
    })
end)
require('plugins.mini-indentscope')
require('plugins.mini-notify')
require('plugins.mini-pick')
require('plugins.mini-sessions')
later(function() require('mini.splitjoin').setup() end)
now(function()
    require('mini.starter').setup({
        autoopen = true,
        items = {
            require('mini.starter').sections.builtin_actions(),
            require('mini.starter').sections.recent_files(5, false),
            require('mini.starter').sections.recent_files(5, true),
            require('mini.starter').sections.sessions(5, true),
        },
        header = [[
                ███╗   ███╗██╗   ██╗██╗███╗   ███╗
                ████╗ ████║██║   ██║██║████╗ ████║
                ██╔████╔██║██║   ██║██║██╔████╔██║
                ██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║
                ██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
                ██║     ██║  ╚═══╝  ╚═╝██║     ██║
                ██║     ██║ini      nvi██║     ██║
                ╚═╝     ╚═╝            ╚═╝     ╚═╝]],
    })
end)
later(function()
    require('mini.statusline').setup({
        use_icons = true,
    })
end)
require("plugins.mason")
require("lsp")
later(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter'
    })
    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'yaml' },
        auto_install = true,
        highlight = { enable = true, disable = { 'ini' } },
        indent = { enable = true }
    })
    require('nvim-treesitter.install').compilers = { 'clang', 'gcc' }
end)

later(function()
    add({
        source = 'ibhagwan/fzf-lua'
    })
    require('fzf-lua').setup({})
end)

require("autocmds")
require("filetypes")
require("highlights")
require("keybinds")
