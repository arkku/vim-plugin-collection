# vim plugins

This repository contains a selection of vim plugins as git submodules.

## Installation

To install, first clone the repository and get the submodules:

``` sh
git clone https://github.com/arkku/vim-plugin-collection.git
cd vim-plugin-collection
git submodule init
git submodule update --init --recursive
```

Then symlink the specific plugin directories in your Vim's `pack` directory:

* **vim**: `~/.vim/pack`
* **neovim**: `~/.local/share/nvim/site/pack`

The directory structure under `pack` must be maintained as it is in this
repository, i.e., `pack/<whatever>/start/<plugin>`. So, to use exactly the
plugins in this repository, you can symlink the entire [pack](./pack), or
select categories under pack (e.g., [pack/programming](./pack/programming)), or
individual plugins by creating your own.

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

* `cs"'` – change surrounding `"` to `'`
* `cs'<q>` – change surrounding `'` to `<q>` and `</q>`
* `cst"` – change surrounding tags to `"`
* `ds"` – remove surrounding "
* `ysiw)` – surround word (`iw`) with `()`
* `ys$]` – surround to end of line with `[]`
* `yst,"` – surround to, but not including, next `,` with `"`

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
* `]b`, `[b` – next/previous buffer
* `]B`, `[B` – first/last buffer
* `]a`, `[a` – next/previous argument
* `]A`, `[A` – first/last argument
* `]n`, `[n` – next/previous conflict/diff marker (try `d[n` inside a conflict)
* `]e` , `[e` – exchange this line with the next/previous line
* `[p`, `]p` – put above/below the current line
* `[os`, `]os` – toggle `spell` option on/off
* `[s`, `]s` – next/previous spelling error
* `]oi`, `[oi` – toggle `ignorecase` option on/off
* `[u` + motion, `]u` + motion – URL encode/decode (`u` for motion targets
  line)
* `[y` + motion, `]y` + motion – string encode/decode (backslash escapes)
* `[x` + motion, `]x` + motion – XML encode/decode

### Programming

The [programming](./pack/programming/start) collection contains plugins that
are for programming in general. Language-specific plugins are in separate
collections to avoid clutter where not needed.

#### commentary

[commentary.vim](https://github.com/tpope/vim-commentary) helps comment out
stuff.

* `gcc` – toggle comment on current line
* `gc` + motion – comment target of motion (e.g., `gcap` for paragraph)
* `gc` in visual mode – comment selection

The `gc` also works as a motion target:

* `dgc` – delete the entire comment
* `gcgc` – uncomment the entire comment

#### endwise

[endwise.vim](https://github.com/tpope/vim-endwise) automatically inserts `end`
in various programming languages (such as Ruby and shell script). It errs on
the side of caution, and I have never seen it insert when it shouldn't.

#### radical

[radical.vim](https://github.com/glts/vim-radical) helps convert between
different integer representations, i.e., decimal, hexadecimal and binary.

* `gA` – shows the integer under the cursor in each supported base
* `crx` – converts an integer to hexadecimal (base 16)
* `crd` – converts an integer to decimal (base 10)
* `crb` – converts an integer to decimal (base 2)

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

``` vim
nmap <Leader>1 <Plug>BuffetSwitch(1)
nmap <Leader>2 <Plug>BuffetSwitch(2)
" etc

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
```

The sensible mapping shown above are problematic if you press <kbd>Tab</kbd> in
NERDTree, so I use the following hacks:

``` vim
nmap <Tab> <Esc>:silent! NERDTreeClose<CR><Esc>:silent! bn<CR><Esc>
nmap <S-Tab> <Esc>:silent! NERDTreeClose<CR><Esc>:silent! bp<CR><Esc>
```

Personally I also prefer not to change the UI for the single file, so I set:

``` vim
let g:buffet_always_show_tabline = 0
```

#### Supertab

[Supertab](https://github.com/ervandew/supertab) makes <kbd>Tab</kbd> the only key
needed for autocompletion.

### Integration

The [integration](./pack/integration/start) collection is for plugins that deal
with integrating vim with the operating system and other tools.

#### CtrlP

[ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) is a file finder that maps
to <kbd>Ctrl</kbd>–<kbd>P</kbd>. It also allows creating files and
directories. Once CtrlP is open:

* type to search for files
* arrows or <kbd>Ctrl</kbd>–<kbd>J</kbd> and <kbd>Ctrl</kbd>–<kbd>K</kbd>
  – navigate
* <kbd>Ctrl</kbd>–<kbd>F</kbd>, <kbd>Ctrl</kbd>–<kbd>B</kbd> – cycle different
  modes (files, buffers, recently used)
* <kbd>Ctrl</kbd>–<kbd>C</kbd> – close the search
* <kbd>Ctrl</kbd>–<kbd>R</kbd> – use regex mode for searching
* <kbd>Return</kbd> – open the selected file "full screen"
* <kbd>Ctrl</kbd>–<kbd>T</kbd> – to open the selected file in a new tab
* <kbd>Ctrl</kbd>–<kbd>X</kbd> – to open the selected file in a new split
  (horizontal)
* <kbd>Ctrl</kbd>–<kbd>V</kbd> – to open the selected file in a new split
  (vertical)
* <kbd>Ctrl</kbd>–<kbd>Z</kbd> mark multiple files
* <kbd>Ctrl</kbd>–<kbd>O</kbd> or <kbd>Ctrl</kbd>–<kbd>T</kbd> – open all
  marked files (<kbd>Ctrl</kbd>–<kbd>T</kbd> opens in tabs)
* type the file path and then pres <kbd>Ctrl</kbd>–<kbd>Y</kbd> to create a new
  file

If you have [ag](https://github.com/ggreer/the_silver_searcher) installed, you
can configure CtrlP to use it:

``` vim
let g:ctrlp_user_command = 'ag %s -l --nocolor --depth 5 -g ""'
let g:ctrlp_use_caching = 0
```

#### CtrlPFunky

[CtrlPFunky](https://github.com/tacahiroy/ctrlp-funky) extends CtrlP by
offering a very simple function search without tagfiles for many programming
languages. This also works for headings in markdown!

Set it up by binding it somewhere, e.g.:

``` vim
nnoremap <Leader>u :CtrlPFunky<CR>
" narrow the list down with a word under cursor
nnoremap <Leader>U :execute 'CtrlPFunky ' . expand('<cword>')<CR>
```

If these mappings are free, they are also set by my settings plugin (category
`arkku` in this same repository).

The [ctrlp-funky-liquid](./pack/start/integration/ctrlp-funky-liquid) is
a local extension, which adds support for the filetype `liquid` by calling the
Markdown or HTML functions according to the subtype.

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

* `:G` – git status with keyboard commands affecting the file under the cursor
  to directly stage/unstage (`-`) files, discard changes (`X`), diff the
  changes (`=`), etc. (see help with `g?`)
* `:Gblame` – open an interactive `git blame` in a split view (see help with
  `g?`)
* `:Gread` – load the committed version of the file into the current buffer, as
  with `git checkout` but the changes can be undone with `u`
* `:Gedit what` – edit a blob/commit/tag
* `:Gsplit what` / `:Gvsplit what` – as above, but split
* `:Gtabedit what` – as above but in tab
* `:Gdiffsplit` – open a `git diff`, and edit it to stage a subset of changes
* `:Gcommit` – commit, use this editor to edit the commit message
* `:Gmerge branch` / `:Grebase branch` – merge/rebase
* `:Git mergetool` – load merge conflicts into the quickfix list
* `:Git difftool` – load changes into the quickfix list
* `:Gbrowse` – open the current file (or selected visual range) on GitHub
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
key, e.g., <kbd>Ctrl</kbd>–<kbd>N</kbd>:

``` vim
map <C-N> :NERDTreeToggle<CR>
```

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
* `?` – display in-line help

#### NERDTree Git Plugin

[NERDTree Git Plugin](https://github.com/Xuyuanp/nerdtree-git-plugin) adds git
status indicators to NERDTree.

### notgrep

The [notgrep](./pack/notgrep/start) collection contains plugins that interface
with the various smarter `grep` replacements, such as Ag and FZF.

#### ack

[ack.vim](https://github.com/mileszs/ack.vim) works just fine with Ag, despite
its name. In fact, if you have Ag installed, my settings plugin in this
repository configures it automatically. To set it up manually, set:

``` vim
let g:ackprg = 'ag --vimgrep'
```

The script is used from the command-line with these functions:

* `:Ack ` + query – search and jump automatically to the first result
* `:Ack! ` + query – search without jumping automatically to the first result

(My settings plugin binds the latter to `\a`.)

### Obscure

The [obscure](./pack/obscure/start) collection contains plugins that (in my
opinion) have rather limited use, but are still interesting.

#### tabular

[Tabular](https://github.com/godlygeek/tabular) formats text by aligning it
in various ways.

* `:Tab /=` – align the `=`s in the selected text
* `:Tab /=/l2` – align the `=` s in the selected text leaving 2 spaces margin
* `:Tab /|/c1` – center text between `|`s in the selected text, leaving 1 space margin
* `:Tab /;/r0` – right-align the `;`s and leave no margin

#### speeddating

[vim-speeddating](https://github.com/tpope/vim-speeddating) extends the
<kbd>Ctrl</kbd>–<kbd>A</kbd> number increment command to dates.

* <kbd>Ctrl</kbd>–<kbd>A</kbd> – increments the date under cursor (e.g.,
  1999-12-31 becomes 2000-01-01).

## Programming Languages

There are separate sections for plugins for a specific programming language.

### Ruby

#### rvm

[rvm.vim](https://github.com/tpope/vim-rvm) integrates with [rvm](https://rvm.io).

* `:Rvm use version` – switch ruby version
* `:Rvm` – hunt for the nearest `.rvmrc` relative to the current file and use
   the version from there

#### bundler

[bundler.vim](https://github.com/tpope/vim-bundler) integrates with
[Bundler](https://bundler.io) and adds functionality to related files
(e.g. `gf` in `Gemfile.lock`).

* `:Bundle command` – execute `bundler command`

### Web

Web-related thing are in the their own section.

#### Markdown

Vim already ships with Markdown support, but [plasticboy's
vim-markdown](https://github.com/plasticboy/vim-markdown) has some additional
features. It depends on the [Tabular](https://github.com/godlygeek/tabular),
which is included in the "obscure" category. Remember to symlink it
individually if you are not using that category.

Note that currently the default settings for lists are just plain wrong and
trying to word-wrap them breaks the lists. It can be fixed by adding these
lines to your configuration (and yes, that is hideous with the double-escaped
regular expression, but apparently no markdown plugin for vim has working list
and comment patterns so we need to patch it):

``` vim
let g:vim_markdown_auto_insert_bullets=0
let g:vim_markdown_new_list_item_indent=0
au FileType markdown setlocal formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[*+~-]\\s\\+\\\|^\\(\\\|[*#]\\)\\[^[^\\]]\\+\\]:\\s | setlocal comments=n:> | setlocal formatoptions+=cn
```

This will allow formatting (e.g., `gqap`) to work on lists and blockquotes, and
despite the `new_list_item_indent` being zero, successive lines of multi-line
lists will be indented correctly. You will lose auto-insertion of bullet
points, but that is a minor inconvenience. (However, since these are somewhat
invasive changes and there are alternative `vim-markdown` plugins, I am _not_
setting these options in my settings plugin.)

Some other options you may wish to enable:

``` vim
" Allow YAML frontmatter (e.g., Jekyll)
let g:vim_markdown_frontmatter=1

" Enable ~~ strikethrough
let g:vim_markdown_strikethrough=1

" Allow LaTeX match with $ and $$
let g:vim_markdown_math=1

" Allow links to markdown files work without extensions
let g:vim_markdown_no_extensions_in_markdown=1

" Use HTML comments rather than blockquote
au FileType markdown setlocal commentstring=<!--%s-->
```

To enable syntax highlighting in fenced code blocks, specify them in the list
`g:markdown_fenced_languages`:

``` vim
let g:markdown_fenced_languages = [ 'c', 'bash=sh', 'ruby' ]
```

Note that specifying a language you don't have support for gives an error, so
if you recycle the same configuration in mixed evironments, you should check
first:

``` vim
let g:markdown_fenced_languages = []

for pl in [ 'sh', 'c', 'ruby', 'swift', 'javascript', 'json' ]
    if index(getcompletion(pl, 'filetype'), pl) >= 0
        call add(g:markdown_fenced_languages, pl)
    endif
endfor
```

#### Liquid

[vim-liquid](https://github.com/tpope/vim-liquid) adds support for Liquid
(e.g., in Jekyll). Note that currently syntax highlighting for other languages
in Liquid Markdown files doesn't work. However, you can just `set ft=markdown`
to toggle it on the fly when needed.

Also, you may need to unbreak formatting of lists the same way as for
`vim-markdown` (see above), but this time the filetype is `liquid` and you need
to check for the subtype in `b:liquid_subtype`:

``` vim
au FileType liquid if exists('b:liquid_subtype') && b:liquid_subtype == 'markdown' | setlocal formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[*+~-]\\s\\+\\\|^\\(\\\|[*#]\\)\\[^[^\\]]\\+\\]:\\s | setlocal comments=n:> | setlocal formatoptions+=cn | endif
```

Personally I also set the comment string to use Liquid, rather than HTML,
comments:

``` vim
au FileType liquid setlocal commentstring={%\ comment\ %}%s{%\ endcomment\ %}
```

### Swift

[swift.vim](https://github.com/keith/swift.vim) adds Swift file type detection
and syntax highlighting support. Note that this is _not_ the version from the
[official Swift repository](https://github.com/apple/swift/tree/master/utils/vim),
since that ironically doesn't seem to be as up-to-date and also sets
indentation to 2 spaces, which is not only unnecessarily intrusive, but also
contradictory to the Swift Programming Language book and XCode default
settings.

### Lisp

#### sexp

[vim-sexp](https://github.com/guns/vim-sexp) adds various functions and
mappings for "S-expressions", for use in `Lisp`, `Scheme`, `Clojure`, etc.
Unfortunately, some of those mappings are rather un-vimlike, so there is
a supplementary plugin
[vim-sexp-mappings-for-regular-people](https://github.com/tpope/vim-sexp-mappings-for-regular-people/)
which adds more vim-like mappings.

You may also wish to remove the insert mode mappings by setting the option:

``` vim
let g:sexp_enable_insert_mode_mappings = 0
```

### Settings

My [settings.vim](./pack/arkku/start/settings/plugin/settings.vim) in the
`arkku` group contains some of my personal settings and bindings for the
included plugins.

#### General Bindings

* `\y` – yanks (copies) to the system clipboard (also in insert mode)
* `\p` – puts (pastes) from the system clipboard (also in insert mode)

#### TBone Bindings

* `\Y` – yanks to the tmux buffer
* `\P` – puts from the tmux buffer in normal mode
* `\P` – writes the selection to another tmux pane in insert mode (type the
  target pane and press enter, e.g., `:Twrite left` – writes to the pane on the
  left side)

#### Surround Bindings

These require `surround.vim`.

* `SB` – in visual mode, wrap the selection in a block (e.g., `{ }` in C)
* `SE` – in visual mode, wrap the selection in exception handling (e.g., `try`
  and `catch`)
* `SF` – in visual mode, warp the selection in an `if false { }` block (or its
  equivalent for various languages)

#### Other Plugin Bindings

* <kbd>Ctrl</kbd>–<kbd>N</kbd> – in normal mode opens NERDTree
* `\a` – ag search (with Ack plugin) but don't autojump to first match
* `\A` – start ag search with the word under cursor
* `\u` – start CtrlPFunky search for functions or markdown headings
* `\U` – start CtrlPFunky search with the word under the cursor

