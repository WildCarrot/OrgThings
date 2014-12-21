; Org-mode settings for OrgThings in emacs.
; (https://github.com/WildCarrot/OrgThings)

; CHANGE ME: Location of the OrgThings root where the ToDo files are stored.
; This is probably NOT the same directory as where the org-things.el file
; is stored.
(setq orgthings-path (expand-file-name "~/OrgThingsData"))

; Inbox for capturing new items.
(setq org-default-notes-file (expand-file-name (concat orgthings-path "/Inbox.org")))

; Files for the agenda view.
; Does not include "Someday" or "Logbook" on purpose.
(setq org-agenda-files (list (expand-file-name orgthings-path)
			     (expand-file-name (concat orgthings-path "/Projects"))))

(setq org-archive-location "::* Logbook")

; Define global access to saving to the Inbox.
(global-set-key "\C-cc" 'org-capture)

; Make it harder to make mistakes. (http://orgmode.org/manual/Catching-invisible-edits.html)
(setq org-catch-invisible-edits t)

; Include the time an item was completed. (http://orgmode.org/manual/Closing-items.html)
(setq org-log-done 'time)

; Use a "drawer" for state changes. (http://orgmode.org/manual/Drawers.html)
(setq org-log-into-drawer t)

; Define intermediate states of TODOs and define completion conditions other thand just DONE.
; The ! means to log a timestamp; /! means log when switching away from that mode.
; The @ means to log a note and a timestamp.
; (http://orgmode.org/manual/Tracking-TODO-state-changes.html#Tracking-TODO-state-changes)
(setq org-todo-keywords '((sequence "TODO(t/!)" "INPROGRESS(i/!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)" "MOVED(m!)")))

; Because I use C-z for tmux, I can't use the standard C-c C-z to add a note
; to the logbook.  Instead, remap that to something else.
(global-set-key "\C-c0" 'org-add-note)

; Define global access to the agenda.
(global-set-key "\C-ca" 'org-agenda)

; Define the capture templates.
; Includes a Logbook drawer entry for when the entry was created
; and the file and any highlighted context.
; (http://orgmode.org/manual/Template-elements.html#Template-elements)
; (http://orgmode.org/manual/Template-expansion.html#Template-expansion)
(setq org-capture-templates
      '(("t" "Todo" entry (file "")
	 "* TODO %?\n  :LOGBOOK:\n  CREATED: %u\n  %F\n  %i\n  :END:\n")))

; Define tags for "today" list.
; Add others as desired.
(setq org-tag-alist '(("@today" . ?t) ("@deadline" . ?d)))

(defun orgthings-set-today ()
  ; Add the @today tag to the current entry.
  (interactive)
  (if (org-get-tags)
      (if (not (member "@today" (org-get-tags)))
	  (org-set-tags-to (concat (org-get-tags-string) ":@today:")))
    (org-set-tags-to ":@today:"))
)

(defun orgthings-not-today ()
  ; Remove the @today tag from the current entry.
  (interactive)
  (if (org-get-tags)
      (org-set-tags-to (delete "@today" (org-get-tags))))
)

(defun orgthings-view-today ()
  ; View all the items tagged with "@today".
  (interactive)
  (org-tags-view nil "@today")
  )

(global-set-key "\C-ct" 'orgthings-set-today)
(global-set-key "\C-cnt" 'orgthings-not-today)
(global-set-key "\C-cvt" 'orgthings-view-today)

(defun orgthings-view-next ()
  ; View all the TODO items to see what to work on next.
  (interactive)
  (org-todo-list)
)

(global-set-key "\C-cvn" 'orgthings-view-next)

;; (defun orgthings-set-deadline ()
;;   (interactive)
;;   (org-deadline)
;;   (if (org-get-tags)
;;       (org-set-tags-to (concat (org-get-tags-string) ":@deadline:"))
;;     (org-set-tags-to ":@deadline:"))
;; )

;; (global-set-key "\C-cd" 'orgthings-set-deadline)

(defun orgthings-set-importance-high ()
  ; Mark the item with "A" level priority.
  (interactive)
  (save-excursion
   (let ()
     (move-beginning-of-line nil)
     (forward-word) ; Should skip the leading stars and first TODO word.
     (insert " [#A]")
   )
  )
)

(defun orgthings-clear-importance ()
  ; Clear the "A" level importance flag from an entry.
  ; TODO: Make this work with all levels of importance, not just "A".
  (interactive)
  (save-excursion
    (let ()
      (move-beginning-of-line nil)
      (forward-word)
      (if (search-forward " [#A]" nil t) (replace-match ""))
      ;; (replace-regexp " \[#[ABC]\]" "" (point) (+ (point) 5))
      ;; (if (search-forward-regexp " \[#[ABC]\]" nil t) (message "foo") (message "no match"))
      ;; ; (if (search-forward-regexp " \[#[ABC]\]" nil t) (replace-match ""))
    )
  )
)

(global-set-key "\C-ci" 'orgthings-set-importance-high)
(global-set-key "\C-cni" 'orgthings-clear-importance)
