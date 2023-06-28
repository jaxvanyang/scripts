#!/usr/bin/env python3
#
# Generated by ChatGPT
#
# Usage:
#   time2s [days [hours [minutes [seconds]]]]
#   time2s -h

import argparse

SECONDS_PER_MINUTE = 60
SECONDS_PER_HOUR = 60 * SECONDS_PER_MINUTE
SECONDS_PER_DAY = 24 * SECONDS_PER_HOUR

def parse_arguments():
    parser = argparse.ArgumentParser(description='Convert time to seconds')
    parser.add_argument('time', nargs='*', type=int, help='Time components: days, hours, minutes, seconds')
    return parser.parse_args()

def calculate_total_seconds(time):
    days = time[0] if len(time) >= 1 else 0
    hours = time[1] if len(time) >= 2 else 0
    minutes = time[2] if len(time) >= 3 else 0
    seconds = time[3] if len(time) >= 4 else 0
    total_seconds = (
        days * SECONDS_PER_DAY +
        hours * SECONDS_PER_HOUR +
        minutes * SECONDS_PER_MINUTE +
        seconds
    )
    return total_seconds

def main():
    args = parse_arguments()
    total_seconds = calculate_total_seconds(args.time)
    formatted_seconds = '{:,}'.format(total_seconds)
    print(f'Total seconds: {formatted_seconds}')

if __name__ == '__main__':
    main()
