OrgThings
=========

Emacs org-mode macros to mimic the behavior of a ToDo list manager I like.

The salient features are:

* easy capture of ideas (C-c c (org-capture))
* marking items I want to work on Today (C-c t (orgthings-set-today))
* viewing the Today list (C-c v t (orgthings-view-today))
* viewing the Next list (C-c v n (orgthings-view-next))

File Setup
----------

Run the setup.sh file to create the basic structure of OrgThings.

    OrgThingsData/
        Inbox.org - Where new items are captured to
        Projects/
           <foo.org> - Whatever projects you're working on
        Someday/
           Inbox.org - For someday items not in a project
           <foo.org> - For a self-contained project for someday
        Logbook/
           Inbox.org - Archived individual items not in a project
           <foo.org> - Archived whole projects

Put the org-things.el on your emacs library load path and include the
file.  For example:

    (add-to-list 'load-path (expand-file-name "~/OrgThings"))
    (load-library "org-things.el")

Modify

Quick Reference
---------------

These are actions that are relevant to OrgThings.

* Capture a TODO item - C-c c (org-capture)
* Mark an item for Today - C-c t (orgthings-set-today)
* Mark an item not for Today - C-c n t (orgthings-not-today)
* View items for Today - C-c v t (orgthings-view-today)
* View Next items - C-c v n (orgthings-view-next)
* Set item as important - C-c i (orgthings-set-important)
* Clear important flag from item - C-c n i (orgthings-not-important)

These are generally useful actions when using org-mode.

* Cycle an item through states - C-c C-t (org-todo)
* Set a deadline on an item - C-c C-d (org-deadline)
* View the Agenda with scheduled and deadline items - C-c a a (org-agenda-list)
* Set a tag on an item - C-c C-c (org-set-tags-command, I think)
* Set a timed note on an item in the LOGBOOK drawer - C-c 0 (org-add-note)

Further Notes
-------------

I am intentionally not using the Schedule feature of org-mode for Today things.
When something has a scheduled date on it, I really want that to mean that's when
it should be done.  There are lots of scheduling features in my favorite ToDo list
manager that I have not replicated here.  Some of that is intentional; some of that
is laziness.  Maybe someday I'll add those features.

The marking and clearing of importance is still a little broken.  For example,
clearing an item will search forward and clear the next importance flag it sees,
not just on the same line.
