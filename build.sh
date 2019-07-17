#!/bin/bash

JIRA_VERSION=8.2.4

JIRA_DOWNLOAD_URI="https://www.atlassian.com/software/jira/downloads/binary"
JIRA_DL_ARCHIVE="atlassian-jira-software-${JIRA_VERSION}.tar.gz"

# Server Optimized JRE
if [ -z "$JRE_DOWNLOAD_URI" ]; then 
	# Default (Note this works only on JIRA 8+)
	JRE_DOWNLOAD_URI="https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jre_x64_linux_hotspot_8u212b03.tar.gz"; 
fi

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

