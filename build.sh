#!/bin/bash

JIRA_VERSION=7.7.0

JIRA_DOWNLOAD_URI="https://www.atlassian.com/software/jira/downloads/binary"
JIRA_DL_ARCHIVE="atlassian-jira-software-${JIRA_VERSION}.tar.gz"

# Server Optimized JRE
JRE_DOWNLOAD_URI="http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/server-jre-8u161-linux-x64.tar.gz"

# Standard JRE
#JRE_DOWNLOAD_URI="http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jre-8u161-linux-x64.tar.gz"

# Make directories
mkdir -p ${PLATFORM_APP_DIR}/jira;
mkdir -p ${PLATFORM_APP_DIR}/jre;

# Download and Extract JIRA
tar xzv -C ${PLATFORM_APP_DIR}/jira --strip 1 < <(wget --no-cookies --no-check-certificate -q -O - ${JIRA_DOWNLOAD_URI}/${JIRA_DL_ARCHIVE})

# Download and Extract a JRE
tar xzv -C ${PLATFORM_APP_DIR}/jre --strip 1 < <(wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" -q -O - ${JRE_DOWNLOAD_URI})

# Fix missing EOL char in jira/conf/logging.properties files
echo "" >> ${PLATFORM_APP_DIR}/jira/conf/logging.properties
# EOL Chars
sed -i 's/\r$//' ${PLATFORM_APP_DIR}/jira/conf/logging.properties

# Apply Platform.sh Patches
OLD_DIR=`pwd`
cd ${PLATFORM_APP_DIR}
for PATCH_FILE in ${PLATFORM_APP_DIR}/patches/*.patch; do    
    patch -p0 < $PATCH_FILE
done

