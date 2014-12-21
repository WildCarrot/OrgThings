#!/bin/bash
#
# Setup the directories for OrgThings under the current directory.
#

mkdir -p OrgThings/Projects
mkdir -p OrgThings/Someday
mkdir -p OrgThings/Logbook

touch OrgThings/Inbox.org
touch OrgThings/Logbook/Inbox.org

echo "#+ARCHIVE: Logbook/Inbox.org::" > OrgThings/Inbox.org
