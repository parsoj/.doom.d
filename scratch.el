(progn
  (with-current-buffer (get-buffer-create  "foo")
    (eval
     `(progn
        (insert "test A B C")
        ) t ))
  (show-poppy (get-buffer-create "foo"))
  )
