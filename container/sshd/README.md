# Usage

see [`test.sh`](test.sh).


## Troubleshooting

Change `-D` to `-eddd` in `Dockerfile`, (rebuild and) check `docker logs -f test-sshd`. 
NB that _The server also will not fork and will only process one connection._ (`man sshd`),
the container has to be re-started after every test.


## TODO

1. resolve all pending _TODO_ in `Dockerfile`
1. automate user creation and pub key steps from `test.sh`, for arbitrary users - but without hard-coding them into the Dockerfile.
