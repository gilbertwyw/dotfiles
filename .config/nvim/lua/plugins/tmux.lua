return {
  {
    'tmux-plugins/vim-tmux',
    {
      'christoomey/vim-tmux-navigator',
      config = function()
        vim.g.tmux_navigator_disable_when_zoomed = 1
      end
    },
  }
}
