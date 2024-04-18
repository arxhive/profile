-- Smooth scrolling for window movement commands (mappings optional): <C-u>, <C-d>, <C-b>, <C-f>, <C-y>, <C-e>, zt, zz, zb.
return {
  "karb94/neoscroll.nvim",
  config = function ()
    require('neoscroll').setup {}
  end
}
