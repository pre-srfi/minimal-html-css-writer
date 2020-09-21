#!r6rs
(import (rnrs) (only (chezscheme) pretty-print))

(define (append-map mapfun xs)
  (fold-left (lambda (acc x) (append acc (mapfun x))) '() xs))

(define (translate x)
  (case (car x)
    ((import)
     `((import (rename (rnrs) put-string write-string))))
    ((begin)
     (cdr x))
    (else
     (list x))))

(let ((r7rs-form (with-input-from-file "srfi-minimal-html.sld" read)))
  (let ((r6rs-form `(library ,@(append-map translate (cdr r7rs-form)))))
    (with-output-to-file "srfi-minimal-html.sls"
      (lambda ()
        (display "#!r6rs\n")
        (display ";; Auto-generated\n")
        (display "#!r6rs\n")
        (pretty-print r6rs-form)))))
