local M = {}

local hsluv = require('lush').hsluv

M.white = hsluv(162, 15, 88)
M.green = hsluv(141, 98, 52)
M.greeny = hsluv(149, 99, 63)
M.reddish = hsluv(18, 77, 56)
M.dark_reddish = M.reddish.darken(30)

M.grey = M.white.darken(69)
M.light_grey = M.grey.lighten(30)
M.dark_grey = M.grey.darken(30)

return M
