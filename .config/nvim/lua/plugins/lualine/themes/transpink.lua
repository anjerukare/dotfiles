local colors = {
  tranparent = 'NONE',
  pink       = '#d75f87',
  gray       = '#767676'
}
local sections = {
  a = {bg = colors.tranparent, fg = colors.pink},
  b = {bg = colors.tranparent, fg = colors.gray},
  c = {bg = colors.tranparent, fg = colors.gray},
  x = {bg = colors.tranparent, fg = colors.gray},
  y = {bg = colors.tranparent, fg = colors.gray},
  z = {bg = colors.tranparent, fg = colors.gray}
}
return {
  normal = sections, insert = sections, visual = sections,
  replace = sections, command = sections, inactive = sections
}
