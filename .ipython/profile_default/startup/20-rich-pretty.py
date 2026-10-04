# color the repr of expression results (dicts, lists, etc.) using rich.
# skipped silently in environments without rich (e.g. poetry projects).
#
# rich styles every string as "repr.str", so dict keys and string values look
# the same. the highlighter below adds a "repr.key" style for quoted strings
# followed by ": " (dict keys); change its color in the theme.
try:
    import rich
    import rich.pretty
    from rich.highlighter import ReprHighlighter
    from rich.theme import Theme
except ImportError:
    pass
else:
    class _KeyReprHighlighter(ReprHighlighter):
        highlights = ReprHighlighter.highlights + [
            r"(?P<key>'[^'\n]*'|\"[^\"\n]*\")(?=: )",
        ]

    # Pretty() builds its highlighter from this module-level name
    rich.pretty.ReprHighlighter = _KeyReprHighlighter
    rich.get_console().push_theme(Theme({
        "repr.key": "white",  # embark yellow (#FFE6B3)
        # not italic: tmux renders italics as green, which would override the color
        "repr.bool_true": "green",  # embark purple (#D4BFFF)
        "repr.bool_false": "green",
        "repr.none": "magenta",
        "repr.str": "red",  # embark red (#F48FB1), same as strings in vim
        "repr.number": "green",  # embark green (#A1EFD3); covers ints and floats
    }))
    rich.pretty.install()

    del _KeyReprHighlighter
