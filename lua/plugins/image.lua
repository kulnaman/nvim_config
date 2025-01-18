local plugin = {
  "3rd/image.nvim",
  opts = {},
  setup = {
    rocks = {
      hererocks = true,   -- recommended if you do not have global installation of Lua 5.1.
    }
  }
}
return plugin
