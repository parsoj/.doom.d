;;; lang/java/config.el -*- lexical-binding: t; -*-



;;;###autoload
(defun +java-current-package ()
  "Converts the current file's path into a namespace.

For example: ~/some/project/src/net/lissner/game/MyClass.java
Is converted to: net.lissner.game

It does this by ignoring everything before the nearest package root (see
`+java-project-package-roots' to control what this function considers a package
root)."
  (unless (eq major-mode 'java-mode)
    (user-error "Not in a java-mode buffer"))
  (let* ((project-root (file-truename (doom-project-root)))
         (file-path (file-name-sans-extension
                     (file-truename (or buffer-file-name
                                        default-directory))))
         (src-root (cl-loop for root in +java-project-package-roots
                            if (and (stringp root)
                                    (locate-dominating-file file-path root))
                            return (file-name-directory (file-relative-name file-path (expand-file-name root it)))
                            if (and (integerp root)
                                    (> root 0)
                                    (let* ((parts (split-string (file-relative-name file-path project-root) "/"))
                                           (fixed-parts (reverse (nbutlast (reverse parts) root))))
                                      (when fixed-parts
                                        (string-join fixed-parts "/"))))
                            return it)))
    (when src-root
      (string-remove-suffix "." (replace-regexp-in-string "/" "." src-root)))))

;;;###autoload
(defun +java-current-class ()
  "Get the class name for the current file."
  (unless (eq major-mode 'java-mode)
    (user-error "Not in a java-mode buffer"))
  (unless buffer-file-name
    (user-error "This buffer has no filepath; cannot guess its class name"))
  (or (file-name-sans-extension (file-name-base (buffer-file-name)))
      "ClassName"))
