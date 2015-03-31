import re

from bottle import request, redirect, mako_template as template
from bottle_utils.ajax import roca_view

from ..core import archive


WS = re.compile(r'\s', re.M)


def split_tags(tags):
    tags = (t.strip() for t in tags.split(','))
    return set([WS.sub(' ', t) for t in tags if t])


@roca_view('tag_cloud', '_tag_cloud', template_func=template)
def tag_cloud():
    try:
        current = request.params.get('tag')
    except (ValueError, TypeError):
        current = None
    tags = archive.get_tag_cloud()
    return dict(tag_cloud=tags, tag=current)


@archive.with_content
def edit_tags(meta):
    tags = request.forms.getunicode('tags', '')
    tags = split_tags(tags)
    existing_tags = set(meta.tags.keys())
    new = tags - existing_tags
    removed = existing_tags - tags
    archive.add_tags(meta, new)
    archive.remove_tags(meta, removed)
    if request.is_xhr:
        print('Rendering XHR template with meta', meta)
        return template('_tag_list', meta=meta)
    redirect('/')


