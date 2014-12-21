#!/bin/bash
#
# Setup the directories for OrgThings under the current directory.
# The path here and in org-things.el must match.
#

mkdir -p OrgThingsData/Projects
mkdir -p OrgThingsData/Someday
mkdir -p OrgThingsData/Logbook

touch OrgThingsData/Inbox.org
touch OrgThingsData/Someday/Inbox.org
touch OrgThingsData/Logbook/Inbox.org

echo "#+ARCHIVE: Logbook/Inbox.org::" > OrgThingsData/Inbox.org
