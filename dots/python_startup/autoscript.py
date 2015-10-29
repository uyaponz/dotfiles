#!/usr/bin/env python
# coding: utf-8

print 'autoscript.py'

import readline
import rlcompleter
import atexit
import os

# --------

# Autocomplete
bindname = "tab: complete"
if "libedit" in readline.__doc__:
    bindname = "bind ^I rl_complete"
rlcompleter.readline.parse_and_bind(bindname)
del bindname

# History file
histfile = os.path.join(os.environ['HOME'], '.python_history')
try:
    readline.read_history_file(histfile)
except IOError:
    pass
atexit.register(readline.write_history_file, histfile)
del histfile

# --------

del os,          \
    atexit,      \
    rlcompleter, \
    readline
