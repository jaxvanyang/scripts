#!/usr/bin/env python3

from sys import stderr, argv
from plistlib import load as pl_load
from yaml import dump as yaml_dump

primary_colors = ["Background Color", "Foreground Color"]
cursor_colors = ["Cursor Color", "Cursor Text Color"]
selection_colors = ["Selected Text Color", "Selection Color"]
color_list = [
    "black",
    "red",
    "green",
    "yellow",
    "blue",
    "magenta",
    "cyan",
    "white",
]
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
        plist = pl_load(fp)

        def get_hex(key):
            colors = plist[key]
            color_pcts = (
                colors["Red Component"],
                colors["Green Component"],
                colors["Blue Component"],
            )
            color_nums = tuple(map(lambda val: round(val * 255), color_pcts))

            return "#%02X%02X%02X" % color_nums

        # build alacritty.yml object
        obj = {
            "colors": {
                "primary": {
                    "background": get_hex(primary_colors[0]),
                    "foreground": get_hex(primary_colors[1]),
                },
                "cursor": {
                    "cursor": get_hex(cursor_colors[0]),
                    "text": get_hex(cursor_colors[1]),
                },
                "selection": {
                    "text": get_hex(selection_colors[0]),
                    "background": get_hex(selection_colors[1]),
                },
                "normal": {},
                "bright": {},
            },
        }
        # normal & bright colors
        for i in range(0, 8):
            obj["colors"]["normal"][color_list[i]] = get_hex(f"Ansi {i} Color")
            obj["colors"]["bright"][color_list[i]] = get_hex(f"Ansi {i + 8} Color")

        print(yaml_dump(obj))


if __name__ == "__main__":
    if len(argv) < 2:
        print(
            "You have to specifiy the .itermcolors file on the command line!",
            file=stderr,
        )
        exit(1)

    main(argv[1])
