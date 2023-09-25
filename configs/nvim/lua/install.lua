vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost install.lua source <afile> | PackerCompile
  augroup end
]])

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Colorshemes
	-- use 'https://github.com/sainnhe/sonokai'
	use("rebelot/kanagawa.nvim")

	-- Icons because yes
	use("kyazdani42/nvim-web-devicons")

	-- Vim Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")

	-- Vim Ranger
	use("https://github.com/kevinhwang91/rnvimr")

	-- Git Stuffs
	use("https://github.com/lewis6991/gitsigns.nvim")
	-- 🙏
	use("tpope/vim-fugitive")

	-- The one and only tpoe
	use("https://github.com/tpope/vim-dispatch")

	-- Windows Helpers
	use("nvim-lualine/lualine.nvim")
	use("edkolev/tmuxline.vim")
	use("https://github.com/simeji/winresizer")

	-- Misc
	use("psliwka/vim-smoothie")
	use("https://github.com/tpope/vim-surround")
	use("https://github.com/numToStr/Comment.nvim")
	use("tpope/vim-repeat")
	use("ggandor/lightspeed.nvim")
	use("https://github.com/vim-test/vim-test")
	use("https://github.com/raimondi/delimitmate")
	use("tommcdo/vim-exchange")
	use("nvim-treesitter/playground")
	use("meain/vim-printer")
	use("gbprod/yanky.nvim")
    use("chentoast/marks.nvim")

	-- IDE Like
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("neovim/nvim-lspconfig")
	use("RishabhRD/popfix")
	use("RishabhRD/nvim-lsputils")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("mhartington/formatter.nvim")
	use("folke/trouble.nvim")
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use("RRethy/vim-illuminate")
  use("https://github.com/pearofducks/ansible-vim")
  use("https://github.com/akinsho/toggleterm.nvim")
  -- use("/home/rodrigo/programations/misc/LspUI-fork")
  -- use("https://github.com/jinzhongjia/LspUI.nvim")
  use("https://github.com/nvimdev/lspsaga.nvim")
  use("https://github.com/folke/neodev.nvim")

	-- use 'kyazdani42/nvim-tree.lua'
	-- use("elixir-editors/vim-elixir")
	use("https://github.com/DingDean/wgsl.vim")
	use("jansedivy/jai.vim")
  use("https://github.com/elkowar/yuck.vim")

	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/vim-vsnip-integ")
	use("https://github.com/rafamadriz/friendly-snippets")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-emoji")

  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "jfpedroza/neotest-elixir",
      "rouge8/neotest-rust",
    }
  })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
