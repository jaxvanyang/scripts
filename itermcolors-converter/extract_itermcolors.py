#!/usr/bin/env python3

from sys import stderr, argv
from plistlib import load

primary_colors = ["Background Color", "Foreground Color"]
cursor_colors = ["Cursor Color", "Cursor Text Color"]
selection_colors = ["Selected Text Color", "Selection Color"]
normal_colors = [
    "Black",
    "Red",
    "Green",
    "Yellow",
    "Blue",
    "Magenta",
    "Cyan",
    "White",
]
bright_colors = [
    "Bright Black",
    "Bright Red",
    "Bright Green",
    "Bright Yellow",
    "Bright Blue",
    "Bright Magenta",
    "Bright Cyan",
    "Bright White",
]


def main(file_name):
    with open(file_name, "rb") as fp:
        plist = load(fp)

        def get_hex(key):
            colors = plist[key]
            color_pcts = (
                colors["Red Component"],
                colors["Green Component"],
                colors["Blue Component"],
            )
            color_nums = tuple(map(lambda val: round(val * 255), color_pcts))

            return "#%02X%02X%02X" % color_nums

        # Primary colors
        for color in primary_colors:
            print(color, get_hex(color))

        # Cursor colors
        for color in cursor_colors:
            print(color, get_hex(color))

        # Selection colors
        for color in selection_colors:
            print(color, get_hex(color))

        # Normal colors
        for i in range(0, 8):
            print(normal_colors[i], get_hex(f"Ansi {i} Color"))

        # Bright colors
        for i in range(8, 16):
            print(bright_colors[i - 8], get_hex(f"Ansi {i} Color"))


if __name__ == "__main__":
    if len(argv) < 2:
        print(
            "You have to specifiy the .itermcolors file on the command line!",
            file=stderr,
        )
        exit(1)

    main(argv[1])
