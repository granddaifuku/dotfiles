local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- maximize the window --
wezterm.on(
   'gui-startup', function()
	  local tab, pane, window = mux.spawn_window{}
	  window:gui_window():maximize()
   end
)

-- TODO: When the feature would be available, apply followings.
-- TODO: see https://wezfurlong.org/wezterm/config/lua/wezterm.gui/default_key_tables.html

-- local search_mode = nil
-- if wezterm.gui then
--    search_mode = wezterm.gui.default_key_tables().search_mode
--    table.insert(
-- 	  search_mode,
-- 	  { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
-- 	  { key = 'Enter', mods = 'NONE', action = act.CopyMode 'NextMatch'}
--    )
-- end
-- key_tables = {search_mode = search_mode}

local keys = {
   -- paste --
   {
	  key = 'y',
	  mods = 'CTRL',
	  action = act.PasteFrom 'Clipboard',
   },
   -- Scrolling --
   {
	  key = 'v',
	  mods = 'CTRL',
	  action = act.ScrollByPage(1),
   },
   {
	  key = 'v',
	  mods = 'OPT',
	  action = act.ScrollByPage(-1),
   },
   -- Split the pane --
   {
	  key = '2',
	  mods = 'LEADER',
	  action = act.SplitVertical {
		 domain = 'CurrentPaneDomain'
	  },
   },
   {
	  key = '3',
	  mods = 'LEADER',
	  action = act.SplitHorizontal {
		 domain = 'CurrentPaneDomain'
	  },
   },
   {
	  key = 'o',
	  mods = 'LEADER',
	  action = act.ActivatePaneDirection 'Next',
   },
   -- Search --
   {
	  key = 's',
	  mods = 'CTRL',
	  action = act.Search {
		 CaseInSensitiveString = ''
	  },
   },
   -- Tab --
   {
	  key = 't',
	  mods = 'CTRL',
	  action = act.SpawnTab 'CurrentPaneDomain',
   },
   {
	  key = 't',
	  mods = 'OPT',
	  action = act.ActivateTabRelative(1),
   },
   -- Close the pane --
   {
	  key = 'k',
	  mods = 'LEADER',
	  action = act.CloseCurrentPane { confirm = true },
   },
   {
	  key = 'q',
	  mods = 'CTRL',
	  action = act.CloseCurrentTab { confirm = true },
   },
}
for i = 1, 8 do
   table.insert(keys,
				{
				   key = tostring(i),
				   mods = 'CTRL',
				   action = act.ActivateTab(i - 1),
				}
   )
end

return {
   -- Keys --
   leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 1000 },
   key_tables = {
	  search_mode = {
		 {
			key = 'g',
			mods = 'CTRL',
			action = act.CopyMode 'Close'
		 },
		 {
			key = 'Enter',
			mods = 'NONE',
			action = act.CopyMode 'NextMatch'
		 },
		 {
			key = 'n',
			mods = 'CTRL',
			action = act.CopyMode 'NextMatch'
		 },
		 {
			key = 'p',
			mods = 'CTRL',
			action = act.CopyMode 'PriorMatch'
		 },
	  },
   },
   keys = keys,
   -- Appearance --
   color_scheme = "Andromeda",
   colors = { compose_cursor = "#696969" },
   default_cursor_style = 'BlinkingBar',
   cursor_blink_rate = 575,
   font = wezterm.font 'Menlo',
   line_height = 1.2,
   hide_tab_bar_if_only_one_tab = true,
}
