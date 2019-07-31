#!/usr/bin/env python3
# Assumes the requests library is already installed.
# If not, try 'pip3 install requests'

import os
import requests
import json
from collections import Counter

# Set data params for second part of the script
date_settings = {'since': '2018-07-01T00:00:00Z', 'until': '2018-08-31T00:00:00Z'}

github_uri = "https://api.github.com/repos/teradici/deploy/contributors"
github_uri2 = "https://api.github.com/repos/teradici/deploy/commits"

# Get contributor data for the repo
r = requests.get(github_uri)
json_output = json.loads(r.text)


# Init vars for most prolific author
most_prolific_author = ""
most_prolific_author_count = 0

for author in json_output:

    if most_prolific_author == "":
        most_prolific_author = author['login']
        most_prolific_author_count = author['contributions']

    if author['contributions'] > most_prolific_author_count:
        most_prolific_author = author['login']
        most_prolific_author_count = author['contributions']

print("Most prolific author: {0} - number of commits: {1}".format(most_prolific_author, most_prolific_author_count))


# Get commits between set dates, inclusive
r2 = requests.get(github_uri2, params=date_settings)
json_output2 = json.loads(r2.text)

# Grab unique datestamps for commits
c2 = Counter(commit['commit']['author']['date'] for commit in json_output2)

# Show the number of keys in the dict, assuming no two commits were ever performed at exactly the same time
print("Total number of commits in the date range: {0}".format(len(c2)))