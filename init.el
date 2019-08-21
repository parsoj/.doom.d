;;; init.el -*- lexical-binding: t; -*-

;; (setq pixel-scroll-mode t)
;;
;;

(setq pos-tip-foreground-color "#bbc2cf")
(setq pos-tip-background-color "#282c34")
(setq doom-modeline-height 15)

(setq doom-leader-key "SPC")
(setq doom-localleader-key ",")
(push "~/dotfiles/emacs/site-lisp/" load-path)


(defun convert-frame-to-daemon ()
  (progn
    (modify-frame-parameters (selected-frame) (list (cons 'name "Daemon Frame")))
    (server-start)
    (iconify-frame)
    )

  )

(add-hook 'after-init-hook #'convert-frame-to-daemon)

(def-package-hook! evil-snipe
  :pre-init
  (setq evil-snipe-override-evil-repeat-keys nil)
  )

(after! evil
  (define-key! evil-motion-state-map "," nil)
  )

(defadvice handle-delete-frame (around my-handle-delete-frame-advice activate)
  "Hide Emacs instead of closing the last frame"
  (let ((frame   (posn-window (event-start event)))
        (numfrs  (length (frame-list))))
    (if (> numfrs 1)
      ad-do-it
      (do-applescript "tell application \"System Events\" to tell process \"Emacs\" to set visible to false"))))

(setq +vc-gutter-default-style nil)

(def-package-hook! ivy-prescient
  :post-init
  (setq prescient-filter-method '(literal regexp initialism fuzzy)
        ivy-prescient-enable-filtering nil ;; we do this ourselves
        ivy-initial-inputs-alist nil
        ivy-re-builders-alist
        '((counsel-ag . +ivy-prescient-non-fuzzy)
          (counsel-rg . +ivy-prescient-non-fuzzy)
          (counsel-grep . +ivy-prescient-non-fuzzy)
          (swiper . +ivy-prescient-non-fuzzy)
          (swiper-isearch . +ivy-prescient-non-fuzzy)
          (t . ivy--regex-ignore-order)))
  )

(def-package-hook! company-tng
  :post-config
  (define-key! company-active-map
    "RET"       #'company-complete-selection
    [return]    #'company-complete-selection
    "TAB"       #'company-select-next
    [tab]       #'company-select-next
    [backtab]   #'company-select-previous)
  )

(def-package-hook! company
  :post-init
  (setq company-tooltip-limit 20        ; bigger popup window
        company-idle-delay .3
        company-echo-delay 0))

(after! lsp
	(setq lsp-auto-guess-root nil)
)

(doom!
;;; My Stuff

 :parsoj-lang
 ;; emacs-lisp
 java
 puppet
 swift
 xml
 applescript

 :parsoj-app
 ;; discord

 :parsoj-tools
 projects
 tooltip
 eshell
 numbers

 :parsoj-ui
 theme

 :parsoj-tweaks
 perf

;;; Doom's stuff
;;;

 :completion (ivy
              +fuzzy
              +childframe
              +prescient
              +icons
              )
 (company
  +childframe
  +tng
  )

 :ui
 treemacs
 doom-dashboard

 hl-todo
 modeline
 nav-flash
 (popup
  +all
  +defaults)
 (pretty-code
  +fira
  )
 unicode
 vc-gutter
 (window-select
  +numbers
  )
 indent-guides
 ophints
 workspaces

 :editor
 (format
  +onsave
  )
 file-templates
 (evil
  +everywhere)
 fold
 multiple-cursors
 lispy
 rotate-text
 snippets

 :emacs
 (dired
  +ranger
  +icons
  )
 electric
 vc

 :term
 term
 eshell

 :tools
 magit
 debugger
 eval
 docker
 terraform
 (flycheck
  +childframe
  )
 flyspell
 gist
 macos
 make
 (lookup
  +docsets
  )
 prodigy
 lsp
 wakatime

 :lang
 (go
  +lsp
  )
 kotlin
 markdown
 (org
  +attach
  +babel
  +capture
  +export
  +habit
  +present
  +protocol)
 perl
 plantuml
 rest
 ruby
 emacs-lisp


 :app
 regex
 (write
  +langtool
  )
 :config


 :parsoj-org
 org

 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mouse-wheel-progressive-speed nil)
 '(safe-local-variable-values
   '((lsp-java-java-path "/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/bin/java")
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd tst/output" "rm -rf *" "cp ../../target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i ../specs/employment.yaml -o employment" "java -jar mothra.jar gen-project -i ../specs/petstore-expanded.yaml -o petstore-expanded")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd tst/output" "cp ../../target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i ../specs/employment.yaml -o employment" "java -jar mothra.jar gen-project -i ../specs/petstore-expanded.yaml -o petstore-expanded")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd tst" "mkdir output" "cp ../mothra/target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i ../specs/employment.yaml -o employment" "java -jar mothra.jar gen-project -i ../specs/petstore-expanded.yaml -o petstore-expanded")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd tst" "mkdir output" "cp ../mothra/target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i ../api.yaml" "java -jar mothra.jar gen-project -i petstore-expanded.yaml")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd ../" "mkdir -p employment" "cd 1out" "cp ../mothra/target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i api.yaml")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i api.yaml")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/target/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "make mothra_mac" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/target/mothra_mac ." "cp ../api.yaml ." "./mothra_mac gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "rm target/mothra.jar" "make mothra.jar" "make mothra_mac" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra_mac ." "cp ../api.yaml ." "./mothra_mac gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm -rf ./1out" "cd mothra" "make mothra.jar" "make mothra_mac" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra_mac ." "cp ../api.yaml ." "./mothra_mac gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm mothra/mothra_mac;" "rm -rf 1out;" "cd mothra" "make mothra_mac" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra_mac ." "cp ../api.yaml ." "./mothra_mac gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out;" "cd mothra" "make clean-jar" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra_mac ." "cp ../api.yaml ." "./mothra_mac gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out;" "cd mothra" "make clean-jar" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra.jar ." "cp ../api.yaml ." "java -jar mothra.jar gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out;" "cd mothra" "make clean-jar" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-project -i api.yaml")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out;" "cd mothra" "make clean-jar" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out;" "cd mothra" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here nil
                                   (string-join
                                    '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out;" "cd mothra" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                                    " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out;" "cd mothra" "make mothra.jar" "cd ../" "mkdir -p 1out" "cd 1out" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/" "rm mothra/mothra.jar;" "rm -rf 1out" "cd mothra" "make mothra.jar" "cd ../1out" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/mothra" "rm mothra.jar" "make mothra.jar" "cd ../1out" "rm -rf *" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/mothra" "make mothra.jar" "cd ../1out" "rm -rf *;" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell/toggle nil
                                     (string-join
                                      '("cd ~/remitly/mothra2/mothra" "make mothra.jar" "cd ../service" "rm -rf *;" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                                      " && ")))
     (project-runner lambda nil
                     (+eshell:run
                      (string-join
                       '("cd ~/remitly/mothra2/mothra" "make mothra.jar" "cd ../service" "rm -rf *;" "cp ../mothra/mothra.jar ." "cp ../mothra/api.yaml ." "java -jar mothra.jar gen-component -i api.yaml go-handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd ~/remitly/mothra2/mothra" "make mothra.jar" "cd ../service" "rm -rf *;" "java -jar ../mothra/mothra.jar gen-component -i ../mothra/api.yaml go-handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd mothra" "make mothra.jar" "cd ../service" "rm -rf *;" "java -jar ../mothra/mothra.jar gen-component -i ../mothra/api.yaml go-handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd mothra" "make mothra.jar" "cd ../service" "rm -rf *" "java -jar ../mothra/mothra.jar gen-component -i ../mothra/api.yaml go-handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd mothra" "make mothra.jar" "java -jar mothra.jar gen-component -i api.json Handler")
                       "; ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd mothra" "make mothra.jar;" "java -jar mothra.jar gen-component -i api.json Handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd mothra" "make mothra.jar" "java -jar mothra.jar gen-component -i api.json Handler")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("cd mothra" "make mothra.jar")
                       " && ")))
     (project-runner lambda nil
                     (+eshell/here
                      (string-join
                       '("docker run -dit --name mothra mothra" "cd /docker:mothra:/mothra" "/opt/maven/bin/mvn package" "native-image -jar target/mothra.jar" "./target/mothra help")
                       " && ")))))
 '(wakatime-cli-path "/usr/local/bin/wakatime")
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "nil" :slant normal :weight normal :height 120 :width normal)))))
