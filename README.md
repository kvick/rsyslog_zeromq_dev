# rsyslog_zeromq_dev
Dockerfile for my builds when doing zeromq  + rsyslog work. Build rsyslog from $RSYSLOG_REPO with libzmq
and czmq head, and a test config to run it in debug mode with a tcp listener and zeromq output.

```
docker build --build-arg rsyslog_repo=<path to repo>  -t tag .
docker run -t tag 
```
