require("awful")
terminal = 'xterm' -- can be app in path, or full path e.g. /usr/bin/xterm
editor = "vim"

--wallpaper_dir = os.getenv("HOME") .. "/yourwallpaper_dir/" -- grabs a random bg
--awful.key({ modkey }, "#48", function () awful.client.focus.bydirection("down")
  --if client.focus then client.focus:raise() end
--end),
--awful.key({ modkey }, "#34", function () awful.client.focus.bydirection("up")
  --if client.focus then client.focus:raise() end
--end),
--awful.key({ modkey }, "#47", function () awful.client.focus.bydirection("left")
  --if client.focus then client.focus:raise() end
--end),
--awful.key({ modkey }, "#51", function () awful.client.focus.bydirection("right")
  --if client.focus then client.focus:raise() end
--end),

taglist_numbers = "arabic" -- we support arabic (1,2,3...),
-- arabic, chinese, {east|persian}_arabic, roman, thai, random
--
-- cpugraph_enable = true -- show CPU graph
-- cputext_format = " $1%" -- %1 average cpu, %[2..] every other thread
-- individually
--
-- membar_enable = true -- show memory bar
-- memtext_format = " $1%" -- %1 percentage, %2 used %3 total %4 free
--
-- date_format = "%a %m/%d/%Y %l:%M%p" -- refer to
-- http://en.wikipedia.org/wiki/Date_(Unix) specifiers
--
-- networks = {'eth0', 'wlan0'} -- Add your devices network interface here
-- netwidget, only show one that works
