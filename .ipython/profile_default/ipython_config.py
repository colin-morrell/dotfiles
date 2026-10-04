import IPython

# change traceback highlighting from unreadable yellow to red (embark red)
TB_HIGHLIGHT = 'bg:#F48FB1'
try:
    # ipython 9+: the highlight is part of each color theme
    from IPython.utils.PyColorize import theme_table
    from pygments.token import Token
except ImportError:
    # ipython 8: class attribute, renamed with a leading underscore in later 8.x
    from IPython.core.ultratb import VerboseTB
    VerboseTB.tb_highlight = VerboseTB._tb_highlight = TB_HIGHLIGHT
else:
    for name, theme in theme_table.items():
        if name != 'nocolor':
            theme.extra_style[Token.TbHighlight] = 'ansiblack ' + TB_HIGHLIGHT

# autoreload
c.InteractiveShellApp.exec_lines = []
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
c.InteractiveShellApp.exec_lines.append('%autoreload 2')

c.InteractiveShell.banner1 = rf'''

     _             _   _
    (_)_ __  _   _| |_| |__   ___  _ __
    | | '_ \| | | | __| '_ \ / _ \| '_ \
    | | |_) | |_| | |_| | | | (_) | | | |
    |_| .__/ \__, |\__|_| |_|\___/|_| |_|
      |_|    |___/          v{IPython.__version__}

               /^\/^\
             _|__|  O|
    \/     /~     \_/ \
     \____|__________/  \
            \_______      \
                    `\     \                 \
                      |     |                  \
                     /      /                    \
                    /     /                       \\
                  /      /                         \ \
                 /     /                            \  \
               /     /             _----_            \   \
              /     /           _-~      ~-_         |   |
             (      (        _-~    _--_    ~-_     _/   |
              \      ~-____-~    _-~    ~-_    ~-_-~    /
                ~-_           _-~          ~-_       _-~
                   ~--______-~                ~-___-~

'''
