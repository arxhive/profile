return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup({
      fast_wrap = {
        map = "<C-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        before_key = "h",
        after_key = "l",
        cursor_pos_before = true,
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })

    -- Add spaces between parentheses
    function rule2(a1, ins, a2, lang)
      npairs.add_rule(Rule(ins, ins, lang)
        :with_pair(function(opts)
          return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
        end))
    end

    rule2("(", "*", ")", "ocaml")
    rule2("(*", " ", "*)", "ocaml")
    rule2("(", " ", ")")
    rule2("{", " ", "}")
    rule2("[", " ", "]")

    -- Expand multiple pairs on enter key (on new line)
    local get_closing_for_line = function(line)
      local i = -1
      local clo = ""

      while true do
        i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
        if i == nil then
          break
        end
        local ch = string.sub(line, i, i)
        local st = string.sub(clo, 1, 1)

        if ch == "{" then
          clo = "}" .. clo
        elseif ch == "}" then
          if st ~= "}" then
            return ""
          end
          clo = string.sub(clo, 2)
        elseif ch == "(" then
          clo = ")" .. clo
        elseif ch == ")" then
          if st ~= ")" then
            return ""
          end
          clo = string.sub(clo, 2)
        elseif ch == "[" then
          clo = "]" .. clo
        elseif ch == "]" then
          if st ~= "]" then
            return ""
          end
          clo = string.sub(clo, 2)
        end
      end

      return clo
    end

    -- npairs.remove_rule("(")
    -- npairs.remove_rule("{")
    -- npairs.remove_rule("[")

    npairs.add_rule(Rule("[%(%{%[]", "")
      :use_regex(true)
      :replace_endpair(function(opts)
        return get_closing_for_line(opts.line)
      end)
      :end_wise(function(opts)
        -- Do not endwise if there is no closing
        return get_closing_for_line(opts.line) ~= ""
      end))

    -- Add trailing commas to "'} inside Lua tables
    local ts_conds = require("nvim-autopairs.ts-conds")
    npairs.add_rules({
      Rule("{", "},", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
      Rule("'", "',", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
      Rule('"', '",', "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
    })
    -- end config
  end,
}
