return {
  "linrongbin16/lsp-progress.nvim",
  lazy = true,
  config = function()
    require("lsp-progress").setup({
      client_format = function(client_name, spinner, series_messages)
        do
          -- Always nil to disable LSP load progress
          return nil
        end
        -- LSP load progress
        -- if #series_messages == 0 then
        --   return nil
        -- end
        -- return {
        --   name = client_name,
        --   body = spinner .. " " .. table.concat(series_messages, ", "),
        -- }
      end,
      format = function(client_messages)
        --- @param name string
        --- @param msg string?
        --- @return string
        local function stringify(name, msg)
          return msg and string.format("%s %s", name, msg) or name
        end

        -- local sign = "" -- nf-fa-gear \uf013
        -- bufnr = 0 means current active buffer only
        local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
        local messages_map = {}
        for _, climsg in ipairs(client_messages) do
          messages_map[climsg.name] = climsg.body
        end

        if #lsp_clients > 0 then
          table.sort(lsp_clients, function(a, b)
            if a == nil or b == nil then
              return true
            end
            return a.name < b.name
          end)
          local builder = {}
          for _, cli in ipairs(lsp_clients) do
            if type(cli) == "table" and type(cli.name) == "string" and string.len(cli.name) > 0 then
              if messages_map[cli.name] then
                table.insert(builder, stringify(cli.name, messages_map[cli.name]))
              else
                table.insert(builder, stringify(cli.name))
              end
            end
          end
          if #builder > 0 then
            -- return sign .. " " .. table.concat(builder, ", ")
            return table.concat(builder, ", ")
          end
        end
        return ""
      end,
    })
  end,
}
