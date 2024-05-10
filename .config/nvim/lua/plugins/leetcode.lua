return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- configuration goes here
    arg = "leetcode.nvim", -- nvim 뒤에 어떤 명령어를 입력해야 leetcode 창을 띄울지 설정
    lang = "java", -- 문제를 열 시 기본 언어
  },
}
