;;; parsoj-org/init.el -*- lexical-binding: t; -*-

(setq org-capture-templates
      '(
        ("i" "Inbox entry" entry
         (file +org-capture-todo-file)
         "* INBOX %?\n%i\n%a" :prepend t :kill-buffer t)

        ("p" "protocol quick-capture" entry
         (file +org-capture-todo-file)
         "* INBOX %a" :prepend t :kill-buffer t :immediate-finish t)
        )
      )

(setq +org-capture-frame-parameters
 '((name . "org-capture")
  (width . 70)
  (height . 25)
  (transient . t)
  (undecorated . t)
  ))

(setq +org-capture-todo-file "inbox/inbox.org"
      +org-capture-notes-file "inbox/inbox.org"
      )

(setq org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil)

(defvar sr-org-refile-targets nil
  "List of refile targets for Org-remember.
   See `org-refile-targets'.")

(defvar sr-org-refile-dir-excludes  "^[#\\.].*$")
(defvar sr-org-refile-file-excludes "^[#\\.].*$")


(setq org-directory "~/org/")

(setq org-file-search-regexp "\\`[^.].*\\.org\\'")

(defun org-files-from-dirs (dirs)
  (directory-list-find-files-recursively
   (mapcar (lambda (x) (concat org-directory x)) dirs)
   org-file-search-regexp))


(defun directory-list-find-files-recursively (dir-list match)
  (seq-reduce 'append  (mapcar (lambda (dir) (directory-files-recursively dir match)) dir-list) nil)
  )

(defun refresh-org-refile-targets ()
  (interactive)
  (setq org-refile-targets `(
                             (,(org-files-from-dirs
                                '("remitly" "projects" "life_ops" "reference" "spare_time" "someday_maybe")) .
                                (:maxlevel . 3)))))

(refresh-org-refile-targets)

(add-hook 'org-after-refile-insert-hook 'org-save-all-org-buffers)

;;********************************************************************************
;; Global IDs for org entries

(setq org-id-track-globally t)
(setq org-id-locations-file (convert-standard-filename (concat org-directory ".org-id-locations")))

;;********************************************************************************
;; Context Picker

;; TODO implement a context quick-picker to set current resources and capital


;;******************************************************************************************
;; Workflows
;;

(setq org-todo-keyword-faces `(
                               ("TODO" . ,(doom-color 'yellow))
                               ("NEXT" . ,(doom-color 'red))
                               ("INBOX" . ,(doom-color 'yellow))
                               ("LATER" . ,(doom-color 'teal))
                               ("DONE" . ,(doom-color 'grey))
                               ("CANCELLED" . ,(doom-color 'grey))
                               ("GOAL" . ,(doom-color 'green))
                               )

      org-todo-keywords '(
                          (sequence "TODO(t)" "INBOX(i)" "NEXT(n)" "IN-PROGRESS(p)" "LATER(l)" "WAITING(w)" "BLOCKED(b)" "|" "CANCELLED(c)" "DONE(d!)" )
                          (sequence "GOAL(g)" "|" "GOAL-REACHED(r)")
                          ))

;; TODO rethink the actionable states thing
(setq actionable-states '("INBOX" "TODO" "NEXT"))

(defun get-non-actionable-states ()
  (-difference
   (-map
    (lambda (x) (progn
             (string-match "^\\([A-Z\-]*\\)(..?)?$" x)
             (match-string 1 x)
             ))

    (-filter (lambda (x) (not (or (equal x "|") (equal x 'sequence))))
             (-flatten org-todo-keywords))
    )
   actionable-states)
  )


(defun build-actionability-filter-string ()
  (mapconcat  (lambda (x) (format "-TODO=\"%s\"" x)) (get-non-actionable-states) "")

  )

;;******************************************************************************************
;; Dependencies
;;

(defvar org-dependency-targets '((org-agenda-files :maxlevel . 4)))
(defun ivy-find-todo (search-targets)
  ;; hacking the "org refile" searching functionality to find a todo
  (let ((org-refile-targets search-targets))
    (org-refile-get-location)
    ))

(defun update-blocked-state (pom)
  (let* ((in-blocked-state (equal (org-entry-get pom "TODO") "BLOCKED") )
        (has-blockers (org-entry-get-multivalued-property pom "BLOCKER") )
        (prev-state (org-entry-get pom "STATE-BEFORE-BLOCKED") )
        (has-prev-state (if prev-state t nil) )
        )

    (cond
     ((and in-blocked-state (not has-blockers))
      (progn
        (org-entry-put pom "TODO" (if has-prev-state prev-state "TODO") )
        (org-entry-delete pom "STATE-BEFORE-BLOCKED"))
      )
     ((and (not in-blocked-state) has-blockers)
      (org-entry-put pom "STATE-BEFORE-BLOCKED" (org-entry-get pom "TODO"))
      (org-entry-put pom "TODO" "BLOCKED")
      )
     )

    )
  )

(defun create-dependency (pom_a pom_b)
  (let ((id_a (org-id-get pom_a t))
        (id_b (org-id-get pom_b t)))

    (progn
      (modify-property pom_a "BLOCKERS" (lambda (id_list) (-union id_list '(id_b))))
      (update-state-from-blocker-data pom_a)
      (modify-property pom_b "BLOCKING" (lambda (id_list) (-union id_list '(id_a))))
      )
    )
  )

(defun on-complete-update-downstream-deps (pom)
  ;; look up own id prop (let)
  ;; look up "blocking" prop list (let)

  ;; map over each blocked id:
  ;; * TODO find downstream task based on id
  ;;   - NEXT TODO research how the edna id finder works
  ;; * remove own id from BLOCKER prop list (difference)
  ;; * update state from blocker data (above func)

  )

(defun add-blocker (pom)
  ;; TODO ivy find other task
  ;; TODO create dependency this->other

  )

(defun block-other-task (pom)
  ;; TODO ivy find other task
  ;; TODO create dependency other->this
  )

(defun build-blocked-filter-string ()
  "+BLOCKER={^$}"
  )

;;******************************************************************************************
;; Resources and Contexts
(setq org-resources-enum '("#laptop" "#tablet" "#home" "#work" "#parents" "#spare_time"))


(setq org-contexts-enum '(("@home" . ("#home" "#laptop" "#spare_time"))
                          ("@parents" . ("#parents"))
                          ("@work" . ("#laptop" "#work"))
                          ))


(defvar org-current-context-resources '())

(defun org-set-context (context)
  (setq org-current-context-resources (assoc-default context org-contexts-enum))
  )

(defun build-resource-constraints-filter-string ()
  (string-join-pre (seq-filter (lambda (e) (not (member e org-current-context-resources))) org-resources-enum) "-")
  )

(defun string-join-pre (l sep)
  (concat sep (string-join l sep))
  )
;;******************************************************************************************
;; Captial

(setq focus-levels-enum '(1 2 3 4))

;; In minutes for now
(setq time-levels-enum '(5 15 30 60 120 180))


(setq available-capital-alist '(
                                ("Time" . 30)
                                ("Focus". 3)
                                ))

(defun build-capital-constraints-agenda-query (available-capital-alist)
  ;; NOTE don't filter out items that require a resource not specificed in the alist
  ;; TODO implement

  )

;;******************************************************************************************
;; "Up Next" Agenda block

(defun build-up-next-agenda-query ()
  ;; TODO implement
  (concat
   (build-resource-constraints-filter-string)
   (build-actionability-filter-string)
   "-SCHEDULED>=\"<now>\"")
  )

;;******************************************************************************************
;; Agenda Config


(setq org-agenda-files
      (org-files-from-dirs
       '("remitly" "projects" "life_ops" "spare_time" "inbox")))

(setq org-project-files
      (org-files-from-dirs
       '("remitly" "projects")))

(setq org-lifeops-files
      (org-files-from-dirs
       '("life_ops" "spare_time")))

(setq org-inbox-files
      (org-files-from-dirs
       '("inbox")))

(setq org-calendar-files
      (org-files-from-dirs
       '("calendar")))

(def-package! org-super-agenda
  :config
  (org-super-agenda-mode)

  )

(setq org-agenda-custom-commands
      `(("x" "Now"
         (
          (agenda "" ((org-agenda-span 'day)
                      (org-agenda-start-day "today")
                      (org-agenda-overriding-header "Schedule for Today")
                      (org-agenda-files org-calendar-files)))

          (tags-todo
           "+DEADLINE<=\"<+5d>\""
           ((org-agenda-overriding-header "Due Soon")
            (org-agenda-files org-agenda-files)
            (org-super-agenda-groups
             '(
               (:name "Due Today" :time-grid t
                      :deadline today
                      :deadline past)
               (:name "Due Soon" :time-grid t
                      :and (:deadline future
                                      :not (:habit t))
                      :discard (:anything t)
                      )))))

          (tags-todo
           "+TODO=\"INBOX\""
           ((org-agenda-overriding-header "Inbox Items")
            (org-agenda-files org-inbox-files))
           )

          (tags-todo
           ,(build-up-next-agenda-query)
           ((org-agenda-overriding-header "Life Ops stuff")
            (org-agenda-files org-lifeops-files)
            (org-super-agenda-groups
             '((:and (:not (:habit t)
                           :priority>= "B"
                           )
                     :discard (:anything t))))
            )
           )

          (tags-todo
           ,(build-up-next-agenda-query)
           ((org-agenda-overriding-header "Available Project Work")
            (org-agenda-files org-project-files)
            (org-super-agenda-groups '(
                                       (:auto-category nil))))
           )

          ;; (tags-todo
          ;;  "+STYLE=\"habit\"-SCHEDULED>=\"<now>\""
          ;;  ((org-agenda-overriding-header "Habits for today")
          ;;   (org-super-agenda-groups '()))
          ;;  )

          ))))




;;********************************************************************************
;; Calendar
;; NOTE - we expect "org-caldav-oauth2-client-id" and "org-caldav-oauth2-client-secret" to be set in a secrets file

(def-package! org-gcal)
(setq org-gcal-file-alist '(
                            ;; ("jeff@messydesk.solutions" . "/Users/jeffp/org/calendar/messydesk-calendar.org")
                            ("jeffp@remitly.com" . "/Users/jeffp/org/calendar/remitly-calendar.org")
                            ))
