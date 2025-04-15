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

        # Print theme information
        print(f"# Converted from {file_name}")
        print("# Refer to https://github.com/Mayccoll/Gogh")

        # Normal & bright colors
        for i in range(0, 16):
            print("color%i=%s" % (i, get_hex(f"Ansi {i} Color")))

        # Other colors
        print("background=%s" % get_hex("Background Color"))
        print("foreground=%s" % get_hex("Foreground Color"))
        print("cursor=%s" % get_hex("Cursor Color"))


if __name__ == "__main__":
    if len(argv) < 2:
        print(
            "You have to specifiy the .itermcolors file on the command line!",
            file=stderr,
        )
        exit(1)

    main(argv[1])
