# Apply a catppuccin theme on every shell start by parsing the plugin's
# .theme file directly. Workaround for fish_config theme choose not
# persisting in fish 4.6. Change THEME / SECTION to swap palette.
set -l theme catppuccin-mocha
set -l section dark
set -l file ~/.config/fish/themes/$theme.theme

test -f $file; or return

set -l active 0
while read -l line
    if set -l hdr (string match -r '^\[(.+)\]$' -- $line)
        test "$hdr[2]" = $section; and set active 1; or set active 0
        continue
    end
    test $active -eq 1; or continue
    string match -qr '^\s*(#|$)' -- $line; and continue
    set -l parts (string split -n ' ' -- $line)
    test (count $parts) -ge 2; or continue
    set -g $parts[1] $parts[2..]
end < $file
