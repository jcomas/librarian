"""
homepage.py: Flat pages used for web demo only

Copyright 2014-2015, Outernet Inc.
Some rights reserved.

This software is free software licensed under the terms of GPLv3. See COPYING
file that comes with the source code, or http://www.gnu.org/licenses/gpl.txt.
"""

import logging
import re

import mailchimp

from bottle import redirect, request
from bottle_utils.csrf import csrf_protect
from bottle_utils.i18n import i18n_path, i18n_url, lazy_gettext as _

from ..utils.template import view


EMAIL_RE = re.compile(r'^[^@ ]+@[^@ .]+\.[^@ ]+$')


def subscribe_email(email, list_id=None, source='homepage'):
    """ Subscribes an email address to given list or default list """
    conf = request.app.config
    if not list_id:
        list_id = conf['mailchimp.default_list']
    chimp = mailchimp.Mailchimp(apikey=conf['mailchimp.key'])
    chimp.lists.subscribe(
        list_id,
        {'email': email, 'merge_vars': {'SOURCE': source}},
        double_optin=False,
        update_existing=True,
        send_welcome=True
    )


@csrf_protect
@view('feedback')
def subscribe():
    email = request.forms.get('email', '').strip().lower()
    if EMAIL_RE.match(email):
        try:
            subscribe_email(email)
        except mailchimp.ListAlreadySubscribedError:
            logging.debug("Email '{0}' already subscribed".format(email))
            message = _('Thank you for supporting Outernet!')
            status = 'success'
        except mailchimp.Error:
            logging.exception("Could not subscribe '{0}'".format(email))
            message = _('Subscription could not be completed due to '
                        'unknown error.')
            status = 'error'
        else:
            message = _('Thank you for supporting Outernet!')
            status = 'success'
    else:
        message = _('Please enter a valid email address')
        status = 'error'

    return dict(page_title=_("Subscription"),
                status=status,
                message=message,
                redirect_url=i18n_url('content:list'),
                redirect_target=_("homepage"))


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
            'subscribe',
            subscribe,
            ['POST'],
            '/subscribe/',
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
