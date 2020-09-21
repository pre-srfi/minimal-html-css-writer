#!r6rs
(import (rnrs) (only (chezscheme) pretty-print))

(define (append-map f xs)
  (fold-left (lambda (acc x) (append acc (f x))) '() xs))

(define (translate x)
  (case (car x)
    ((import) `((import (rnrs))))
    ((begin) `((define (write-string s) (put-string (current-output-port) s))
               ,@(cdr x)))
    (else `(,x))))

(let ((r7rs-form (with-input-from-file "srfi-minimal-html.sld" read)))
  (let ((r6rs-form `(library ,@(append-map translate (cdr r7rs-form)))))
    (with-output-to-file "srfi-minimal-html.sls"
      (lambda ()
        (display ";; Auto-generated\n")
        (display "#!r6rs\n")
        (pretty-print r6rs-form)))))
