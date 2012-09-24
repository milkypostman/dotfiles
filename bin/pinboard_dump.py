#!/usr/bin/env python
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
import os
import sys
import json
import netrc
import errno
import requests

def die(msg, err):
    sys.stderr.write(msg)
    sys.exit(err)

login = netrc.netrc().authenticators('pinboard.in')
if not login:
    die('pinboard.in not found in netrc', errno.ENODATA)

try:
    getreq = requests.get('https://api.pinboard.in/v1/posts/all?format=json',
            auth=(login[0], login[2]))

    if getreq.status_code == 429:
        die('too often', errno.EPERM)
    if getreq.status_code != requests.codes.ok:
        die('http error %s on getting, maybe wrong password?' %
                getreq.status_code, errno.EACCES)

    items = json.loads(getreq.text)

    res = '''<!DOCTYPE NETSCAPE-Bookmark-file-1>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Pinboard bookmarks</title>
    <dl>'''

    for item in items:
        res += '<dt><a href="%s">%s</a></dt>\n' % \
        (item['href'].encode('utf-8'), item['description'].encode('utf-8'))
    res += '</dl>'

    open(os.environ['HOME']+'/.bookmarks.html', 'w').write(res)
except requests.exceptions.RequestException:
    die('connection error', errno.ECONNREFUSED)
