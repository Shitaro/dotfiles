-- WezTerm configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()

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

config.leader = { key = "b", mods = "CMD", timeout_milliseconds = 10000 }
config.keys = {
	-- Claude Code: Shift+Enter で改行
	{ key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1b\r") },

	-- ペイン分割
	{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- ペイン移動
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },

	-- ペインを閉じる
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- リサイズモードに入る
	{ key = "r", mods = "LEADER", action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

	-- ペイン最大化トグル
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

	-- 新規タブ
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

	-- タブ移動
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

	-- コマンドパレット
	{ key = "P", mods = "LEADER", action = wezterm.action.ActivateCommandPalette },

	-- 設定再読み込み
	{ key = "R", mods = "LEADER", action = wezterm.action.ReloadConfiguration },

	-- Quick Select
	{ key = "s", mods = "LEADER", action = wezterm.action.QuickSelect },

	-- コピーモード
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

	-- 検索
	{ key = "F", mods = "CMD|SHIFT", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },

	-- フルスクリーン
	{ key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },

	-- ヘルプ（キーバインド一覧）
	{ key = "?", mods = "LEADER", action = wezterm.action.SpawnCommandInNewTab({
		args = { "/bin/sh", "-c", [[
cat << 'EOF' | less -R
  WezTerm キーバインド一覧 (Leader: Cmd+b)
  ==========================================

  ペイン操作
  ----------
  \       左右に分割
  -       上下に分割
  h/j/k/l ペイン移動
  x       ペインを閉じる
  z       ペイン最大化/解除
  r       リサイズモード (h/j/k/l で調整, Esc で終了)

  タブ操作
  --------
  c       新規タブ
  n       次のタブ
  p       前のタブ

  ワークスペース
  --------------
  w       一覧/切り替え
  W       新規作成

  その他
  ------
  s       Quick Select
  [       コピーモード
  f       フルスクリーン
  P       コマンドパレット
  R       設定再読み込み
  ?       このヘルプ

  コピーモード (Leader + [)
  -------------------------
  h/j/k/l   移動
  w/b       次/前の単語
  0/$       行頭/行末
  g/G       先頭/末尾
  Ctrl+u/d  半ページ上/下
  v/V       文字/行選択
  Ctrl+v    矩形選択
  y         コピーして終了
  Esc/q     キャンセル

  検索: Cmd+Shift+F

  (j/k: スクロール, q: 終了)
EOF
]] },
	}) },

	-- ワークスペース
	{ key = "w", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }) },
	{ key = "W", mods = "LEADER", action = wezterm.action.PromptInputLine({
		description = "New workspace name:",
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				window:perform_action(wezterm.action.SwitchToWorkspace({ name = line }), pane)
			end
		end),
	}) },
}

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

	if tab.is_active then
		tab_bg = "#7aa2f7"
		tab_fg = "#1a1b26"
	end

	local pane = tab.active_pane
	local process = pane.foreground_process_name:match("([^/]+)$") or ""
	local cwd = pane.current_working_dir
	local dir = ""
	if cwd then
		dir = cwd.file_path or tostring(cwd)
		dir = dir:gsub("^" .. os.getenv("HOME"), "~")
		dir = dir:match("([^/]+)/?$") or dir
	end
	local title = " " .. process .. ": " .. dir .. " "
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
	if cwd then
		local cwd_path = cwd.file_path or tostring(cwd)
		cwd_path = cwd_path:gsub("^" .. os.getenv("HOME"), "~")

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

	window:set_right_status(wezterm.format(cells))
end)

-- =============================================================================
-- キーテーブル（モード）
-- =============================================================================

config.key_tables = {
	-- リサイズモード: h/j/k/l で調整、Escで終了
	resize_pane = {
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 2 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 2 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 2 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 2 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
