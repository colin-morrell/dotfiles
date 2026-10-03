import logging
import sys
from pathlib import Path

# only enable debug logging when ipython is launched from ~/3dp/3dpy (or below)
if Path.cwd().is_relative_to(Path.home() / "3dp" / "3dpy"):
    class ColorFormatter(logging.Formatter):
        COLORS = {
            logging.DEBUG: "\033[32m",    # green
            logging.INFO: "\033[90m",     # gray
            logging.WARNING: "\033[31m",  # red
            logging.ERROR: "\033[31;1m",  # bright red
            logging.CRITICAL: "\033[41;97m",  # white on red
        }
        SHORT_NAMES = {
            logging.WARNING: "WARN",
            logging.CRITICAL: "CRIT",
        }
        RESET = "\033[0m"
        # widths exclude the surrounding brackets
        LEVEL_WIDTH = 5
        FILE_WIDTH = 12

        def format(self, record):
            # pad before adding color codes so they don't count toward the width
            color = self.COLORS.get(record.levelno, "")
            name = self.SHORT_NAMES.get(record.levelno, record.levelname)
            padding = " " * max(0, self.LEVEL_WIDTH - len(name))
            record.level_col = f"[{color}{name}{self.RESET}]{padding}"
            module = record.module
            if len(module) > self.FILE_WIDTH:
                module = module[:self.FILE_WIDTH - 2] + ".."
            record.file_col = f"[{module}]".ljust(self.FILE_WIDTH + 2)
            return super().format(record)

    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(ColorFormatter(
        "%(asctime)s %(level_col)s %(file_col)s %(message)s",
        "%H:%M:%S"
    ))

    root = logging.getLogger()
    root.handlers.clear()
    root.addHandler(handler)
    root.setLevel(logging.DEBUG)
