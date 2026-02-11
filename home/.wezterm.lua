-- WezTerm configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local ok, keyhelp = pcall(dofile, wezterm.home_dir .. "/.wezterm-plugins/keyhelp/plugin/init.lua")
if not ok then
	wezterm.log_error("keyhelp plugin failed to load: " .. tostring(keyhelp) .. " -- run 'task install' to fix symlinks")
	keyhelp = nil
end

-- =============================================================================
-- 外観設定
-- =============================================================================

-- カラースキーム（ダーク系）
config.color_scheme = "Tokyo Night"

-- フォント設定
config.font = wezterm.font("UDEV Gothic NF")
config.font_size = 11.0

-- 背景透過
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

-- 初期ウィンドウサイズ
config.initial_cols = 140
config.initial_rows = 40

-- ウィンドウ装飾
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 12,
	right = 12,
	top = 12,
	bottom = 12,
}

-- タブバー
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.tab_max_width = 50
config.window_frame = {
	font = wezterm.font("UDEV Gothic NF"),
	font_size = 12.0,
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

-- タブバーの色（背景と一体化）
-- Tokyo Night 背景色 #1a1b26 (rgb: 26,27,38) + window_background_opacity と同じ透過率 0.85
config.colors = {
	tab_bar = {
		background = "rgba(26, 27, 38, 0.85)",
		inactive_tab_edge = "none",
		active_tab = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",
		},
	},
}

-- カーソル
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- =============================================================================
-- キーバインド（tmux風: Cmd+b がリーダーキー）
-- =============================================================================

if keyhelp then
	keyhelp.apply_to_config(config, {
		leader = { key = "b", mods = "CMD", timeout_milliseconds = 10000 },
		leader_display = "Cmd+b",
		title = "キーバインド一覧",
		fuzzy = true,
		fuzzy_description = wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { Color = "#7dcfff" } },
			{ Text = "Search: " },
		}),
		keybindings = {
			-- 特殊キー
			{ key = "Enter", mods = "SHIFT", action = act.SendString("\x1b\r"),
				desc = "改行 (Claude Code)", category = "特殊" },
			-- ペイン操作
			{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
				desc = "左右に分割", category = "ペイン操作" },
			{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
				desc = "上下に分割", category = "ペイン操作" },
			{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left"), hidden = true },
			{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down"), hidden = true },
			{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up"), hidden = true },
			{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right"), hidden = true },
			{ display_key = "h/j/k/l", mods = "LEADER", desc = "ペイン移動", category = "ペイン操作" },
			{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }),
				desc = "ペインを閉じる", category = "ペイン操作" },
			{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState,
				desc = "最大化/解除", category = "ペイン操作" },
			{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
				desc = "リサイズモード", category = "ペイン操作" },
			-- タブ操作
			{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain"),
				desc = "新規タブ", category = "タブ操作" },
			{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1),
				desc = "次のタブ", category = "タブ操作" },
			{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1),
				desc = "前のタブ", category = "タブ操作" },
			-- ワークスペース
			{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
				desc = "一覧/切り替え", category = "ワークスペース" },
			{ key = "W", mods = "LEADER", action = act.PromptInputLine({
				description = "New workspace name:",
				action = wezterm.action_callback(function(window, pane, line)
					if line then window:perform_action(act.SwitchToWorkspace({ name = line }), pane) end
				end),
			}),
				desc = "新規作成", category = "ワークスペース" },
			-- その他
			{ key = "s", mods = "LEADER", action = act.QuickSelect,
				desc = "Quick Select", category = "その他" },
			{ key = "[", mods = "LEADER", action = act.ActivateCopyMode,
				desc = "コピーモード", category = "その他" },
			{ key = "F", mods = "CMD|SHIFT", action = act.Search({ CaseInSensitiveString = "" }),
				desc = "検索", category = "その他" },
			{ key = "f", mods = "LEADER", action = act.ToggleFullScreen,
				desc = "フルスクリーン", category = "その他" },
			{ key = "P", mods = "LEADER", action = act.ActivateCommandPalette,
				desc = "コマンドパレット", category = "その他" },
			{ key = "R", mods = "LEADER", action = act.ReloadConfiguration,
				desc = "設定再読み込み", category = "その他" },
			-- コピーモード（参照エントリ: 表示のみ）
			{ display_key = "h/j/k/l", desc = "移動", category = "コピーモード" },
			{ display_key = "w/b", desc = "次/前の単語", category = "コピーモード" },
			{ display_key = "0/$", desc = "行頭/行末", category = "コピーモード" },
			{ display_key = "v/V", desc = "文字/行選択", category = "コピーモード" },
			{ display_key = "y", desc = "コピーして終了", category = "コピーモード" },
			{ display_key = "Esc/q", desc = "キャンセル", category = "コピーモード" },
			-- リサイズモード（参照エントリ: 表示のみ）
			{ display_key = "h/j/k/l", display_mods = "リサイズ中", desc = "サイズ調整", category = "リサイズモード" },
			{ display_key = "Esc/Enter", display_mods = "リサイズ中", desc = "モード終了", category = "リサイズモード" },
		},
		key_tables = {
			resize_pane = {
				{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
				{ key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
				{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
				{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
				{ key = "Escape", action = "PopKeyTable" },
				{ key = "Enter", action = "PopKeyTable" },
			},
		},
	})
end

-- =============================================================================
-- 動作設定
-- =============================================================================

-- スクロールバック
config.scrollback_lines = 10000

-- macOS固有設定
config.native_macos_fullscreen_mode = true

-- 日本語入力（IME）
config.use_ime = true

-- =============================================================================
-- タブタイトル
-- =============================================================================

-- Powerline Extra グリフ (utf8.char で直接指定)
-- 平行四辺形スタイル
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)   -- ple_lower_left_triangle (◣)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)  -- ple_upper_left_triangle (◤)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- 非アクティブタブの色
	local tab_bg = "#24283b"
	local tab_fg = "#565f89"
	-- タブバー背景（透過）
	local bar_bg = "rgba(26, 27, 38, 0.85)"

	-- ホバー時は明るくする
	if hover then
		tab_bg = "#3b4261"
		tab_fg = "#a9b1d6"
	end

	-- アクティブタブ
	if tab.is_active then
		tab_bg = "#7aa2f7"
		tab_fg = "#1a1b26"
	end

	local pane = tab.active_pane
	local process_path = pane.foreground_process_name or ""
	local process
	if process_path:lower():find("claude") then
		process = "claude"
	else
		process = process_path:match("([^/]+)$") or ""
	end
	local cwd = pane.current_working_dir
	local dir = ""
	if cwd then
		dir = cwd.file_path or tostring(cwd)
		dir = dir:gsub("^" .. os.getenv("HOME"), "~")
		dir = dir:match("([^/]+)/?$") or dir
	end
	local ARROW = utf8.char(0xe0b1)  -- Powerline thin arrow
	local FOLDER = utf8.char(0xf07b) -- フォルダアイコン
	local title = " " .. process .. " " .. ARROW .. " " .. FOLDER .. " " .. dir .. " "
	-- 三角形(2) + スペース(2) 用に余裕を確保
	title = wezterm.truncate_right(title, max_width - 4)

	local result = {}

	-- 左端: 最初のタブ以外は三角形を追加
	if tab.tab_index > 0 then
		table.insert(result, { Background = { Color = bar_bg } })
		table.insert(result, { Foreground = { Color = tab_bg } })
		table.insert(result, { Text = SOLID_LEFT_ARROW })
	end
	-- タブ本体
	table.insert(result, { Background = { Color = tab_bg } })
	table.insert(result, { Foreground = { Color = tab_fg } })
	table.insert(result, { Text = title })
	-- 右端: bar_bg の上に tab_bg の三角形
	table.insert(result, { Background = { Color = bar_bg } })
	table.insert(result, { Foreground = { Color = tab_bg } })
	table.insert(result, { Text = SOLID_RIGHT_ARROW })
	-- タブ間スペース
	table.insert(result, { Text = "  " })

	return result
end)

-- =============================================================================
-- ステータスバー
-- =============================================================================

wezterm.on("update-right-status", function(window, pane)
	local cells = {}
	-- Nerd Font アイコン（utf8.char で確実に指定）
	local SOLID_LEFT = utf8.char(0xe0b2) -- Powerline 左セパレーター
	local FOLDER = utf8.char(0xf07b) -- フォルダアイコン
	local GIT_BRANCH = utf8.char(0xe0a0) -- Git ブランチアイコン

	-- Vim モード（zsh から送信される user var）
	local vim_mode = pane:get_user_vars().VIM_MODE or ""
	local vim_colors = {
		NORMAL = "#bb9af7",    -- 紫
		INSERT = "#9ece6a",    -- 緑
		VISUAL = "#ff9e64",    -- オレンジ
		["V-LINE"] = "#ff9e64", -- オレンジ
		REPLACE = "#f7768e",   -- 赤
		SEARCH = "#7dcfff",    -- 水色
	}
	if vim_mode ~= "" then
		local color = vim_colors[vim_mode] or "#7aa2f7"
		table.insert(cells, { Foreground = { Color = color } })
		table.insert(cells, { Text = SOLID_LEFT })
		table.insert(cells, { Foreground = { Color = "#1a1b26" } })
		table.insert(cells, { Background = { Color = color } })
		table.insert(cells, { Attribute = { Intensity = "Bold" } })
		table.insert(cells, { Text = " " .. vim_mode .. " " })
	end

	-- リーダー/キーテーブル状態
	local mode_text = ""
	if window:leader_is_active() then
		mode_text = "LEADER"
	end
	local key_table = window:active_key_table()
	if key_table then
		mode_text = string.upper(key_table)
	end

	if mode_text ~= "" then
		local bg = vim_mode ~= "" and (vim_colors[vim_mode] or "#7aa2f7") or "none"
		table.insert(cells, { Foreground = { Color = "#7aa2f7" } })
		if bg ~= "none" then
			table.insert(cells, { Background = { Color = bg } })
		end
		table.insert(cells, { Text = SOLID_LEFT })
		table.insert(cells, { Foreground = { Color = "#1a1b26" } })
		table.insert(cells, { Background = { Color = "#7aa2f7" } })
		table.insert(cells, { Attribute = { Intensity = "Bold" } })
		table.insert(cells, { Text = " " .. mode_text .. " " })
	end

	-- CWD
	local cwd = pane:get_current_working_dir()
	local cwd_path_raw = nil
	if cwd then
		cwd_path_raw = cwd.file_path or tostring(cwd)
		local cwd_path = cwd_path_raw:gsub("^" .. os.getenv("HOME"), "~")

		if mode_text ~= "" then
			table.insert(cells, { Foreground = { Color = "#24283b" } })
			table.insert(cells, { Background = { Color = "#7aa2f7" } })
		else
			table.insert(cells, { Foreground = { Color = "#24283b" } })
		end
		table.insert(cells, { Text = SOLID_LEFT })
		table.insert(cells, { Foreground = { Color = "#7dcfff" } })
		table.insert(cells, { Background = { Color = "#24283b" } })
		table.insert(cells, { Attribute = { Intensity = "Normal" } })
		table.insert(cells, { Text = " " .. FOLDER .. " " .. cwd_path .. " " })
	end

	-- Git ブランチ
	if cwd_path_raw then
		local success, stdout = wezterm.run_child_process({ "git", "-C", cwd_path_raw, "rev-parse", "--abbrev-ref", "HEAD" })
		if success then
			local branch = stdout:gsub("%s+", "")
			if branch ~= "" then
				table.insert(cells, { Foreground = { Color = "#9ece6a" } })
				table.insert(cells, { Background = { Color = "#24283b" } })
				table.insert(cells, { Text = SOLID_LEFT })
				table.insert(cells, { Foreground = { Color = "#1a1b26" } })
				table.insert(cells, { Background = { Color = "#9ece6a" } })
				table.insert(cells, { Attribute = { Intensity = "Bold" } })
				table.insert(cells, { Text = " " .. GIT_BRANCH .. " " .. branch .. " " })
			end
		end
	end

	window:set_right_status(wezterm.format(cells))
end)

return config
