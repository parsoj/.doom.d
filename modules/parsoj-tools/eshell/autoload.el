;;; parsoj-tools/eshell/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +eshell--unused-buffer (&optional new-p)
  (or (unless new-p
        (cl-loop for buf in (+eshell-buffers)
                 if (and (buffer-live-p buf)
                         (not (get-buffer-window buf t)))
                 return buf))
      (generate-new-buffer eshell-buffer-name)))

;;;###autoload
(defun +eshell/home (&optional command)
  "Open eshell in the current buffer."
  (interactive "P")
  (when (eq major-mode 'eshell-mode)
    (user-error "Already in an eshell buffer"))
  (cd "~/")
  (let ((buf (+eshell--unused-buffer)))
    (with-current-buffer (switch-to-buffer buf)
      (if (eq major-mode 'eshell-mode)
          (run-hooks 'eshell-mode-hook)
        (eshell-mode))
      (when command
        (+eshell-run-command command buf)))
    buf))
