;;; lang/go-lsp/config.el -*- lexical-binding: t; -*-

(def-package! go-mode)

(add-hook! 'go-mode-hook #'lsp)
