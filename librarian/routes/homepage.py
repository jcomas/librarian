"""
homepage.py: Flat pages used for web demo only

Copyright 2014-2015, Outernet Inc.
Some rights reserved.

This software is free software licensed under the terms of GPLv3. See COPYING
file that comes with the source code, or http://www.gnu.org/licenses/gpl.txt.
"""

from bottle import redirect, response

from bottle_utils.i18n import i18n_path, lazy_gettext as _


def redirect_funding():
    redirect('http://funding.outernet.is', 301)


def redirect_launch():
    redirect(i18n_path('/'), 301)


def redirect_lantern():
    redirect('https://www.indiegogo.com/projects/lantern-one-device-free-data-from-space-forever/x/8224720', 301)


def redirect_editathon():
    redirect('http://editathon.outernet.is/', 301)


def routes(app):
    return (
        (
            'flat:how_to_connect',
            app.exts.flat_pages.how_to_connect,
            ['GET'],
            '/how-to-connect/',
            {}
        ), (
            'redirect:funding',
            redirect_funding,
            'GET',
            '/funding',
            {}
        ), (
            'redirect:funding_ts',
            redirect_funding,
            'GET',
            '/funding/',
            {}
        ), (
            'redirect:launch',
            redirect_launch,
            'GET',
            '/launch',
            {}
        ), (
            'redirect:launch_ts',
            redirect_launch,
            'GET',
            '/launch/',
            {}
        ), (
            'redirect:lantern',
            redirect_lantern,
            'GET',
            '/lantern',
            {}
        ), (
            'redirect:lantern_ts',
            redirect_lantern,
            'GET',
            '/lantern/',
            {}
        ), (
            'redirect:editathon',
            redirect_editathon,
            'GET',
            '/editathon',
            {}
        ), (
            'redirect:editathon_ts',
            redirect_editathon,
            'GET',
            '/editathon/',
            {}
        ), (
            'redirect:editathon_dashed',
            redirect_editathon,
            'GET',
            '/edit-a-thon',
            {}
        ), (
            'redirect:editathon_dashed_ts',
            redirect_editathon,
            'GET',
            '/edit-a-thon/',
            {}
        ),
    )
