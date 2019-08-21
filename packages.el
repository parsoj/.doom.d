;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(unless (featurep! :feature evil)
  (package! winum)
  (package! expand-region)
  )

;; need to freeze this guy so we have the osx fix
(package! dash-docs :recipe (dash-docs :fetcher github :repo "parsoj/dash-docs" :branch "fix-osx") :freeze t)
