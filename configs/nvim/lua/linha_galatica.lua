local gl = require('galaxyline')
local condition = require('galaxyline.condition')

local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree'}

local utils = {}
function utils.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function utils.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

local colors = {
    bg = vim.g.palette.bg0[1],
    fg = vim.g.palette.fg[1],
    section_bg = vim.g.palette.bg2[1],
    blue = vim.g.palette.blue[1],
    green = vim.g.palette.green[1],
    purple = vim.g.palette.purple[1],
    orange = vim.g.palette.orange[1],
    red1 = vim.g.palette.red[1],
    red2 = vim.g.palette.diff_red[1],
    yellow = vim.g.palette.yellow[1],
    gray1 = vim.g.palette.grey[1],
    gray2 = vim.g.palette.grey[1],
    gray3 = vim.g.palette.grey[1],
    darkgrey = vim.g.palette.bg3[1],
    grey = vim.g.palette.bg4[1],
    middlegrey = vim.g.palette.fg[1]
}

-- Local helper functions
local buffer_not_empty = function() return not utils.is_buffer_empty() end

local checkwidth = function()
    return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value[1] == val then return true end
    end
    return false
end

local mode_color = function()
    local mode_colors = {
        [110] = colors.green,
        [105] = colors.blue,
        [99] = colors.green,
        [116] = colors.blue,
        [118] = colors.purple,
        [22] = colors.purple,
        [86] = colors.purple,
        [82] = colors.red1,
        [115] = colors.red1,
        [83] = colors.red1
    }

    mode_color = mode_colors[vim.fn.mode():byte()]
    if mode_color ~= nil then
        return mode_color
    else
        return colors.purple
    end
end

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly == true then return '  ' end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. ' [   salva babaca ]' end
    end
    return file .. ' '
end

-- local function trailing_whitespace()
--     local trail = vim.fn.search('\\s$', 'nw')
--     if trail ~= 0 then
--         return '  '
--     else
--         return nil
--     end
-- end

-- local function tab_indent()
--     local tab = vim.fn.search('^\\t', 'nw')
--     if tab ~= 0 then
--         return ' → '
--     else
--         return nil
--     end
-- end

local function buffers_count()
    local buffers = {}
    for _, val in ipairs(vim.fn.range(1, vim.fn.bufnr('$'))) do
        if vim.fn.bufexists(val) == 1 and vim.fn.buflisted(val) == 1 then
            table.insert(buffers, val)
        end
    end
    return #buffers
end

-- Left side
gls.left[1] = {
    ViMode = {
        provider = function()
            local aliases = {
                [110] = 'NORMAL',
                [105] = 'INSERT',
                [99] = 'COMMAND',
                [116] = 'TERMINAL',
                [118] = 'VISUAL',
                [22] = 'V-BLOCK',
                [86] = 'V-LINE',
                [82] = 'REPLACE',
                [115] = 'SELECT',
                [83] = 'S-LINE'
            }

            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
            alias = aliases[vim.fn.mode():byte()]
            if alias ~= nil then
                if utils.has_width_gt(35) then
                    mode = alias
                else
                    mode = alias:sub(1, 1)
                end
            else
                mode = vim.fn.mode():byte()
            end
            return '  ' .. mode .. ' '
        end,
        highlight = {colors.bg, colors.bg, 'bold'}
    }
}

gls.left[2] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.left[3] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}
-- Right side
gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        separator = ' ',
        condition = checkwidth,
        icon = '  +',
        highlight = {colors.green, colors.section_bg},
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = {colors.orange, colors.section_bg}
    }
}

gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = {colors.red1, colors.section_bg}
    }
}

gls.right[4] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.section_bg, colors.section_bg}
    }
}

gls.right[5] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = buffer_not_empty and
            require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.middlegrey, colors.section_bg}
    }
}

gls.right[6] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = buffer_not_empty,
        highlight = {colors.middlegrey, colors.section_bg}
    }
}

gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.blue, colors.section_bg},
        highlight = {colors.grey, colors.blue}
    }
}



-- gls.right[8] = {
--     ScrollBar = {
--         provider = 'ScrollBar',
--         highlight = {colors.purple, colors.section_bg}
--     }
-- }

-- Short status line
gls.short_line_left[1] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = function()
            return buffer_not_empty and
                       has_value(gl.short_line_list, vim.bo.filetype)
        end,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.short_line_left[2] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {colors.yellow, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
