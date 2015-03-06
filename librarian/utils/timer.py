"""
timer.py: Request timer statistical tool

Code adapted from Bottle documentation

Copyright 2014-2015, Outernet Inc.
Some rights reserved.

This software is free software licensed under the terms of GPLv3. See COPYING
file that comes with the source code, or http://www.gnu.org/licenses/gpl.txt.
"""

from __future__ import division

import time
from functools import wraps

try:
    import resource
except ImportError:
    # Platform does not support ``resources`` module.
    resource = None

from bottle import response

from ..lib.html import hsize


def get_mem():
    if not resource:
        return 0
    rss = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss  # in KB
    return round(rss / 1024, 3)


def request_timer(callback):
    @wraps(callback)
    def wrapper(*args, **kwargs):
        start = time.time()
        res = callback(*args, **kwargs)
        delta = time.time() - start
        response.headers['X-Exec-Time'] = str(round(delta * 1000, 4)) + 'ms'
        response.headers['X-Mem'] = str(get_mem())
        return res
    return wrapper