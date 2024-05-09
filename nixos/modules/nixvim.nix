{ inputs, pkgs, ... }:

{ programs.nixvim = {
    enable = true;
    enableMan = true;
    clipboard.providers.xclip.enable = true;
    opts = {
      autochdir = true;
      clipboard = "unnamedplus";
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smarttab = true;
      autoindent = true;
      linebreak = true;
      hidden = true;
      cindent = true;
      undofile = true;
      swapfile = false;
      ignorecase = true;
      smartcase = true;
#     incsearch = true;
#     fillchars = { eob = " "; };
    };
    globals = {
      mapleader = " ";
    };
    plugins = {
      comment.enable = true;
      nix-develop.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
#     nvim-colorizer.enable = true;
    };  
  };
}
