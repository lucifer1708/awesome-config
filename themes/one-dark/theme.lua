--  ██████╗ ███╗   ██╗███████╗    ██████╗  █████╗ ██████╗ ██╗  ██╗
-- ██╔═══██╗████╗  ██║██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝
-- ██║   ██║██╔██╗ ██║█████╗█████╗██║  ██║███████║██████╔╝█████╔╝
-- ██║   ██║██║╚██╗██║██╔══╝╚════╝██║  ██║██╔══██║██╔══██╗██╔═██╗
-- ╚██████╔╝██║ ╚████║███████╗    ██████╔╝██║  ██║██║  ██║██║  ██╗
--  ╚═════╝ ╚═╝  ╚═══╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local wallpaper_dir = "/mnt/extras/Wallpapers"

local theme     = {}
theme.dir       = os.getenv("HOME") .. "/.config/awesome/themes/one-dark"
theme.wallpaper = wallpaper_dir .. "/eos_astronaut.png"

theme.font                   = "Fira Code Retina 9"
-- theme.taglist_font                              = "NotoSansMono Nerd Font 9"
theme.notification_font      = "Fira Code Retina 19"
theme.notification_max_width = 400
theme.taglist_font           = "Fira Code Retina 9"

theme.white       = "#ffffff"
theme.dark        = "#282c34"
theme.darker      = "#1E222A"
theme.transparent = "#E6000000"

theme.black         = theme.dark
theme.grey          = "#5c6370"
theme.red           = "#efa6a2"
theme.red_bright    = "#D04232"
theme.orange        = "#d19a66"
theme.green         = "#98c379"
theme.green_bright  = "#B8BB26"
theme.yellow        = "#c8c874"
theme.yellow_bright = "#FFC12F"
theme.blue          = "#61afef"
theme.blue_bright   = "#83A598"
theme.purple        = "#c678dd"
theme.purple_bright = "#D3869B"

theme.accent = theme.green

theme.fg_normal     = "#D7D7D7"
theme.fg_focus      = theme.accent
theme.bg_normal     = theme.dark
theme.bg_focus      = theme.dark
theme.fg_urgent     = "#CC9393"
theme.bg_urgent     = "#2A1F1E"
theme.border_width  = dpi(2)
theme.border_normal = theme.darker
theme.border_focus  = theme.blue

theme.bg1 = "#3d4059"
theme.bg2 = "#313449"
theme.bg3 = "#2c2e3e"
-- theme.bg4                                       = "#20202a"
theme.bg4 = theme.dark

theme.taglist_fg_focus    = theme.blue
theme.taglist_bg_focus    = theme.bg3
theme.taglist_fg_occupied = theme.purple
theme.taglist_fg_empty    = theme.grey
theme.taglist_fg_urgent   = theme.red

theme.tasklist_fg_focus        = "#F6784F"
theme.tasklist_bg_focus        = "#060606"
theme.bg_systray               = theme.dark
theme.menu_height              = dpi(14)
theme.menu_width               = dpi(130)
theme.menu_submenu_icon        = theme.dir .. "/icons/submenu.png"
theme.awesome_icon             = theme.dir .. "/icons/awesome.png"
-- theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
-- theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile              = theme.dir .. "/icons/tile.png"
theme.layout_tileleft          = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom        = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop           = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv             = theme.dir .. "/icons/fairv.png"
theme.layout_fairh             = theme.dir .. "/icons/fairh.png"
theme.layout_spiral            = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle           = theme.dir .. "/icons/dwindle.png"
theme.layout_max               = theme.dir .. "/icons/max.png"
theme.layout_fullscreen        = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier         = theme.dir .. "/icons/magnifier.png"
theme.layout_floating          = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon    = true
theme.useless_gap              = dpi(2)

theme.widget_net   = theme.dir .. "/icons/net.png"
theme.battery_full = theme.dir .. "/icons/battery_blue.png"

-- awful.util.tagnames   = { "𝟏", "𝟐", "𝟑", "𝟒", "𝟓", "𝟔"}
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7" }
-- awful.util.tagnames   = { "ℂ", "ℝ", "ℚ", "ℤ", "ℕ"}

local markup     = lain.util.markup
local separators = lain.util.separators
local gray       = "#9E9C9A"

-- local mytextwidget = wibox.widget{
--     markup = 'This is a textbox',
--     align  = 'center',
--     valign = 'center',
--     widget = wibox.widget.textbox
-- }

-- Textclock
local mytextclock = wibox.widget.textclock(" %I:%M ")
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
  attach_to = { mytextclock },
  notification_preset = {
    font = theme.font,
    fg   = theme.fg_normal,
    bg   = theme.bg_normal
  }
})

-- local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
  "date +' %d %b %a %I:%M '", 10,
  function(widget, stdout)
    widget:set_markup(" " .. markup.font(theme.font, markup(theme.yellow, stdout)))
  end
)


-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
  end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
  end
})



-- Wifi
-- local wifi = wibox.widget { nil, neticon, net.widget, layout = wibox.layout.align.horizontal }
-- Battery
local bat_icon = wibox.widget.imagebox(theme.battery_full)
local bat = lain.widget.bat({
  settings = function()
    if bat_now.ac_status == 1 then
      bat_header = " ↑ "
      -- bat_header = " "
    else
      bat_header = " "
    end
    bat_p = bat_now.perc .. ""
    widget:set_markup(markup.font(theme.font, markup(theme.blue, bat_p .. bat_header)))
  end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
  --togglechannel = "IEC958,3",
  settings = function()
    header = "  "
    vlevel = volume_now.level

    if volume_now.status == "off" then
      vlevel = vlevel .. "M "
    else
      vlevel = vlevel .. " "
    end

    widget:set_markup(markup.font(theme.font, markup(theme.green, header .. vlevel)))
  end
})

-- Separators
local first = wibox.widget.textbox('<span font="Fira Code Retina 4"> </span>')

function right_tri(cr, width, height, degree)
  cr:move_to(18, 0)
  cr:line_to(0, 18)
  cr:line_to(18, 18)
  cr:close_path()
end

function left_tri(cr, width, height, degree)
  cr:move_to(0, 0)
  cr:line_to(0, 18)
  cr:line_to(18, 18)
  cr:close_path()
end

local function mysep(color, shape)
  return wibox.widget {
    shape        = shape,
    color        = color,
    border_width = 0,
    forced_width = 18,
    widget       = wibox.widget.separator,
  }
end

local barheight = dpi(18)
local barcolor  = gears.color({
  type  = "linear",
  from  = { barheight, 0 },
  to    = { barheight, barheight },
  stops = { { 0, theme.dark }, { 1, theme.dark }, { 1, theme.dark } }
})

theme.titlebar_bg = barcolor

theme.titlebar_bg_focus = gears.color({
  type  = "linear",
  from  = { barheight, 0 },
  to    = { barheight, barheight },
  stops = { { 0, theme.bg_normal }, { 0.5, theme.border_normal }, { 1, "#492417" } }
})

local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({ app = awful.util.terminal })

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "bottom", screen = s, height = dpi(18), bg = barcolor })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.background(s.mytaglist, theme.bg3),
      wibox.container.background(first, theme.bg3),
      wibox.container.background(mysep(theme.bg3, left_tri), theme.bg4),
    },
    nil,
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.background(wibox.widget.systray(), theme.bg4),
      wibox.container.background(mysep(theme.bg3, right_tri), theme.bg4),
      wibox.container.background(wibox.container.margin(theme.volume.widget, dpi(2), dpi(4)), theme.bg3),
      wibox.container.background(mysep(theme.bg2, right_tri), theme.bg3),
      wibox.container.background(wibox.container.margin(wibox.widget { bat_icon, bat, layout = wibox.layout.align.horizontal }, dpi(2), dpi(4)), theme.bg2),
      wibox.container.background(mysep(theme.bg1, right_tri), theme.bg2),
      wibox.container.background(clock, theme.bg1),
    },
  }
end

return theme
