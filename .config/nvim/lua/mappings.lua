------------------------------------------------------------------------
--                         Command-line mode                          --
------------------------------------------------------------------------

vim.keymap.set('c', 'w!!', 'w !sudo -S tee > /dev/null %')

------------------------------------------------------------------------
--                            Insert mode                             --
------------------------------------------------------------------------

-- jk to escape
vim.keymap.set('i', 'jk', '<Esc>')

-- undo break points
vim.keymap.set('i', '!', '!<c-g>u')
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', '?', '?<c-g>u')

-- make last typed word uppercase
vim.keymap.set('i', '<Plug>UpCase', '<Esc>hgUaweA')
vim.keymap.set('i', ';u', '<Plug>UpCase', { remap = true })

------------------------------------------------------------------------
--                            Normal mode                             --
------------------------------------------------------------------------

-- join line without moving the cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- select whatever's just been pasted
vim.keymap.set('n', 'gV', '`[V`]')

-- move vertically by visual line
local moveWithHistoryFn = function (key, min_line_count)
  return function ()
    local vcount = vim.v.count

    if not vcount then
      return 'g' .. key
    end

    return vcount > min_line_count and "m'" .. vcount .. key or key
  end
end

-- move vertically by visual line
vim.keymap.set("n", 'j', moveWithHistoryFn('j', 5), { expr = true })
vim.keymap.set("n", 'k', moveWithHistoryFn('k', 5), { expr = true })

-- quickly edit/reload the vimrc file
vim.keymap.set('n', '<leader>re', ':e $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>rr', ':so $MYVIMRC<cr>')

vim.keymap.set('n', '<Backspace>', '<C-^>')

-- Resize window
vim.keymap.set('n', '<Left>', ':vertical resize +2<cr>')
vim.keymap.set('n', '<Right>', ':vertical resize -2<cr>')
vim.keymap.set('n', '<Up>', ':resize -2<cr>')
vim.keymap.set('n', '<Down>', ':resize +2<cr>')

-- redirect change operation to blackhole
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- from Damian Conway
vim.keymap.set('n', 'S', ':%s//g<Left><Left>')

------------------------------------------------------------------------
--                            Select mode                             --
------------------------------------------------------------------------

-- increment & decrement
vim.keymap.set('x', '+', 'g<C-a>gv')
vim.keymap.set('x', '-', 'g<C-x>gv')

------------------------------------------------------------------------
--                            Visual mode                             --
------------------------------------------------------------------------

vim.keymap.set('v', '<c-a>', '<c-a>gv')
vim.keymap.set('v', '<c-x>', '<c-x>gv')

-- Visual shifting (does not exit Visual mode)
-- http://vim-jp.org/blog/2015/06/30/visual-ctrl-a-ctrl-x.html
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
