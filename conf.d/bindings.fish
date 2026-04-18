# Option-up / super-up: history token search backward
bind \e\[1\;5A history-token-search-backward
bind \e\[1\;2A history-token-search-backward

# Option-down / super-down: history token search forward
bind \e\[1\;5B history-token-search-forward
bind \e\[1\;2B history-token-search-forward

# C-t: transpose characters
bind \ct transpose-chars

# C-s: accept autosuggestion and submit
bind \cs accept-autosuggestion execute
