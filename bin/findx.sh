# find . -name .svn -a -type d -prune -o -type f -print0 |  xargs -0 grep "$*"
# find   . -name .git -a -type d -prune -o -type f -print0 |  xargs -0 grep "$*"
find   . -name .git -a -type d -prune -o -type f -print0 |  xargs -0 grep "$*" | grep -v "/target/" | grep -v "/target-ide/" | grep -v "/.tox/"
