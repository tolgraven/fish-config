function tol_history_search_bindings
bind -k up 'tol_up-or-search 7'
bind -k down 'tol_down-or-search 7'
bind \cP 'tol_up-or-search 7'
bind \e\[A 'tol_up-or-search 7'
bind \e\[B 'tol_down-or-search 7'
bind \cN 'tol_down-or-search 7'

bind \e+ history-token-search-backward
bind \e, history-search-backward
bind \e\; history-search-forward
bind \eJ history-search-forward
bind \eK history-search-backward
end
