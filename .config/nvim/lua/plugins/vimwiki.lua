return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "~/source/jxmen/wiki/_wiki",
        syntax = "default",
        ext = ".md",
      },
    }
  end,
}
