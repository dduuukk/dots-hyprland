local M = {}

function M.load()
	local ok, c = pcall(require, "matugen.colors")
	if not ok then
		vim.notify("[matugen] colors.lua not found — run matugen first", vim.log.levels.WARN)
		return false
	end

	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "matugen"

	local hl = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- ── Base ────────────────────────────────────────────────────────────────
	hl("Normal", { fg = c.on_background, bg = c.background })
	hl("NormalNC", { fg = c.on_surface_variant, bg = c.surface_container_low })
	hl("NormalFloat", { fg = c.on_surface, bg = c.surface_container })

	hl("LineNr", { fg = c.outline })
	hl("CursorLineNr", { fg = c.primary, bold = true })
	hl("CursorLine", { bg = c.surface_container_high })
	hl("ColorColumn", { bg = c.surface_dim })
	hl("SignColumn", { fg = c.outline, bg = c.background })

	hl("Visual", { bg = c.surface_container_high })
	hl("Search", { fg = c.on_primary_container, bg = c.primary_container })
	hl("IncSearch", { fg = c.on_primary, bg = c.primary, bold = true })
	hl("Substitute", { fg = c.inverse_on_surface, bg = c.inverse_surface })

	hl("Comment", { fg = c.outline, italic = true })
	hl("Conceal", { fg = c.outline_variant })

	hl("MatchParen", { fg = c.tertiary, bold = true, underline = true })

	-- ── Syntax (legacy groups, non-TS buffers) ──────────────────────────────
	hl("Keyword", { fg = c.primary, bold = true })
	hl("Conditional", { fg = c.primary })
	hl("Repeat", { fg = c.primary })
	hl("Statement", { fg = c.primary })
	hl("Operator", { fg = c.on_surface_variant })
	hl("Exception", { fg = c.tertiary, bold = true })

	hl("Function", { fg = c.tertiary, bold = true })
	hl("Identifier", { fg = c.on_surface })

	hl("String", { fg = c.secondary_container })
	hl("Character", { fg = c.secondary_container })
	hl("Number", { fg = c.tertiary })
	hl("Boolean", { fg = c.primary })
	hl("Float", { fg = c.tertiary })

	hl("Type", { fg = c.primary_container })
	hl("StorageClass", { fg = c.primary })
	hl("Structure", { fg = c.primary })
	hl("Typedef", { fg = c.primary_container })

	hl("PreProc", { fg = c.outline_variant })
	hl("Include", { fg = c.outline_variant })
	hl("Define", { fg = c.outline_variant })
	hl("Macro", { fg = c.secondary })

	hl("Special", { fg = c.tertiary })
	hl("Delimiter", { fg = c.on_surface_variant })

	hl("Error", { fg = c.error })
	hl("Todo", { fg = c.on_primary, bg = c.primary, bold = true })

	-- ── Treesitter ──────────────────────────────────────────────────────────
	hl("@keyword", { link = "Keyword" })
	hl("@keyword.function", { fg = c.primary, italic = true })
	hl("@keyword.return", { fg = c.primary, bold = true })
	hl("@keyword.operator", { fg = c.on_surface_variant })
	hl("@function", { link = "Function" })
	hl("@function.builtin", { fg = c.tertiary, italic = true })
	hl("@function.macro", { fg = c.secondary })
	hl("@method", { fg = c.tertiary })
	hl("@method.call", { fg = c.tertiary })
	hl("@variable", { fg = c.on_surface })
	hl("@variable.builtin", { fg = c.primary, italic = true })
	hl("@parameter", { fg = c.on_surface, italic = true })
	hl("@type", { link = "Type" })
	hl("@type.builtin", { fg = c.primary_container, italic = true })
	hl("@type.qualifier", { fg = c.primary, bold = true })
	hl("@string", { link = "String" })
	hl("@string.escape", { fg = c.tertiary })
	hl("@number", { link = "Number" })
	hl("@boolean", { link = "Boolean" })
	hl("@comment", { link = "Comment" })
	hl("@operator", { link = "Operator" })
	hl("@punctuation.delimiter", { fg = c.on_surface_variant })
	hl("@punctuation.bracket", { fg = c.outline })
	hl("@constructor", { fg = c.tertiary })
	hl("@field", { fg = c.on_surface })
	hl("@property", { fg = c.on_surface_variant })
	hl("@namespace", { fg = c.primary })
	hl("@include", { fg = c.outline_variant, italic = true })
	hl("@preproc", { fg = c.outline_variant })
	hl("@constant", { fg = c.tertiary_container })
	hl("@constant.builtin", { fg = c.tertiary, italic = true })
	hl("@constant.macro", { fg = c.secondary })
	hl("@label", { fg = c.primary })
	hl("@attribute", { fg = c.secondary })

	-- ── LSP semantic tokens ─────────────────────────────────────────────────
	hl("@lsp.type.function", { link = "Function" })
	hl("@lsp.type.method", { link = "@method" })
	hl("@lsp.type.variable", { link = "@variable" })
	hl("@lsp.type.parameter", { link = "@parameter" })
	hl("@lsp.type.keyword", { link = "Keyword" })
	hl("@lsp.type.type", { link = "Type" })
	hl("@lsp.type.namespace", { link = "@namespace" })
	hl("@lsp.type.macro", { link = "@function.macro" })
	hl("@lsp.type.enumMember", { fg = c.tertiary_container })
	hl("@lsp.type.struct", { link = "Structure" })
	hl("@lsp.type.interface", { fg = c.primary_container, italic = true })
	hl("@lsp.type.typeParameter", { fg = c.primary_container })
	hl("@lsp.type.decorator", { fg = c.secondary })

	-- ── UI chrome ───────────────────────────────────────────────────────────
	hl("StatusLine", { fg = c.on_surface, bg = c.surface_container })
	hl("StatusLineNC", { fg = c.outline, bg = c.surface_container_low })
	hl("WinSeparator", { fg = c.outline_variant })

	hl("TabLine", { fg = c.on_surface_variant, bg = c.surface_container_low })
	hl("TabLineSel", { fg = c.on_primary, bg = c.primary, bold = true })
	hl("TabLineFill", { bg = c.background })

	hl("Pmenu", { fg = c.on_surface, bg = c.surface_container })
	hl("PmenuSel", { fg = c.on_primary, bg = c.primary })
	hl("PmenuSbar", { bg = c.surface_container_low })
	hl("PmenuThumb", { bg = c.primary_fixed_dim })

	hl("FloatBorder", { fg = c.outline_variant, bg = c.surface_container })
	hl("FloatTitle", { fg = c.primary, bold = true })

	hl("Folded", { fg = c.on_surface_variant, bg = c.surface_container_low })
	hl("FoldColumn", { fg = c.outline, bg = c.background })

	-- ── Diagnostics ─────────────────────────────────────────────────────────
	hl("DiagnosticError", { fg = c.error })
	hl("DiagnosticWarn", { fg = c.tertiary })
	hl("DiagnosticInfo", { fg = c.secondary })
	hl("DiagnosticHint", { fg = c.primary })
	hl("DiagnosticVirtualTextError", { fg = c.on_error_container, bg = c.error_container })
	hl("DiagnosticVirtualTextWarn", { fg = c.on_tertiary_container, bg = c.tertiary_container })
	hl("DiagnosticVirtualTextInfo", { fg = c.on_secondary_container, bg = c.secondary_container })
	hl("DiagnosticVirtualTextHint", { fg = c.on_primary_container, bg = c.primary_container })
	hl("DiagnosticUnderlineError", { undercurl = true, sp = c.error })
	hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.tertiary })
	hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.secondary })
	hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.primary })

	-- ── Git / Diff ───────────────────────────────────────────────────────────
	hl("DiffAdd", { bg = c.secondary_container })
	hl("DiffChange", { bg = c.surface_container_high })
	hl("DiffDelete", { fg = c.error, bg = c.error_container })
	hl("DiffText", { fg = c.on_secondary_container, bg = c.secondary_container, bold = true })

	-- gitsigns
	hl("GitSignsAdd", { fg = c.secondary })
	hl("GitSignsChange", { fg = c.primary })
	hl("GitSignsDelete", { fg = c.error })

	return true
end

return M
