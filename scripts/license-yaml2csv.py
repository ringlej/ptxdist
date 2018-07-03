#!/usr/bin/env python3
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

import argparse
import sys
import yaml

def parse_separator(arg):
    if len(arg) != 1:
        raise argparse.ArgumentTypeError('field separator must be a single character')
    else:
        return arg

def parse_input(arg):
    if arg == '-':
        return sys.stdin
    try:
        return open(arg)
    except:
        raise argparse.ArgumentTypeError('cannot access input file "{}"'.format(arg))

def parse_fields(arg):
    tmp = arg.split(',')
    fields = []
    for field in tmp:
        field = field.strip()
        if field:
            fields.append(field)
    if not fields:
        raise argparse.ArgumentTypeError('at least on field must be specified')
    return fields

parser = argparse.ArgumentParser()
parser.add_argument('-s', '--separator', type=parse_separator, default=',',
    help='field separator [,]')
parser.add_argument('-f', '--fields', type=parse_fields,
    default=['name', 'version', 'section', 'licenses', 'flags'],
    help='field list [name,version,section,licenses,flags]')
parser.add_argument('input', nargs='?', type=parse_input,
    default=sys.stdin, help='license yaml file [stdin]')

args = parser.parse_args()

for (_, record) in yaml.load(args.input.read(), Loader=yaml.loader.BaseLoader).items():
    line = ""
    for field in args.fields:
        if line:
            line += args.separator
        value = record.get(field, None)
        if not value:
            value = ''
        quote = args.separator in value or '"' in value
        if quote:
            line += '"'
        line += value.replace('"', '""')
        if quote:
            line += '"'
    line += "\n"
    sys.stdout.write(line)
