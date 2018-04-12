#!/usr/bin/python
import feedparser
import pickle
import time
import sys
import os

pickle_path = os.path.expanduser('~/.info-archnews-notify.pickle')

def get_feed():
    feed = feedparser.parse('https://www.archlinux.org/feeds/news/')
    return feed

def get_pickle_date():
    try:
        with open(pickle_path, 'rb') as handle:
            date = pickle.load(handle)
    except FileNotFoundError:
        date = None
    return date

def set_pickle_date(date):
    with open(pickle_path, 'wb') as handle:
        pickle.dump(date, handle, protocol=pickle.HIGHEST_PROTOCOL)

def check_for_update():
    feed = get_feed()
    feed_date = feed['feed']['updated_parsed']
    
    local_date = get_pickle_date()
    if local_date is None:
        set_pickle_date(feed_date)
        local_date = feed_date

    if int(time.mktime(feed_date)-time.mktime(local_date)) != 0:
        print('  索')  # There is an update
    else:
        print("")  # No update detected

def update_pickle():
    feed = get_feed()
    feed_date = feed['feed']['updated_parsed']
    set_pickle_date(feed_date)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "-u":
            update_pickle()
        else:
            raise ValueError("Not a valid argument")
    else:
        check_for_update()
