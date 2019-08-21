;; I'm using use-package and el-get and evil

(def-package! slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "remitly"
   :default t
   :token "xxxx"
   :full-and-display-names t)
  )

(def-package! alert
  :commands (alert)
  :init
  (setq alert-default-style 'osx-notifier))
