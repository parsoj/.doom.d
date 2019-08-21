;;; lang/java/config.el -*- lexical-binding: t; -*-
;;;


(add-hook 'java-mode-hook #'rainbow-delimiters-mode)


(def-package! lsp-java
  :after-call java-mode

  :init
  (add-hook 'java-mode-hook #'lsp!)
  (add-hook 'java-mode-hook 'flycheck-mode)
  (set-company-backend! 'java-mode 'company-lsp)


  :config
  (setq lsp-ui-doc-max-height 30
        lsp-ui-doc-max-width 55
        lsp-ui-doc-position 'at-point
        lsp-ui-peek-list-width 65
        lsp-ui-sideline-show-code-actions nil
        ;; lsp-java-jdt-download-url "http://download.eclipse.org/che/che-ls-jdt/snapshots/che-jdt-language-server-latest.tar.gz"
        )
  )


 (map! :localleader
       :map java-mode-map
       (:prefix "g"
         "d" #'lsp-ui-peek-find-definitions
         "r" #'lsp-ui-peek-find-references))

(def-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t)
  )

(def-package! dap-java
  :after (lsp-java)
  )
