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
`ga` include additional info about Unicode characters.

* `ga` – show info about the character under the cursor

#### unimpaired

[unimpaired](https://github.com/tpope/vim-unimpaired) unimpaired is collection
of paired keyboard mappings, typically navigation in two directions, but also
settings on/off, edit operations up/down, etc. The complete set of actions is
long, so I will not duplicate it here, but here are some highlights:

* `]l`, `[l` – next/previous location
* `[L`, `]L` – first/last location
* `]q`, `[q` – next/previous quickfix error
* `[Q`, `]Q` – first/last quickfix
* `]t`, `[t` – next/previous tag
* `[T`, `]T` – first/last tag
* `]b`, `[b` – next/previous buffer
* `[B`, `]B` – first/last buffer
* `]a`, `[a` – next/previous argument
* `[A`, `]A` – first/last argument
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

#### yoink


[yoink.vim](https://github.com/svermeulen/vim-yoink) enables a yank history
that can be cycled through when pasting. By default it doesn't do change
anything since it has no bindings. The way I have it set up looks a bit
complicated, but it gives no errors even if the plugin isn't installed (so
I can use the same configuration for an installation without plugins):

``` vim
let g:yoinkSwapClampAtEnds=0
let g:yoinkSyncSystemClipboardOnFocus=0

nnoremap <Plug>(YoinkPaste_p) p
nnoremap <Plug>(YoinkPaste_P) P
nnoremap <Plug>(YoinkPostPasteSwapBack) j
nnoremap <Plug>(YoinkPostPasteSwapForward) k
nmap p <Plug>(YoinkPaste_p)
nmap P <Plug>(YoinkPaste_P)
nmap <C-J> <Plug>(YoinkPostPasteSwapBack)
nmap <C-K> <Plug>(YoinkPostPasteSwapForward)
```

The mappings are as follows:

* <kbd>Ctrl</kbd>–<kbd>J</kbd> – after put (`p`), rotate to the next oldest
  yank in history, looping around at the end
* <kbd>Ctrl</kbd>–<kbd>K</kbd> – after put (`p`), rotate to the next newest
  yank in history, looping around at the end

If you additionally wish to make yank (`y`) preserve the cursor position,
unlike the Vim default, add the following:

``` vim
nnoremap <Plug>(YoinkYankPreserveCursorPosition) y
xnoremap <Plug>(YoinkYankPreserveCursorPosition) y
nmap y <Plug>(YoinkYankPreserveCursorPosition)
xmap y <Plug>(YoinkYankPreserveCursorPosition)
```

On Neovim (only), you may also wish to preserve the yank history
persistently. In that case, set:

``` vim
let g:yoinkSavePersistently=1
silent! set shada=!,'100,<50,s10,h
```

The `shada` setting has to include `!` for this to work. Note that you can also
use this feature to duplicate yanks between multiple different instances of
`nvim`, by issuing `:wshada` on the "sending" and `:rshada` on the "receiving"
editor.

### Tags

The [tags](./pack/tags/start) collection contains plugins for creating and
managing Vim tags. Since these typically involve creating a tagfile (by default
called `tags`), this category may be considered intrusive without additional
configuration. Personally, I prefer to use the name `.tags` to make it hidden,
and some people put theirs in `.git/tags` to automatically have Git ignore it
(but I find not all tools like that solution). This configuration covers both:

``` vim
set tags^=./.git/tags;
set tags^=./.tags;
set tags^=.tags
```

Also, I prefer to use a global gitignore file so I can freely create the tags
for repositories I don't own. First, this is in `~/.gitconfig`:

``` git
[core]
	excludesfile = ~/.gitignore_global
```

And then, in `~/.gitignore_global`:

```
/.tags
/doc/tags
```

The above also ignores the documentation tags generated by Vim `:helptags ALL`.

#### Gutentags

[Gutentags](https://github.com/ludovicchabant/vim-gutentags) manages the
creation and updating of tags for you automatically when you are inside
a "project", e.g., a Git repository. **Note:** This means that you will end up
with `tags` files scattered all around your hard drive, so do not install this
without configuring it to your liking!

To configure the default tag file name, I suggest:

``` vim
let g:gutentags_ctags_tagfile='.tags'
```

To avoid creating a new tag file on load even if one doesn't exist for the
project, also set:

``` vim
let g:gutentags_generate_on_missing=0
let g:gutentags_generate_on_new=0
```

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

#### Syntastic

[Syntastic](https://github.com/vim-syntastic/syntastic) integrates Vim with
various syntax checkers which populate the location list. It doesn't do any
syntax checking by itself, so you need to separately install and configure the
checkers you want. See `:help syntastic`.

To set up a checker, see either `:help syntastic-checkers` or
`:help syntastic-checkers-<lang>` for the list of supported checkers, install
the checker(s) you want along `$PATH`, and then enable them in your
configuration by setting the list `g:syntastic_<lang>_checkers`. For example:

``` vim
let g:syntastic_swift_checkers = [ 'swiftlint', 'swiftpm' ]
```

You can check for errors by running `:SyntasticCheck`. The location list may
not be set unless you configure it (see below), or run `:Errors`, or manually
call `:SyntasticSetLocList`. The command `:SyntasticToggleMode` toggles between
active (check on write) and passive (only check when specifically asked). You
may set the default for different languages by configuring
`g:syntastic_mode_map`:

``` vim
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["ruby","c"],
    \ "passive_filetypes": ["swift"] }
```


Some more configurable options:

``` vim
" Always populate the location list?
let g:syntastic_always_populate_loc_list = 1

" Automatically open the list?
let g:syntastic_auto_loc_list = 0

" Mark errors in the sign column?
let g:syntastic_enable_signs = 1

" Check when opening a file? (May slow down opening quite a bit!)
let g:syntastic_check_on_open = 0

" Check on writequit?
let g:syntastic_check_on_wq = 0
```

If you wish to view the Syntastic status (i.e., presence of errors) on the
statusline, you can configure it with something like this:

``` vim
function! SyntasticStatuslineIfPresent()
    if exists('g:loaded_syntastic_plugin')
        let synstatus = SyntasticStatuslineFlag()
        if !empty(synstatus)
            return ' ' . synstatus . ' '
        endif
    endif
    return ''
endfunction

set statusline+=%{SyntasticStatuslineIfPresent()}
```

#### endwise

[endwise.vim](https://github.com/tpope/vim-endwise) automatically inserts `end`
in various programming languages (such as Ruby and shell script). It errs on
the side of caution, and I have never seen it insert when it shouldn't.

#### closer

[closer.vim](https://github.com/rstacruz/vim-closer) is like `endwise`, but for
brackets `{([` rather than words. That is, it closes any open `{([` but only
when you press return, which makes it less invasive than most other
auto-pairing plugins. Unfortunately it is a overly cautious in some cases and
fails to close after `} else {`, but at the same time it also doesn't
understand strings and incorrectly closes `printf("%s {",` with `}`. Still,
I couldn't find a better non-invasive plugin for this, and the false positive
is a very rare corner case. (The false negative with `} else {` is very common,
but then again it's no worse than not having a plugin at all.)

Note that if you have an expression mapped to `<CR>` in insert mode, it will
break when this is loaded. This is the fix I use to combine an expression with
both `closer` and `endwise`:

``` vim
" Accept autocompletion on return (and do not insert newline),
" otherwise use endwise and/or closer. C-X CR for unconditional newline.
let g:endwise_no_mappings=1
imap <silent><expr> <Plug>CloserClose ""
imap <silent><expr> <Plug>DiscretionaryEnd ""
imap <silent><expr> <Plug>AlwaysEnd ""
imap <C-X><CR> <CR><Plug>AlwaysEnd
imap <silent><expr> <CR> (pumvisible() ? "\<C-Y>" : "\<CR>\<Plug>DiscretionaryEnd\<Plug>CloserClose")
```

To map `closer` to additional file types, use autocommands:

``` vim
au FileType swift let b:closer = 1 | let b:closer_flags = '([{'
```

#### apathy

[apathy.vim](https://github.com/tpope/vim-apathy) sets the include paths for
a number of different programming languages. These are some of the standard
commands that will benefit when paths have been set correctly:

* `gf` – jump to the include file for the word under cursor
* `:sfind file.h` – open a split with `file.h`
* `:ilist string` – search for `string` in include files
* `[i` – show first match for word under cursor in include files
* `[I` – show all matches for word under cursor in include files

#### radical

[radical.vim](https://github.com/glts/vim-radical) helps convert between
different integer representations, i.e., decimal, hexadecimal and binary.

* `gA` – shows the integer under the cursor in each supported base
* `crx` – converts an integer to hexadecimal (base 16)
* `crd` – converts an integer to decimal (base 10)
* `crb` – converts an integer to decimal (base 2)

You can prevent these mappings with:

``` vim
let g:radical_no_mappings=1
```

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
" etc.

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
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
* <kbd>Ctrl</kbd>–<kbd>R</kbd> – use regexp mode for searching
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

If you have [fd](https://github.com/sharkdp/fd) installed, you can configure
CtrlP to use it:

``` vim
let g:ctrlp_user_command='fd -c never -d 5 -- . %s 2>/dev/null'
let g:ctrlp_use_caching=0
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
including bidirectional access to its copy-paste buffer.

* `:Tmux command` – call any `tmux` command (with autocomplete)
* `:Tyank` – yank (copy) to `tmux` buffer
* `:Tput` – put (paste) from `tmux` buffer
* `:Tattach` – attach to a `tmux` session from outside of it

#### vinegar

[vinegar.vim](https://github.com/tpope/vim-vinegar) enhances the built-in file
explorer. I eventually decided to discard the more heavy and intrusive
[NERDTree](https://github.com/preservim/nerdtree) in favour of this and CtrlP.

In any file:

* `-` – (yes, just a single hyphen) _in any file_ switch to the file explorer
  in the current file's directory (or go up a directory if you are in the
  file explorer)

In the file explorer:

* <kbd>Ctrl</kbd>-<kbd>6</kbd> (`C-^`) – switch back to the file you were in
* `~` – go to the home directory
* `gh` – toggle hiding of dotfiles

Actions on files currently at the cursor:

* `y.` – yank the absolute path to the file
* `.` – put the file's path at the end of a `:` command-line, e.g., `.grep foo`
  will search for `foo` in the file
* `!` – put the file's path at the end of a `!` command-line, e.g., `!chmod +x`
  (recall that `!` executes shell commands)

Some settings you may wish to use to make it fancier:

```
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_preview=1
let g:netrw_winsize=25
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_special_syntax=1
```

#### notgrep

The [notgrep](./pack/notgrep/start) collection contains plugins that interface
with the various smarter `grep` replacements, such as Ag and FZF.

#### ack

[ack.vim](https://github.com/mileszs/ack.vim) works just fine with ripgrep or
the silver searcher (ag), despite its name. In fact, if you have either
installed, my settings plugin in this repository configures it automatically.
To set it up manually, set:

``` vim
let g:ackprg = 'rg --vimgrep --no-heading'
" or
let g:ackprg = 'ag --vimgrep'
```

The script is used from the command-line with these functions:

* `:Ack ` + query – search and jump automatically to the first result
* `:Ack! ` + query – search without jumping automatically to the first result

(My settings plugin binds the latter to `\a`.)

#### fzf

[fzf.vim](https://github.com/junegunn/fzf.vim) adds a bunch of helper functions
for use with [fzf](https://github.com/junegunn/fzf). Note that fzf itself ships
with a basic vim plugin, which is required and _not included_ here. If you
install fzf via your system's plugin manager (or manually), find the path to
the `fzf.vim` file (the one included with fzf, not the one here) and source it
in your configuration file. Or do something more elaborate to try to find it:


``` vim
if executable('fzf')
    " Add fzf if installed
    if !empty(glob(expand("~/.fzf")))
        set runtimepath+=~/.fzf
    elseif !empty(glob("/usr/local/opt/fzf"))
        set runtimepath+=/usr/local/opt/fzf
    elseif !empty(glob("/usr/share/doc/fzf/examples/plugin/fzf.vim"))
        set runtimepath+=/usr/share/doc/fzf/examples
    endif
    runtime! plugin/fzf.vim
endif
```

Anyway, after you have two different `fzf.vim`s both, and fzf itself,
installed, you can use these commands to fuzzily search for various things:

* `:FZF` – files
* `:History` – previously opened files
* `:GFiles` – git files
* `:GFiles?` – git files listed in `git status`
* `:Buffers` – open buffers
* `:Rg` – ripgrep search results
* `:Ag` – `ag` search results
* `:Lines` – lines in loaded buffers
* `:BLines` – lines in this buffer
* `:Tags` – tags in the project
* `:BTags` – tags in this buffer
* `:Marks` – marks
* `:History:` – command history
* `:History/` – search history
* `:Commits` – git commits (requires `fugitive`, which is included as part of
  this plugin collection)
* `:Helptags` – help tags

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

#### abolish

[abolish.vim](https://github.com/tpope/vim-abolish) is a collection of three
plugins, each dealing with different ways to change words.

The first, with the titular command, is basically just shorthand for generating
vim abbreviations (`:iabbrev`) for variants (e.g., plural, different cases,
etc.)… I don't use this part myself.

##### subvert

The second is a substitution (search/replace) tool that preserves case, and
allows you to define the plural and singular forms.

At the most basic, the case-preserving functionality alone is useful, e.g., the
command `:%Subvert/red/blue/g` would change "red, RED, Reddit" into "blue,
BLUE, Bluedit". And yes, the last is probably not what you wanted, so watch
out for substrings.

For the plural forms, use `{singular,plural}` anywhere in the strings to define
the differences, e.g., `:%Subvert/child{,ren}/young {person,people}/g` would
change "Children, or a child." into "Young people, or a young person." Likewise
`:%Subvert/rat{,s}/cat{,s}/g` and `:%Subvert/dog{,s}/wol{f,ves}/g` work as
expected.

As a (possibly unintended) additional feature, this can also be used to swap
two strings in one operation, e.g., `:%Subvert/{foo,bar}/{bar,foo}/g` will turn
each "foo" into a "bar", and each "bar" into a "foo".

##### coercion

The third plugin is perhaps the most interesting one for programmers: shortcuts
to "coerce" words between `snake_case`, `camelCase`, `MixedCase`, `dash-case`,
`UPPER_CASE`, and `space case`. The bindings are:

* `crs` – to `snake_case`
* `crc` – to `camelCase`
* `crm` – to `MixedCase`
* `cru` – to `UPPER_CASE`
* `cr-` – to `dash-case` (not reversible)
* `cr` + <kbd>Space</kbd> – to `space case` (not reversible)

Note that while the first your can be repeatedly changed to one another, the
last two (`dash-case` and `space case`) are not longer changeable to one of the
others with these bindings, since the word boundaries change.

If these mappings interfere with something else, you can disable them with:

``` vim
let g:abolish_no_mappings=1
```

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

* <kbd>Tab</kbd> / <kbd>Shift</kbd>–<kbd>Tab</kbd> – if there are multiple
  windows, cycle between them (<kbd>Shift</kbd> alters the direction),
  otherwise cycle between buffers
* <kbd>Ctrl</kbd>–<kbd>K</kbd> – does the original <kbd>Tab</kbd> function of
  jumping to the newer cursor (Kursor?) location (mnemonic: OK,
  <kbd>Ctrl</kbd>–<kbd>O</kbd> is the opposite direction)
* <kbd>Ctrl</kbd>–<kbd>N</kbd> – in normal mode toggles file explorer in
  a split view (use `netrw` settings to change how it looks and what size it
  opens at; see under `vinegar` above)
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

* `\a` – search with Ack plugin but don't autojump to first match
* `\A` – search with Ack plugin for the word under cursor
* `\u` – start CtrlPFunky search for functions or markdown headings
* `\U` – start CtrlPFunky search with the word under the cursor

The Ack plugin is configured to use ripgrep (`rg`) if installed, or otherwise
the silver searcher (`ag`) if installed.

The CtrlP plugin is configured to use `fd` if installed (and
`g:ctrlp_user_command` is not set).

