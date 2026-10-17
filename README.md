# mnu

mnu is a small keyboard-driven menu for X11, based on dmenu 5.2.
It reads newline-separated items from standard input and prints the selected
item to standard output.

Matched text highlighting, high priority items, and password input are built
into the source. No patches need to be applied.

## Requirements

- A C99 compiler and make
- X11 headers and libraries
- Xft, Fontconfig, and FreeType headers and libraries
- Xinerama headers and libraries, unless disabled in config.mk

An X server is required at runtime. On Wayland, this is an X11 application
and requires XWayland.

## Build and install

Edit config.mk to adjust library paths, Xinerama support, or the installation
prefix. The default prefix is /usr/local.

```sh
make
sudo make install
```

For installation under your home directory:

```sh
make install PREFIX="$HOME/.local"
```

To remove an installation, run make uninstall with the same prefix and
permissions used for installation. Run make dist to create a source archive.

## Configuration

Edit config.h to set the default font, colors, menu position, and number of
visible lines. Run make after changing it.

Highlight foreground colors are configured separately for normal, selected,
and previously output items. Highlight backgrounds follow the item's current
background, including colors supplied with -nb, -sb, and -hb. High priority
items use the normal highlight foreground.

## Usage

```sh
printf '%s\n' Firefox Terminal Files | mnu -i -l 10 -p 'Open:'
printf '%s\n' Firefox Chromium | mnu -hp Firefox -hb '#333333'
mnu -p 'Task:' </dev/null
mnu -P -p 'Password:'
```

- Enter prints the selected item, or the input when there is no selection.
- Shift-Enter prints the input directly.
- Ctrl-Enter prints the selection and keeps the menu open.
- Escape cancels with exit status 1.
- Tab copies the selected item into the input field.
- Ctrl-Y pastes the primary selection. Ctrl-Shift-Y or Alt-V pastes the clipboard.

Matching requires every space-separated input token to occur in an item.
Exact matches are listed first, followed by high priority prefixes, other
prefixes, and substring matches. Use -i for case-insensitive matching.

The -hp option accepts comma-separated complete item names. It preserves input
order when the search is empty and cannot represent names containing commas.
Use -hf and -hb to change high priority foreground and background colors.

Password mode ignores standard input and displays one dot per UTF-8 code point.
The accepted password is printed to standard output.

Use -l 0 for a horizontal menu or -l with a positive number for a vertical list.
Monitor numbers for -m start at zero. The default, -1, selects automatically.
Invalid numeric arguments are rejected.

The included mnu_run script launches shell commands. mnu_path lists
executables from PATH and caches the result. stest filters file lists.
See man mnu and man stest for more options and keyboard shortcuts.

## Credits and license

Based on [suckless dmenu](https://tools.suckless.org/dmenu/).
Integrated additions:

- Matched text highlighting by Nathaniel Evan
- High priority items from the suckless highpriority patch
- Password input by Mehrad Mahmoudian

See LICENSE for the upstream MIT/X Consortium license.
