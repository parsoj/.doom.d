;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
;;;

(map! :g "s-w" #'delete-frame)
(setq confirm-kill-processes nil)

;;over-write doom's own overwriting of delete-frame, since doom/delete-frame prompts before close
(global-set-key [remap delete-frame] #'delete-frame)
(setq confirm-kill-emacs nil)

(global-wakatime-mode)
(setq
 doom-modeline-buffer-file-name-style 'buffer-name
 )
(load! "~/Dropbox/secrets.el")

(setq display-line-numbers-type nil)

(setq restclient-log-request nil)
(after! lsp
  (setq lsp-auto-guess-root nil)
  )


(map! :leader
      :desc "Counsel M-x"   "SPC" #'counsel-M-x
      :desc "Eval Expression" ":" #'eval-expression
      :desc "Eshell in window"   "\"" #'+eshell/here
      :nv "'" #'+eshell/toggle

      :nv "gh"  #'+lookup/documentation
      :nv "gd" #'+lookup/definition
      :nv "gD" #'+lookup/references
      :nv "gf" #'+lookup/file

      (:prefix ("o" . "org")
        :desc "agenda" "a"   (lambda! (org-agenda nil "x"))
        )

      (:prefix ("t" . "toggle")
        :desc "Treemacs" "t"   #'+treemacs/toggle
        :desc "Fullscreen" "f"   (lambda! (progn (toggle-frame-fullscreen) ))
        :desc "Padding" "padding"   (lambda! (progn (shell-command "yabai -m space --toggle padding && yabai -m space --toggle gap")))
        :desc "Line Numbers"   "n"  #'doom/toggle-line-numbers
        :desc "Line Truncation/Wrap" "l"  #'visual-line-mode
        )

      (:prefix ("w" . "window")
        :desc "Delete" "d"   #'delete-window
        :desc "Swap" "x"   #'ace-swap-window
        :desc "Undo" "u" #'winner-undo
        :desc "Redo" "r" #'winner-redo
        :desc "Maximize"  "m" #'doom/window-maximize-buffer
        :desc "Split Right" "s" #'split-window-vertically
        :desc "Split Below" "v" #'split-window-horizontally
        :desc "Left"  "h" #'evil-window-left
        :desc "Right"  "l" #'evil-window-right
        :desc "Above"  "k" #'evil-window-up
        :desc "Below"  "j" #'evil-window-down
        )

      (:prefix ("f" . "file")
        :desc "Compile" "c"   #'compile
        :desc "Save" "s" #'save-buffer
        :desc "find" "f" #'find-file
        :desc "Sudo Edit this file" "E" #'doom/sudo-this-file
        :desc "rename" "R" #'rename-current-buffer-and-file
        )

      (:prefix ("p" . "project")
        :desc "Switch Project" "p" #'projectile-switch-project
        :desc "Find file in project" "f" #'+ivy/projectile-find-file
        :desc "open project notes" "n" #'+pop-to-project-todo-file
        :desc "capture project note" "c" #'counsel-projectile-org-capture
        :desc "quick test project" "t" (lambda! (funcall project-test-func))
        :desc "long test project" "T" (lambda! (funcall project-full-test-func))
        :desc "jump to project settings" "s" (lambda! (find-file (concat (projectile-project-root) "project-settings.el")))
        )

      (:prefix ("s" . "search")
        :desc "Search Project" "p" #'counsel-projectile-rg
        :desc "Search Project" "P" #'counsel-projectile-
        :desc "Search Buffer"  "b" #'swiper
        :desc "Search Buffer for thing at point" "B" #'swiper-thing-at-point
        :desc "Search Directory"  "d" (lambda! (counsel-rg nil default-directory))
        )

      (:prefix ("b" . "buffer")
        :desc "Compile"                     "c"   #'compile
        :desc "Delete" "d" #'evil-delete-buffer
        :desc "Revert" "r" #'revert-buffer
        :desc "Switch Buffer" "b" #'+ivy/switch-buffer
        :desc "Previous Buffer" "p" #'previous-buffer
        :desc "Next Buffer" "n" #'next-buffer

        )

      (:prefix ("h" . "help")
        :desc "Describe thing in popup" "h" #'describe-thing-in-popup
        :desc "Apropos" "a" #'counsel-apropos
        :desc "Describe Function" "f" #'describe-function
        :desc "Describe Key" "k" #'describe-key
        :desc "Describe Variable" "v" #'describe-variable
        :desc "Describe Char" "c" #'describe-char
        :desc "Describe Mode" "m" #'describe-mode
        :desc "Describe Doom Module" "M" #'doom/describe-module
        :desc "Describe Emacs Package" "p" #'doom/describe-package
        )

      (:prefix ("l" . "lookup")
        :desc "definition" "d" #'+lookup/definition
        :desc "references" "r" #'+lookup/references
        :desc "documentation" "h" #'+lookup/in-docsets
        )

      (:prefix ("d" . "doom")
        :desc "Refresh and Reload " "r" (lambda! (progn (doom//refresh) (doom/reload)))
        :desc "Restart Doom" "R" #'doom/restart
        :desc "Quit Doom" "q" #'evil-quit-all
        :desc "Open Scratch" "s" #'doom/open-scratch-buffer

        (:prefix ("c" . "config")
          :desc "config.el" "c" (lambda! (find-file "~/.doom.d/config.el"))
          :desc "init.el" "i" (lambda! (find-file "~/.doom.d/init.el"))
          :desc "bashrc" "b" (lambda! (find-file "~/.bashrc"))
          :desc "skhdrc" "s" (lambda! (find-file "~/.skhdrc"))
          :desc "yabairc" "w" (lambda! (find-file "~/.yabairc"))
          )
        )

      (:prefix ("m". "message")
        :desc "Slack IM" "i" #'slack-im-select
        :desc "Slack Channel" "c" #'slack-channel-select
        )

      (:prefix ("c" . "cursor")
        :desc "Make cursor and move down line" "j" #'evil-mc-make-cursor-move-next-line
        :desc "Make cursor and move up line" "k" #'evil-mc-make-cursor-move-prev-line
        :desc "Make cursor and move next match" "n" #'evil-mc-make-and-goto-next-match
        :desc "Make cursor and move prev match" "p" #'evil-mc-make-and-goto-prev-match
        :desc "Undo all cursors" "q" #'evil-mc-undo-all-cursors
        :desc "Make all matching cursors" "a" #'evil-mc-make-all-cursors
        )

      (:prefix ("j" . "jump")
        :desc "Jump to character" "c" #'avy-goto-char
        :desc "Jump to line" "l" #'avy-goto-line
        :desc "Jump to Inbox" "i" (lambda! (find-file "~/org/inbox/inbox.org"))
        )

      (:prefix ("g" . "git")
        :desc "Status" "s" #'magit-status
        :desc "blame" "b" #'magit-blame-addition
        :desc "quick commit" "c" (lambda! (progn (magit-stage) (magit-commit-create)))
        ))


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-current-buffer-and-file (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))


;;(setq +lookup-open-url-fn 'eww)

(set-popup-rules!
  '(
    ("^\\*bin/doom\\*$"
     :vslot 9999 :size 0.75 :quit 'current :select t :ttl 0)

    ("^\\*Completions"
     :slot -1 :vslot -2 :ttl 0)

    ("^\\*Compil\\(?:ation\\|e-Log\\)"
     :vslot -2 :size 0.3 :ttl nil :quit t)

    ("^\\*Man "
     :size 0.45 :vslot -3 :ttl 0 :quit t :select t)

    ("^\\*doom \\(?:term\\|eshell\\)"
     :size 0.25 :vslot -4 :select t :quit nil :ttl 0)

    ("^\\*doom:"
     :vslot -5 :size 0.35 :size bottom :autosave t :select t :modeline t :quit nil)

    ("^\\*\\(?:\\(?:Pp E\\|doom e\\)val\\)"
     :size +popup-shrink-to-fit :ttl 0 :select ignore)

    ("^\\*Customize"
     :slot 2 :side right :select t :quit t)

    ("^ \\*undo-tree\\*"
     :slot 2 :side left :size 20 :select t :quit t)

    ("^\\*[Hh]elp"
     :vslot 2 :slot 1 :side right :width .35 :height .5 :select t)

    ("^\\*[Ii]nfo"
     :vslot 2 :slot 2 :side right :width .35 :height .5 :select t)

    ("^\\*doom:scratch\\*"
     :slot 1 :side right :width .45 :ttl nil)

    ("^\\*Project Run\\*"
     :slot 0 :side right :width .45 :select t)

    ("^\\*eww\\*"
     :vslot -11 :side right :size 0.45 :select t)

    ("^\\*HTTP Response\\*"
     :actions '(display-buffer-below-selected) )

    ("^\\*Backtrace"
     :vslot 99 :size 0.4 :quit nil)

    ("^\\*CPU-Profiler-Report "
     :side bottom :vslot 100 :slot 1 :height 0.4 :width 0.5 :quit nil)

    ("^\\*Memory-Profiler-Report "
     :side bottom :vslot 100 :slot 2 :height 0.4 :width 0.5 :quit nil)

    ("^\\*[Ss]lack"
     :slot 2 :side right :vslot -2 :size 0.35 :select t :quit delete-window )

    ("^\\*PROJECT_NOTES\\*"
     :slot 0 :side right :width .35 :select t)

    ("^\\*Org Agenda"
     :slot 1 :side right :width .35 :select t)

    ("^\\*doom:eshell-popup"
     :slot 2 :side bottom :width .35 :select t
     )

    ("^\\*compilation\\*"
     :slot 1 :side right :width .35 :select t
     )

    ))


(set-docsets! 'terraform-mode "Terraform")

(defun edit-word-at-point (edit-func)
  (save-excursion
    (let ((start (and (forward-word) (point)))
          (end (and (backward-word) (point))))
      (insert (funcall edit-func (delete-and-extract-region start end)))
      ))

  )

(defun snake-case-word-at-point ()
  (interactive)
  (edit-word-at-point (lambda (w) (s-snake-case w)))
  )

(defun lower-camel-case-word-at-point ()
  (interactive)
  (edit-word-at-point (lambda (w) (s-lower-camel-case w)))
  )

(defun upper-camel-case-word-at-point ()
  (interactive)
  (edit-word-at-point (lambda (w) (s-upper-camel-case w)))
  )
