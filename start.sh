#!/bin/sh

# Load header
. ./header.inc

# Setup JIRA enviroment
export JAVA_HOME=${PLATFORM_APP_DIR}/jre
export JIRA_LOGBASE=${PLATFORM_APP_DIR}/home
export CATALINA_OPTS="-Dport.http=${PORT} -Dwork.dir=${PLATFORM_APP_DIR}/home/work -Dappbase.dir=${PLATFORM_APP_DIR}/home/webapps -Dlog.dir=${PLATFORM_APP_DIR}/home/logs -Dhttp.scheme=https -Dproxy.port=443"
export CATALINA_TMPDIR=/tmp
export CATALINA_OUT=/tmp/log/catalina.out
export CATALINA_PID=${PLATFORM_APP_DIR}/home/work/catalina.pid

# If a domain name is setup
if [ ! -z "$JIRA_FQDN" ]; then
    export CATALINA_OPTS="${CATALINA_OPTS} -Dproxy.name=${JIRA_FQDN}"
fi

# Start JIRA
${PLATFORM_APP_DIR}/jira/bin/start-jira.sh -fg
