# vim plugins

This repository contains a selection of vim plugins as git submodules.

## Installation

To install, first clone the repository and get the submodules:

    git clone https://github.com/arkku/vim-plugin-collection.git
    cd vim-plugin-collection
    git submodule init
    git submodule update --init --recursive

Then symlink the specific plugin directories in your Vim's `pack` directory:

* **vim**: `~/.vim/pack`
* **neovim**: `~/.local/share/nvim/site/pack`

The directory structure under `pack` must be maintained as it is in this
repository, i.e., `pack/<whatever>/start/<plugin>`. So, to use exactly the
plugins in this repository, you can symlink the entire [pack](./pack), or
select categories under pack (e.g., [pack/programming](./pack/programming)), or
inidividual plugins by creating your own.

You should also run `:helptags ALL` for vim to be able to find the plugins'
help documentation.

## Plugins

### Universal

The [universal](./pack/universal/start) collection contains general-purpose
plugins that are "universally" helpful, whether you are coding or just writing
text.

#### surround

[surround.vim](https://github.com/tpope/vim-surround) deals with adding,
removing, and changing "surroundings", such as parentheses.

* `cs"'` – Change surrounding `"` to `'`
* `cs'<q>` – Change surrounding `'` to `<q>` and `</q>`
* `cst"` – Change surrounding tags to `"`
* `ds"` – Remove surrounding "
* `ysiw)` – Surround word (`iw`) with `()`
* `ys$]` – Surround to end of line with `[]`
* `yst,"` – Surround to, but not including, next `,` with `"`

Also works in visual mode, e.g., press `V`, make a selection, and then type
`S<p class="paragraph">` to surround the selection in `<p></p>`, including
the attribute.

Note that using the closing `)`, `]`, or `}` doesn't add space, whereas
using the opening `(`, `[`, or `{` does.

#### repeat

[repeat.vim](https://github.com/tpope/vim-repeat) enhances some plugins with
repeat capability using `.`. The aforementioned `vim-surround` is one such
plugin.

#### characterize

[characterize.vim](https://github.com/tpope/vim-characterize) enhances the
`ga` include additional info about unicode characters.

* `ga` – show info about the character under the cursor

#### unimpaired

[unimpaired](https://github.com/tpope/vim-unimpaired) unimpaired is collection
of paired keyboard mappings, typically navigation in two directions, but also
settings on/off, edit operations up/down, etc. The complete set of actions is
long, so I will not duplicate it here, but here are some highlights:

* `]l`, `[l` – next/previous location
* `]L`, `[L` – first/last location
* `]q`, `[q` – next/previous quickfix error
* `]Q`, `[Q` – first/last quickfix
* `]t`, `[t` – next/previous tag
* `]T`, `[T` – first/last tag
* `]n`, `[n` – next/previous conflict/diff marker (try `d[n` inside a conflict)
* `]e` , `[e` – exchange this line with the next/previous line
* `[os`, `]os` – toggle `spell` option on/off
* `]oi`, `[oi` – toggle `ignorecase` option on/off

### Programming

The [programming](./pack/programming/start) collection contains plugins that
are for programming in general. Language-specific plugins are in separate
collections to avoid clutter where not needed.

#### commentary

[commentary.vim](https://github.com/tpope/vim-commentary) helps comment out
stuff.

* `gcc` – Toggle comment on current line
* `gc` + motion – Comment target of motion (e.g., `gcap` for paragraph)
* `gc` in visual mode – Comment selection

#### endwise

[endwise.vim](https://github.com/tpope/vim-endwise) automatically inserts `end`
in various programming languages (such as Ruby and shell script). It errs on
the side of caution, and I have never seen it insert when it shouldn't.

#### radical

[radical.vim](https://github.com/glts/vim-radical) helps convert between
different integer representations, i.e., decimal, hexadecimal and binary.

* `gA` – Shows the integer under the cursor in each supported base
* `crx` – Converts an integer to hexadecimal (base 16)
* `crd` – Converts an integer to decimal (base 10)
* `crb` – Converts an integer to decimal (base 2)

#### magnum

[magnum.vim](https://github.com/glts/vim-magnum) is a big integer library. It
is here because `radical` depends on it.

#### apathy

[apathy.vim](https://github.com/tpope/vim-apathy) sets the include paths for
a number of different programming languages. These are some of the standard
commands that will benefit when paths have been set correctly:

* `gf` – jump to the include file for the word under cursor
* `:sfind file.h` – open a split with `file.h`
* `:ilist string` – search for `string` in include files
* `[i` – show first match for word under cursor in include files
* `[I` – show all matches for word under cursor in include files

### UI

The [UI](./pack/ui/start) collection is for plugins that make potentially
intrusive changes to the user interface.

#### buffet

[vim-buffet](https://github.com/bagrat/vim-buffet) changes the tab bar to show
both tabs and buffers. A couple of commands are added:

* `:Bw`/`:Bw!` – wipe the current buffer (i.e., don't have a file in it), but
    don't close the window (the version with `!` ignores any unsaved changes)
* `:Bonly`/`:Bonly!` – close all other buffers except the current one

You may also wish to make some keyboard shortcuts for this, e.g.:

    nmap <Leader>1 <Plug>BuffetSwitch(1)
    nmap <Leader>2 <Plug>BuffetSwitch(2)
    " etc

    noremap <Tab> :bn<CR>
    noremap <S-Tab> :bp<CR>

The sensible mapping shown above are problematic if you press <kbd>Tab</kbd> in
NERDTree, so I use the following hacks:

    nmap <Tab> <Esc>:silent! NERDTreeClose<CR><Esc>:silent! bn<CR><Esc>
    nmap <S-Tab> <Esc>:silent! NERDTreeClose<CR><Esc>:silent! bp<CR><Esc>

Personally I also prefer not to change the UI for the single file, so I set:

    let g:buffet_always_show_tabline = 0

#### Supertab

[Supertab](https://github.com/ervandew/supertab) makes <kbd>Tab</kbd> the only key
needed for autocompletion.

### Integration

The [integration](./pack/integration/start) collection is for plugins that deal
with integrating vim with the operating system and other tools.

#### CtrlP

[ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) is a file finder that maps
to `^P`. It also allows creating files and directories. Once CtrlP is open:

* type to search for files
* use arrows or `^J` and `^K` to navigate the files
* `^F` and `^B` cycle different modes (files, buffers, recently used)
* `^R` use regex mode for searching
* press enter to open the selected file "full screen"
* `^T` to open the selected file in a new tab
* `^X` to open the selected file in a new split (horizontal)
* `^V` to open the selected file in a new split (vertical)
* type the file path and then pres `^Y` to create a new file
* `^Z` mark multiple files
* `^T` or `^O` open all marked files (`^T` opens in tabs)

#### eunuch

[eunuch.vim](https://github.com/tpope/vim-eunuch) adds aliases for various
shell commands to vim.

* `:SudoWrite` – write (save) the current file with `sudo`
* `:SudoEdit` – edit (load) a file with `sudo`
* `:Delete` – deletes the buffer and its corresponding file on disk
* `:Unlink` – deletes the file on disk, but keeps the (empty) buffer open
* `:Rename newname` – renames the current file to `newname` (relative to the
    file's directory)
* `:Move newname` – moves the current file to `newname` (relative to the
    editor's working directory, which is not always the same as the file's
    current location)
* `:Mkdir dir` – create `dir` (relative to the working directory)
* `:Chmod permissions` – change the permissions of the current file
* `:Wall` – write every open window

#### fugitive

[fugitive.vim](https://github.com/tpope/vim-fugitive) adds aliases for various
Git commands. You may also add `%{FugitiveStatusline()}` to your statusline
to see the current branch there.

* `:G` – git status with keyboard commands affecting the file under the
    cursor to directly stage/unstage (`-`) files, discard changes (`X`), diff
    the changes (`=`), etc. (see help with `g?`)
* `:Gblame` – open an interactive `git blame` in a split view (see help with
    `g?`)
* `:Gread` – load the commited version of the file into the current buffer,
    as with `git checkout` but the changes can be undone with `u`
* `:Gedit what` – edit a blob/commit/tag
* `:Gsplit what` / `:Gvsplit what` – as above, but split
* `:Gtabedit what` – as above but in tab
* `:Gdiffsplit` – open a `git diff`, and edit it to stage a subset of changes
* `:Gcommit` – commit, use this editor to edit the commit message
* `:Gmerge branch` / `:Grebase branch` – merge/rebase
* `:Git mergetool` – load merge conflicts into the quickfix list
* `:Git difftool` – load changes into the quickfix list
* `:Gbrowse` – open the current file (or selected visual range) on GitHub's
    website (for github-hosted repositories)
* `:Gpush`, `:Gpull`, `:Gfetch` – push/pull/fetch to/from remote repository
* `y^G` – yank the git path to the current file or object

#### gitgutter

[vim-gitgutter](https://github.com/airblade/vim-gitgutter/) adds a "gutter"
(the sign column) that contains markings for git changes.

#### obsession

[obsession.vim](https://github.com/tpope/vim-obsession) automates saving the
Vim session. You may also add `%{ObsessionStatus()}` to your statusline
to see the session tracking status.

* `:Obsess` – start automatically tracking the current session
* `vim -S Session.vim` (from command line) to restore a saved session

#### tbone

[tbone.vim](https://github.com/tpope/vim-tbone) integrates vim with `tmux`,
including bidirectional access to its copypaste buffer.

* `:Tmux command` – call any `tmux` command (with autocomplete)
* `:Tyank` – yank (copy) to `tmux` buffer
* `:Tput` – put (paste) from `tmux` buffer
* `:Tattach` – attach to a `tmux` session from outside of it

#### NERDTree

[NERDTree](https://github.com/preservim/nerdtree) is a sidebar file explorer.
It can be toggled with `:NERDTreeToggle`, but you probably want to bind it to a
key, e.g., `^N`:

    map <C-n> :NERDTreeToggle<CR>

When in the tree, there are many simple commands:

* `o` – open the file (or expand directory)
* `t` – open the file in a tab
* `T` – open the file in a tab, but don't focus the new tab
* `s` – open the file in a vertical split
* `i` – open the file in a horizontal split
* `go`, `gs`, `gi` – as without `g` but don't focus the new window
* `C` – change the root directory
* `u` – move the root up one directory
* `O` – recursively expand a directory
* `x` – close the current selection's parent directory
* `X` – close all children of a directory
* `p` – jump to the current selection's parent
* `P` – jump to the root node
* `r` / `R` – refresh current directory / all
* `m` – display a menu
* `?` – display inline help

#### NERDTree Git Plugin

[NERDTree Git Plugin](https://github.com/Xuyuanp/nerdtree-git-plugin) adds git
status indicators to NERDTree.

### Obscure

The [obscure](./pack/obscure/start) collection is plugins that (in my opinion)
have rather limited use, but are still interesting.

#### tabular

[Tabular](https://github.com/godlygeek/tabular) formats text by aligning it
in various ways.

* `:Tab /=` – align the `=`s in the selected text
* `:Tab /=/l2` – align the `=` s in the selected text leaving 2 spaces margin
* `:Tab /|/c1` – center text between `|`s in the selected text, leaving 1 space margin
* `:Tab /;/r0` – right-align the `;`s and leave no margin

#### speeddating

[vim-speeddating](https://github.com/tpope/vim-speeddating) extends the `^A`
number increment command to dates.

* `^A` – increments the date under cursor (e.g., 1999-12-31 becomes
   2000-01-01).

## Programming Languages

There are separate sections for plugins for a specific programming language.

### Ruby

#### rvm

[rvm.vim](https://github.com/tpope/vim-rvm) integrates with [rvm](https://rvm.io).

* `:Rvm use version` – Switch ruby version
* `:Rvm` – Hunt for the nearest `.rvmrc` relative to the current file and use
   the version from there

#### bundler

[bundler.vim](https://github.com/tpope/vim-bundler) integrates with
[Bundler](https://bundler.io) and adds functionality to related files
(e.g. `gf` in `Gemfile.lock`).

* `:Bundle command` – Execute `bundler command`

### Lisp

#### sexp

[vim-sexp](https://github.com/guns/vim-sexp) adds various functions and
mappings for "S-expressions", for use in `Lisp`, `Scheme`, `Clojure`, etc.
Unfortunately, some of those mappings are rathe un-vimlike, so there is
a supplementary plugin
[vim-sexp-mappings-for-regular-people](https://github.com/tpope/vim-sexp-mappings-for-regular-people/)
which adds more vim-like mappings.

You may also wish to remove the insert mode mappings by setting the option:

    let g:sexp_enable_insert_mode_mappings = 0

### Settings

My [settings.vim](./pack/arkku/start/settings/plugin/settings.vim) in the
`arkku` group contains some of my personal settings and keybindings that I used
to carry around in `.vimrc`.

#### General Bindings

* `Esc` o close pop-up menus
* `p` in visual mode replaces the selection without yanking (you can use `P`
   if you prefer to yank the replaced text)
* `^_` in insert mode opens a `=` expression prompt, and the results are
   inserted (e.g., `0x20 * 2` inserts `64`)
* `\y` yanks (copies) to the system clipboard (also in insert mode)
* `\p` puts (pastes) from the system clipboard (also in insert mode)
* `:vb` is an abbreviation for `:vert sb`

#### Surround Bindings

These require `surround.vim`.

* `SB` in visual mode to wrap the selection in a block (e.g., `{ }` in C)
* `SE` in visual mode to wrap the selection in exception handling (e.g., `try`
   and `catch`)
* `SF` in visual mode to warp the selection in an `if false { }` block (or its
   equivalent for various languages)

#### TBone Bindings

* `\Y` yanks to the tmux buffer
* `\P` puts from the tmux buffer in normal mode
* `\P` writes the selection to another tmux pane in insert mode (type the
   target pane and press enter, e.g., `:Twrite left` writes to the pane on the
   left side)

#### Other Plugin Bindings

* `^N` in normal mode to open NERDTree
