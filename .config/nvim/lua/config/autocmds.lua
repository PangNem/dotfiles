-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- LastModified 함수
local function LastModified()
  if vim.g.md_modify_disabled then
    return
  end

  if vim.bo.modified then
    local save_cursor = vim.fn.getpos(".")
    local n = math.min(10, vim.fn.line("$"))

    vim.cmd(
      [[keepjumps 1,]] .. n .. [[s#^\(.\\{,10}updated\s*:\s\).*#\1]] .. os.date("%Y-%m-%d %H:%M:%S +0900") .. "#e"
    )
    vim.fn.histdel("search", -1)
    vim.fn.setpos(".", save_cursor)
  end
end

-- NewTemplate 함수
local function NewTemplate()
  local wiki_directory = false

  for _, wiki in ipairs(vim.g.vimwiki_list) do
    if vim.fn.expand("%:p:h"):match(vim.fn.expand(wiki.path)) then
      wiki_directory = true
      break
    end
  end

  if not wiki_directory then
    return
  end

  if vim.fn.line("$") > 1 then
    return
  end

  local template = {
    "---",
    "layout : wiki",
    "title : ",
    "summary : ",
    "date : " .. os.date("%Y-%m-%d %H:%M:%S +0900"),
    "updated : " .. os.date("%Y-%m-%d %H:%M:%S +0900"),
    "tag : ",
    "toc : true",
    "public : true",
    "parent : ",
    "latex : false",
    "resource: " .. vim.fn.substitute(vim.fn.system("uuidgen"), "\n", "", ""),
    "---",
    "* TOC",
    "{:toc}",
    "",
    "# ",
  }

  vim.fn.setline(1, template) -- template가 table이므로 unpack으로 감싸준다.
  vim.cmd("normal! G")
  vim.cmd("normal! $")
  print("new wiki page has created")
end

-- 자동 명령 그룹
vim.api.nvim_create_augroup("vimwikiauto", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "_wiki/*.md",
  callback = LastModified,
  group = "vimwikiauto",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "_wiki/*.md",
  callback = NewTemplate,
  group = "vimwikiauto",
})
