#!/bin/python

import re
import sys

git_path_pattern="((git|ssh|http(s)?)|(git@[\w\.]+))(:(//)?)([\w\.@\:/\-~]+)(\.git)(/)?"

assert len(sys.argv) == 2

git_path = sys.argv[1]

match = re.match(git_path_pattern,git_path)
assert match

print (match.group(7))

