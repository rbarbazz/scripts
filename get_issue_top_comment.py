# This script helps you find the most upvoted comment on a Github issue

import requests
import sys

raw_url = input("Provide the URL of a public Github issue: ")
api_url = raw_url.replace("https://github.com/", "https://api.github.com/repos/")
api_comments_url = api_url + "/comments"

response = requests.get(
    api_comments_url,
    headers={"Accept": "application/vnd.github.squirrel-girl-preview+json"},
)

if response.ok:
    comments = response.json()

    if len(comments) < 1:
        sys.exit("No comments on this issue")

    top_comment = comments[0]

    for comment in comments:
        top_total_count = top_comment["reactions"]["total_count"]
        current_total_count = comment["reactions"]["total_count"]

        if current_total_count > top_total_count:
            top_comment = comment

    print(top_comment["html_url"])
