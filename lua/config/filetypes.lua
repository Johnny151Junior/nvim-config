vim.filetype.add({
  filename = {
    ["go.work"] = "gowork",
  },
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*%.go%.tmpl"] = "gotmpl",
  },
})
