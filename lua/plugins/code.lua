return {
	{
		"VonHeikemen/lsp-zero.nvim", branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({buffer = bufnr})
			end)
		end
	},
	{
		dependencies = "VonHeikemen/lsp-zero.nvim",
		"williamboman/mason.nvim",
		opts = {};
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "VonHeikemen/lsp-zero.nvim",
		opts = {
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			},
		}
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"VonHeikemen/lsp-zero.nvim",
			"nvim-telescope/telescope.nvim"
		},
		config = function()
		end,
		keys = {
			{ "gd", function() require"telescope.builtin".lsp_definitions() end },
			{ "gr", function() require"telescope.builtin".lsp_references() end },
    	{ "<leader>ca", function() vim.lsp.buf.code_action() end },
		}
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "ruby", "html", "go" },
				sync_install = false,
				highlight = { enable = true },
				indent = {
					enable = true,
					disable = { "go" }
				},
			})
		end
	},
	{ "terrortylor/nvim-comment" },
	{
		"ray-x/go.nvim",
		dependencies = {  -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = {"CmdlineEnter"},
		ft = {"go", 'gomod'},
		build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
	}
}

