local utils = {}

utils.set_color = function(text, color)
    return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

return utils
