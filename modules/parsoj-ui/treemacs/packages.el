;; -*- no-byte-compile: t; -*-
;;; ui/treemacs/packages.el

(package! treemacs)
(when (featurep! :editor evil +everywhere)
  (package! treemacs-evil))
(package! treemacs-projectile)
(package! treemacs-magit)
