"""
sessions.py: Tools for dealing with server-side sessions

Copyright 2014-2015, Outernet Inc.
Some rights reserved.

This software is free software licensed under the terms of GPLv3. See COPYING
file that comes with the source code, or http://www.gnu.org/licenses/gpl.txt.
"""

import uuid
import json
import datetime
import functools

from bottle import request, response, hook

from .common import basestring


class SessionError(Exception):
    """ Exception raised when there is an error with sessions """
    def __init__(self, session_id):
        super(SessionError, self).__init__()
        self.session_id = session_id


class SessionInvalid(SessionError):
    pass


class SessionExpired(SessionError):
    pass


class Session(object):
    """ Represents a user session """
    def __init__(self, session_id, data, expires):
        self.id = session_id
        self.expires = expires
        self.data = self._load(data)

    # Serialization

    def _load(self, s):
        """ Load data from buffer """
        if not s:
            return {}
        if isinstance(s, basestring):
            return json.loads(s)
        return s

    def _dump(self):
        return json.dumps(self.data)

    # Session management

    def save(self):
        db = request.db
        q = db.Replace('sessions', cols=['session_id', 'data', 'expires'])
        db.query(q, session_id=self.id, data=self._dump(),
                 expires=self.expires)
        return self

    def delete(self):
        db = request.db
        q = db.Delete('sessions', where='session_id = ?')
        db.query(q, self.id)
        return self

    def rotate(self):
        self.delete()
        self.id = self.generate_session_id()
        return self.save()

    def expire(self):
        if self.expires >= datetime.datetime.utcnow():
            return self
        self.delete()
        raise SessionExpired(self.id)

    def set_cookie(self, name, secret):
        max_age = (self.expires - datetime.datetime.now()).seconds
        response.set_cookie(name, self.id, path='/', secret=secret,
                            max_age=max_age)

    # Session data manipulation

    def get(self, key, default=None):
        """Get a value from the dictionary.

        :param key:      The dictionary key.
        :param default:  The default to return if the key is not in the
                          dictionary. Defaults to None.
        :returns:         The dictionary value or the default if the key is not
                          in the dictionary.
        """
        return self.data.get(key, default)

    def has_key(self, key):
        """Check if the dictionary contains a key.

        :param key:  The dictionary key.
        :returns:     bool
        """
        return self.__contains__(key)

    def items(self):
        """Return a list of all the key-value pair tuples in the session dict.

        :returns:  list of tuples
        """
        return self.data.items()

    def keys(self):
        """Return a list of all keys in the session dictionary.

        :returns:  list of str
        """
        return self.data.keys()

    def values(self):
        """Returns a list of all values in the session dictionary.

        :returns:  list of values
        """
        return self.data.values()

    def __contains__(self, key):
        """Check if a key is in the session dictionary.

        :param key:  The dictionary key.
        :returns:    bool
        """
        return key in self.data

    def __delitem__(self, key):
        """Delete an item from the session dictionary.

        param key:  The dictionary key.
        """
        del self.data[key]

    def __getitem__(self, key):
        """Return a value associated with a key from the session dictionary.

        :param key:  The dictionary key.
        :returns:    The value associated with that key in the dictionary.
        """
        return self.data[key]

    def __setitem__(self, key, value):
        """Set a key-value association.

        :param key:    The dictionary key.
        :param value:  The dictionary value
        """
        self.data[key] = value

    def __len__(self):
        """Get the number of key-value pairs in the session dictionary.

        :returns:  Number of key value pairs in the dictionary.
        """
        return len(self.data)

    def __iter__(self):
        """Iterate over the dictionary keys.

        :yields:  Dictionary keys
        """
        for key in self.data.items():
            yield key

    # Request session management

    @classmethod
    def fetch(cls, session_id):
        """Fetch an existing session by it ID.

        :param session_id:  unique session ID
        :returns:           valid `Session` instance.
        """
        db = request.db
        q = db.Select(sets='sessions', where='session_id = ?')
        db.query(q, session_id)
        session_data = db.result
        if not session_data:
            raise SessionInvalid(session_id)
        sess = cls(**session_data)
        return sess.expire()  # deletes and raises if session has expired

    @classmethod
    def create(cls):
        """Create a new session.

        :returns:         Valid `Session` instance.
        """
        session_id = cls.generate_session_id()
        data = {}
        expires = cls.get_expiry()
        sess = cls(session_id, data, expires).save()
        return sess

    @classmethod
    def destroy(cls):
        """Delete current session from database."""
        request.session.delete
        request.session = cls.create()

    # Utility methods

    @staticmethod
    def generate_session_id():
        return uuid.uuid4().hex

    @staticmethod
    def get_expiry():
        life = int(request.app.config['session.lifetime'])
        return datetime.datetime.utcnow() + datetime.timedelta(life)


def session_plugin(cookie_name, secret):
    # Set up a hook, so handlers that raise cannot escape session-saving
    @hook('after_request')
    def save_session():
        # FIXME: Find a way to avoid this if session wasn't modified
        if hasattr(request, 'session'):
            request.session.save()
            request.session.set_cookie(cookie_name, secret)

    def plugin(callback):
        @functools.wraps(callback)
        def wrapper(*args, **kwargs):
            session_id = request.get_cookie(cookie_name, secret=secret)
            try:
                request.session = Session.fetch(session_id)
            except (SessionExpired, SessionInvalid):
                request.session = Session.create()
            return callback(*args, **kwargs)
        return wrapper
    return plugin
