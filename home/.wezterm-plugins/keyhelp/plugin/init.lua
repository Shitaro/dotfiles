local wezterm = require("wezterm")

local M = {}

local DEFAULT_THEME = {
	category_fg = "#7aa2f7",
	key_fg = "#bb9af7",
	desc_fg = "#a9b1d6",
	mods_fg = "#565f89",
	separator_fg = "#3b4261",
}

local function format_mods(entry, leader_display)
	if entry.display_mods then
		return entry.display_mods
	end
	local mods = entry.mods or ""
	if mods == "LEADER" then
		return leader_display
	end
	return mods
end

local function format_key(entry)
	return entry.display_key or entry.key
end

local function build_label(entry, theme, leader_display)
	local key_text = format_key(entry)
	local mods_text = format_mods(entry, leader_display)
	local desc = entry.desc or ""

	local label = wezterm.format({
		{ Foreground = { Color = theme.mods_fg } },
		{ Text = mods_text },
		{ Text = mods_text ~= "" and " + " or "" },
		{ Foreground = { Color = theme.key_fg } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = key_text },
		{ Attribute = { Intensity = "Normal" } },
		{ Foreground = { Color = theme.separator_fg } },
		{ Text = "  →  " },
		{ Foreground = { Color = theme.desc_fg } },
		{ Text = desc },
	})
	return label
end

local function build_header_label(category, theme)
	return wezterm.format({
		{ Foreground = { Color = theme.category_fg } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = "━━ " .. category .. " ━━" },
	})
end

--- @param config table    WezTerm config builder
--- @param opts table      KeyhelpOpts
function M.apply_to_config(config, opts)
	opts = opts or {}
	local keybindings = opts.keybindings or {}
	local trigger_key = opts.trigger_key or "?"
	local trigger_mods = opts.trigger_mods or "LEADER"
	local title = opts.title or "Keybindings Help"
	local fuzzy = opts.fuzzy ~= false
	local fuzzy_description = opts.fuzzy_description or "Filter: "
	local description = opts.description
	local alphabet = opts.alphabet
	local leader_display = opts.leader_display or "Leader"
	-- Merge theme: opts.theme overrides defaults
	local theme = {}
	for k, v in pairs(DEFAULT_THEME) do
		theme[k] = v
	end
	if opts.theme then
		for k, v in pairs(opts.theme) do
			theme[k] = v
		end
	end

	-- Set leader if provided
	if opts.leader then
		config.leader = opts.leader
	end

	-- Set key_tables if provided
	if opts.key_tables then
		config.key_tables = opts.key_tables
	end

	-- Build config.keys and choices from single data source
	local config_keys = {}
	local action_map = {}

	-- Group entries by category (preserve insertion order)
	local categories = {}
	local category_entries = {}

	for i, entry in ipairs(keybindings) do
		-- Add to config.keys if action exists
		if entry.action then
			table.insert(config_keys, {
				key = entry.key,
				mods = entry.mods,
				action = entry.action,
			})
		end

		-- Determine category
		local cat = entry.category or ""

		-- Track category order
		if not category_entries[cat] then
			table.insert(categories, cat)
			category_entries[cat] = {}
		end

		-- Add to help choices unless hidden
		if not entry.hidden then
			local id = tostring(i) .. ":" .. cat .. ":" .. format_key(entry)
			table.insert(category_entries[cat], {
				id = id,
				entry = entry,
			})
			if entry.action then
				action_map[id] = entry.action
			end
		end
	end

	-- Build InputSelector choices with category headers
	local choices = {}
	for _, cat in ipairs(categories) do
		local entries = category_entries[cat]
		if #entries > 0 then
			-- Category header
			table.insert(choices, {
				id = "__header__:" .. cat,
				label = build_header_label(cat, theme),
			})
			-- Entries in this category
			for _, item in ipairs(entries) do
				table.insert(choices, {
					id = item.id,
					label = build_label(item.entry, theme, leader_display),
				})
			end
		end
	end

	-- Build the help trigger action
	local help_action = wezterm.action.InputSelector({
		title = title,
		choices = choices,
		fuzzy = fuzzy,
		fuzzy_description = fuzzy_description,
		description = description,
		alphabet = alphabet,
		action = wezterm.action_callback(function(window, pane, id, label)
			if not id then
				return
			end
			if id:match("^__header__") then
				return
			end
			local a = action_map[id]
			if a then
				window:perform_action(a, pane)
			end
		end),
	})

	-- Add help trigger to config.keys
	table.insert(config_keys, {
		key = trigger_key,
		mods = trigger_mods,
		action = help_action,
	})

	config.keys = config_keys
end

return M
