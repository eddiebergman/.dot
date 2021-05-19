# folds.scm
Defines folds used by `nvim-treesitter`, have to overwrite the file they provide
for folding as we can't overwrite it manually.

Either do manually
```sh
cp ./folds.scm ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/queries/python/folds.scm
```

Or run the lua function from nvim
```lua
require('configs/treesitter').overwrite_with_custom_folds()
```

