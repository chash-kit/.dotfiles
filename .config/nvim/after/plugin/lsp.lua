local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
	'pylsp',
})


vim.keymap.set("n","<leader>f", [[:lua vim.lsp.buf.format()<CR>]],{})

lsp.configure('pylsp', {
  settings = {
    pylsp = {
      configurationSources = {'flake8'},
      plugins = {
        pycodestyle = {enabled = false},
        flake8 = {
          enabled = true,
          ignore = {},
        }
      }
    }
  }
})

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'preview'}
-- shortmess is used to avoid excessive messages
vim.opt.shortmess = vim.opt.shortmess + { c = true}

local cmp = require'cmp'
cmp.setup({

  mapping = {
    -- Shift+TAB to go to the Previous Suggested item
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    -- Tab to go to the next suggestion
    ['<Tab>'] = cmp.mapping.select_next_item(),
    -- CTRL+SHIFT+f to scroll backwards in description
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    -- CTRL+F ZXto scroll forwards in the description
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- CTRL+SPACE to bring up completion at current Cursor location
    ['<C-Space>'] = cmp.mapping.complete(),
    -- CTRL+e to exit suggestion and close it
    ['<C-e>'] = cmp.mapping.close(),
    -- CR (enter or return) to CONFIRM the currently selection suggestion
    -- We set the ConfirmBehavior to insert the Selected suggestion
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- sources are the installed sources that can be used for code suggestions
  sources = {
      { name = 'path' },
      { name = 'nvim_lsp', keyword_length = 3 },
      { name = 'nvim_lsp_signature_help'},
      { name = 'nvim_lua', keyword_length = 2},
      { name = 'buffer', keyword_length = 2 },
      { name = 'vsnip', keyword_length = 2 },
  },
  -- Add borders to the windows
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  -- add formating of the different sources
    formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'b',
              path = 'p'
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
