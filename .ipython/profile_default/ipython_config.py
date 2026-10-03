import IPython
from IPython.core.ultratb import VerboseTB

# change traceback highlighting from unreadable yellow to red
VerboseTB.tb_highlight = 'bg:#F48FB1'

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
