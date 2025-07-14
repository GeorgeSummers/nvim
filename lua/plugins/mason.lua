later(function()
    add({
        source = 'WhoIsSethDaniel/mason-tool-installer.nvim',
        depends = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        post_checkout = function()
            vim.cmd("MasonToolsInstall")
        end
    })
    require("mason").setup({
        ui = {
            border = "single",
        },
        registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
        },
    })

    require("mason-tool-installer").setup({
        ensure_installed = {
            -- language servers
            "python-lsp-server",
            "bashls",
            "gopls",
            "lua_ls",

            -- debug adapters
            "codelldb",

            -- formatters
            -- astyle missing
            "goimports",
            "prettier",
            "shfmt",
            "stylua",

            -- linters
            -- "eslint_d",
            -- "luacheck",
            -- "proselint",
            "shellcheck",
        },
    })
end)

