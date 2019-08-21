(setq doom-sql-highlightable sql-product-alist
      doom-sql-startable (remove-if-not
                          (lambda (product) (sql-get-product-feature (car product) :sqli-program))
                          sql-product-alist)

      ;; should not set this to anything else than nil
      ;; the focus of SQLi is handled by doom conventions
      sql-pop-to-buffer-after-send-region nil)

;;;###autoload
(defun doom//sql-source (products)
  "return a source for helm selection"
  `((name . "SQL Products")
    (collection . ,(mapcar
                    (lambda (product)
                      (cons (sql-get-product-feature (car product) :name) (car product))
                      )products))
    (action . (lambda (candidate) (helm-marked-candidates)))))

;;;###autoload
(defun doom/sql-highlight ()
  "set SQL dialect-specific highlighting"
  (interactive)
  (let ((product (car (helm
                       :sources (list (doom//sql-source doom-sql-highlightable))))))
    (sql-set-product product)))

;;;###autoload
(defun doom/sql-start ()
  "set SQL dialect-specific highlighting and start inferior SQLi process"
  (interactive)
  (let ((product (car (helm
                       :sources (list (doom//sql-source doom-sql-startable))))))
    (sql-set-product product)
    (sql-product-interactive product)))

;;;###autoload
(defun doom/sql-send-string-and-focus ()
  "Send a string to SQLi and switch to SQLi in `insert state'."
  (interactive)
  (let ((sql-pop-to-buffer-after-send-region t))
    (call-interactively 'sql-send-string)
    (evil-insert-state)))

;;;###autoload
(defun doom/sql-send-buffer-and-focus ()
  "Send the buffer to SQLi and switch to SQLi in `insert state'."
  (interactive)
  (let ((sql-pop-to-buffer-after-send-region t))
    (sql-send-buffer)
    (evil-insert-state)))

;;;###autoload
(defun doom/sql-send-paragraph-and-focus ()
  "Send the paragraph to SQLi and switch to SQLi in `insert state'."
  (interactive)
  (let ((sql-pop-to-buffer-after-send-region t))
    (sql-send-paragraph)
    (evil-insert-state)))

;;;###autoload
(defun doom/sql-send-region-and-focus (start end)
  "Send region to SQLi and switch to SQLi in `insert state'."
  (interactive "r")
  (let ((sql-pop-to-buffer-after-send-region t))
    (sql-send-region start end)
    (evil-insert-state)))
