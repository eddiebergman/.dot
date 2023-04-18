local M = {}

local bookmarks = {
  ["github"] = {
      ["name"] = "search github from neovim",
      ["code_search"] = "https://github.com/search?q=%s&type=code",
      ["repo_search"] = "https://github.com/search?q=%s&type=repositories",
      ["issues_search"] = "https://github.com/search?q=%s&type=issues",
      ["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
  },
}

function M.setup()
    require("browse").setup({
        provider = "google",
        bookmarks = bookmarks
    })
end

return M
