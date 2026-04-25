return {
  url = "https://codeberg.org/andyg/leap.nvim",
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
    vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

    vim.keymap.set({ 'x', 'o' }, 'an', function()
      require('leap.treesitter').select {
        opts = require('leap.user').with_traversal_keys('n', 'N')
      }
    end)

    vim.keymap.set({ 'n', 'o' }, 'gs', function()
      require('leap.remote').action {
        -- Automatically enter Visual mode when coming from Normal.
        input = vim.fn.mode(true):match('o') and '' or 'v'
      }
    end)

    -- Highly recommended: define a preview filter to reduce visual noise
    -- and the blinking effect after the first keypress.
    -- For example, define word boundaries as the common case, that is, skip
    -- preview for matches starting with whitespace or an alphabetic
    -- mid-word character: foobar[baaz] = quux
    --                     *    ***  ** * *  *
    require('leap').opts.preview = function(ch0, ch1, ch2)
      return not (
        ch1:match('%s')
        or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
      )
    end

    -- Enable the traversal keys to repeat the previous search without
    -- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
    do
      local clever = require('leap.user').with_traversal_keys
      -- For relative directions, set the `backward` flags according to:
      -- local prev_backward = require('leap').state['repeat'].backward
      vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
        require('leap').leap {
          ['repeat'] = true, opts = clever('<cr>', '<bs>'),
        }
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', function()
        require('leap').leap {
          ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true,
        }
      end)
    end

    -- Set automatic paste after remote yank operations:
    vim.api.nvim_create_autocmd('User', {
      pattern = 'RemoteOperationDone',
      group = vim.api.nvim_create_augroup('LeapRemote', {}),
      callback = function(event)
        if vim.v.operator == 'y' and event.data.register == '"' then
          vim.cmd('normal! p')
        end
      end,
    })
  end
}
