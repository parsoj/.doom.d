;;; -*- lexical-binding: t; -*-


;;;###autoload
(defun show-poppy (buf)
  (posframe-show  buf
                  :position (point)
                  :width 20
                  :height 20
                  :timeout 2
                  :foreground-color (doom-color 'fg)
                  :background-color (doom-color 'bg)
                  )
  )
