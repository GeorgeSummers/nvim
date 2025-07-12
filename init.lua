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

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

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
    vim.o.spelllang    = 'de,en'
    vim.o.spelloptions = 'camel'
    vim.opt.complete:append('kspell')


    vim.cmd('filetype plugin indent on')
    -- vim.cmd('colorscheme modus-tinted')
end)

vim.o.guifont = "FiraCode Nerd Font:h12"

later(function() require('mini.ai').setup() end)
later(function() require('mini.align').setup() end)
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
later(function()
    require('mini.basics').setup({
        options = {
            basic = true,
            extra_ui = true,
            win_borders = 'bold',
        },
        mappings = {
            basic = true,
            windows = true,
        },
        autocommands = {
            basic = true,
            relnum_in_visual_mode = true,
        }
    })
end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.bufremove').setup() end)
later(function()
    require('mini.clue').setup({
        triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },

            { mode = 'n', keys = '\\' },

            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

            -- `g` key
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            -- Marks
            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },

            -- Registers
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            -- Window commands
            { mode = 'n', keys = '<C-w>' },

            -- `z` key
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
        },

        clues = {
            { mode = 'n', keys = '<Leader>b', desc = ' Buffer' },
            { mode = 'n', keys = '<Leader>f', desc = ' Find' },
            { mode = 'n', keys = '<Leader>g', desc = '󰊢 Git' },
            { mode = 'n', keys = '<Leader>i', desc = '󰏪 Insert' },
            { mode = 'n', keys = '<Leader>l', desc = '󰘦 LSP' },
            { mode = 'n', keys = '<Leader>q', desc = ' NVim' },
            { mode = 'n', keys = '<Leader>s', desc = '󰆓 Session' },
            { mode = 'n', keys = '<Leader>u', desc = '󰔃 UI' },
            { mode = 'n', keys = '<Leader>w', desc = ' Window' },
            require('mini.clue').gen_clues.g(),
            require('mini.clue').gen_clues.builtin_completion(),
            require('mini.clue').gen_clues.marks(),
            require('mini.clue').gen_clues.registers(),
            require('mini.clue').gen_clues.windows(),
            require('mini.clue').gen_clues.z(),
        },
        window = {
            delay = 300
        }
    })
end)
-- later(function() require('mini.colors').setup() end)
later(function() require('mini.comment').setup() end)
later(function()
    require('mini.completion').setup({
        mappings = {
            go_in = '<RET>',
        },
        window = {
            info = { border = 'rounded' },
            signature = { border = 'rounded' },
        }
    })
end)
later(function() require('mini.cursorword').setup() end)
later(function()
    require('mini.diff').setup({
        view = {
            style = 'sign',
            signs = { add = '█', change = '▒', delete = '' }
        }
    })
end)
later(function() require('mini.doc').setup() end)
later(function() require('mini.extra').setup() end)
later(function()
    require('mini.files').setup({
        windows = {
            preview = true,
            width_preview = 80,
        }
    })
end)
later(function() require('mini.fuzzy').setup() end)
later(function() require('mini.git').setup() end)
now(function()
    local hipatterns = require('mini.hipatterns')

    hipatterns.setup({
        highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
            hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
            todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
            note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },


            -- Highlight hex color strings (`#rrggbb`) using that color
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })

end)
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
later(function()
        require('mini.icons').setup({})
end)
later(function()
    require('mini.indentscope').setup({
        draw = {
            animation = function() return 1 end,
        },
        symbol = "│"
    })
end)
later(function() require('mini.jump').setup() end)
later(function() require('mini.jump2d').setup() end)
later(function() require('mini.map').setup() end)
later(function() require('mini.misc').setup() end)
later(function() require('mini.move').setup({}) end)
later(function()
    -- We took this from echasnovski's personal configuration
    -- https://github.com/echasnovski/nvim/blob/master/init.lua
    local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif) return not vim.startswith(notif.msg, 'lua_ls: Diagnosing') end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return MiniNotify.default_sort(notif_arr)
    end
    require('mini.notify').setup({
        content = { sort = filterout_lua_diagnosing },
        window = { config = { border = 'double' } },
    })
    -- vim.notify = MiniNotify.make_notify()
end)
later(function() require('mini.operators').setup() end)
later(function() require('mini.pairs').setup() end)
later(function()
    local win_config = function()
        height = math.floor(0.618 * vim.o.lines)
        width = math.floor(0.618 * vim.o.columns)
        return {
            anchor = 'NW',
            height = height,
            width = width,
            border = 'rounded',
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
        }
    end
    require('mini.pick').setup({
        mappings = {
            choose_in_vsplit = '<C-CR>',
        },
        options = {
            use_cache = true
        },
        window = {
            config = win_config
        }
    })
    vim.ui.select = MiniPick.ui_select
end)
now(function()
    require('mini.sessions').setup({
        autowrite = true
    })
end)
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
later(function() require('mini.surround').setup() end)
later(function() require('mini.tabline').setup() end)
later(function() require('mini.trailspace').setup() end)
later(function() require('mini.visits').setup() end)

later(function()
    add({
        source = 'neovim/nvim-lspconfig',
        depends = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim'
        }
    })
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end


          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

    vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
    callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event.buf }
    end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },

        },
        elixirls = {}
      }

    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
    'stylua', -- Used to format Lua code
    'lua_ls',
    'elixirls'
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    require('lspconfig').elixirls.setup {}
end)

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
