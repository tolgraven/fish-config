function ctags_gen
ctags -R -f .tags . >&- ^&-
end
