#!/bin/sh

# Load header
. ./header.inc

# Setup JIRA enviroment
export JAVA_HOME=${PLATFORM_APP_DIR}/jre
export JIRA_LOGBASE=${PLATFORM_APP_DIR}/home
export JIRA_FQDN=$(bin/routes PLATFORM_ROUTES jira | awk -F / '{print $3}' | uniq)
export CATALINA_OPTS="-Dport.http=${PORT} -Dwork.dir=${PLATFORM_APP_DIR}/home/work -Dappbase.dir=${PLATFORM_APP_DIR}/home/webapps -Dlog.dir=${PLATFORM_APP_DIR}/home/logs -Dproxy.name=${JIRA_FQDN} -Dhttp.scheme=https -Dproxy.port=443"
export CATALINA_TMPDIR=/tmp
export CATALINA_OUT=/tmp/log/catalina.out
export CATALINA_PID=${PLATFORM_APP_DIR}/home/work/catalina.pid

# Start JIRA
${PLATFORM_APP_DIR}/jira/bin/start-jira.sh -fg
