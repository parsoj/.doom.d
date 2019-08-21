;;; lang/sgml/config.el -*- lexical-binding: t; -*-

(def-package! nxml-mode
  :init
  (add-hook 'before-save-hook
            '(lambda ()
               (when (eq major-mode 'nxml-mode)
                 (reformat-xml-buffer))))
  )
