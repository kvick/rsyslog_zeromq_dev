# rsyslog_zeromq_dev
Dockerfile for my builds when doing zeromq  + rsyslog work. Build rsyslog from $RSYSLOG_REPO with libzmq
and czmq head, and a test config to run it in debug mode with a tcp listener and zeromq output.

export RSYSLOG_REPO=`path to rsyslog dev repo`
docker build -t sometag .
docker run -t sometag

