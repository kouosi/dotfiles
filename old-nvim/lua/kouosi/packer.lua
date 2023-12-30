-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use ('wbthomason/packer.nvim')

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }

    -- Treesitter Playground
    use("nvim-treesitter/playground")

    -- Treesitter context
    use("nvim-treesitter/nvim-treesitter-context")

    -- Trouble.nvim
    use {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icon = false
            }
        end
    }

    -- Undo Tree
    use("mbbill/undotree")

    -- Vim fugitive (git)
    use("tpope/vim-fugitive")

    -- Markdown support
    use("ixru/nvim-markdown")

    -- Neo Forma
    use('sbdchd/neoformat')

    -- File explorer
    use {
        'nvim-tree/nvim-web-devicons',
        'nvim-tree/nvim-tree.lua',
        config = [[require('config.nvim-tree')]],
    }

    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- vim gas
    -- use("Shirk/vim-gas")

    -- asm tree sitter
    -- use ('rush-rs/tree-sitter-asm')

    -- Onedark theme
    use {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'warmer'
            }
            require('onedark').load()
        end
    }

    -- Lsp Zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},

            -- Autocompletion
		    {'hrsh7th/cmp-buffer'},
		    {'hrsh7th/cmp-nvim-lua'},
		    {'hrsh7th/cmp-path'},
		    {'saadparwaiz1/cmp_luasnip'},
            {'L3MON4D3/LuaSnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/nvim-cmp'},

            -- Snippets
		    {'L3MON4D3/LuaSnip'},
		    {'rafamadriz/friendly-snippets'},
        }
    }
end)

