;;; parsoj-tools/eshell/config.el -*- lexical-binding: t; -*-


  (after! em-term
    (pushnew! eshell-visual-subcommands '(("make" "mothra.jar") ("docker" "build")))
    )
