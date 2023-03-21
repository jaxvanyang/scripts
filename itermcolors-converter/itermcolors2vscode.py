#!/usr/bin/env python3

from sys import stderr, argv
from plistlib import load

# Color names
primary_colors = ['Background Color', 'Foreground Color']
primary_colors_vscode = ['background', 'foreground']
cursor_colors = ['Cursor Color', 'Cursor Text Color']
cursor_colors_vscode = ['foreground', 'background']
selection_colors = ['Selected Text Color', 'Selection Color']
selection_colors_vscode = ['selectionForeground', 'selectionBackground']
normal_colors = [
    'Black',
    'Red',
    'Green',
    'Yellow',
    'Blue',
    'Magenta',
    'Cyan',
    'White',
]
normal_colors_vscode = list(map(lambda color: 'ansi' + color, normal_colors))
bright_colors = [
    'Bright Black',
    'Bright Red',
    'Bright Green',
    'Bright Yellow',
    'Bright Blue',
    'Bright Magenta',
    'Bright Cyan',
    'Bright White'
]
bright_colors_vscode = list(map(lambda color: str.replace('ansi' + color, ' ', ''), bright_colors))

def main(file_name):
    with open(file_name, 'rb') as fp:
        plist = load(fp)

        def get_hex(key):
            colors = plist[key]
            color_pcts = (colors['Red Component'], colors['Green Component'], colors['Blue Component'])
            color_nums = tuple(map(lambda val: round(val * 255), color_pcts))

            return '#%02X%02X%02X' % color_nums

        def print_vscode_color(color_name, color):
            print(f'"terminal.{color_name}": "{get_hex(color)}",')

        def print_vscode_cursor_color(color_name, color):
            print(f'"terminalCursor.{color_name}": "{get_hex(color)}",')


        print(f'// usage see https://stackoverflow.com/questions/42307949/color-theme-for-vs-code-integrated-terminal')
        print(f'// converted from {file_name}')

        # Primary colors
        print("// it's recommended to comment out the background line for consistency")
        for i, color in enumerate(primary_colors):
            print_vscode_color(primary_colors_vscode[i], color)

        # Cursor colors
        for i, color in enumerate(cursor_colors):
            print_vscode_cursor_color(cursor_colors_vscode[i], color)

        # Selection colors
        for i, color in enumerate(selection_colors):
            print_vscode_color(selection_colors_vscode[i], color)

        # Normal colors
        for i, color in enumerate(normal_colors_vscode):
            print_vscode_color(color, f'Ansi {i} Color')

        # Bright colors
        for i, color in enumerate(bright_colors_vscode):
            print_vscode_color(color, f'Ansi {i + 8} Color')

if __name__ == '__main__':
    if len(argv) < 2:
        print('You have to specifiy the .itermcolors file on the command line!', file=stderr)
        exit(1)

    main(argv[1])
