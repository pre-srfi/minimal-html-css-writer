(define-library (srfi-minimal-html)
  (export write-html
          write-xml)
  (import (scheme base)
          (scheme char)
          (scheme cxr)
          (scheme file)
          (scheme write))
  (begin

    (define (write-generic-ml sxml)
      (define (write-char-safely char)
        (let* ((cc (char->integer char))
               (ok? (case char
                      ((#\& #\< #\> #\") #f)
                      (else (<= #x20 cc #x7e)))))
          (cond (ok?
                 (write-char char))
                (else
                 (write-char #\&)
                 (write-char #\#)
                 (write-char #\x)
                 (write-string (string-upcase (number->string cc 16)))
                 (write-char #\;)))))
      (define (write-string-safely string)
        (string-for-each write-char-safely string))
      (define (write-symbol-safely symbol)
        (write-string-safely (symbol->string symbol)))
      (define (write-attribute attribute)
        (write-char #\space)
        (write-symbol-safely (car attribute))
        (write-char #\=)
        (write-char #\")
        (write-string-safely (cadr attribute))
        (write-char #\"))
      (let write-node ((sxml sxml))
        (cond ((string? sxml)
               (write-string-safely sxml))
              ((pair? sxml)
               (write-char #\<)
               (write-symbol-safely (car sxml))
               (let ((body (cond ((and (pair? (cdr sxml))
                                       (pair? (cadr sxml))
                                       (eq? '@ (car (cadr sxml))))
                                  (for-each write-attribute (cdadr sxml))
                                  (cddr sxml))
                                 (else (cdr sxml)))))
                 (cond ((null? body)
                        (write-char #\space)
                        (write-char #\/)
                        (write-char #\>))
                       (else
                        (write-char #\>)
                        (for-each write-node body)
                        (write-char #\<)
                        (write-char #\/)
                        (write-symbol-safely (car sxml))
                        (write-char #\>)))))
              (else
               (error "Bad:" sxml)))))

    (define (write-html sxml)
      (write-string "<!doctype html>")
      (write-generic-ml sxml)
      (newline))

    (define (write-xml sxml)
      (write-string "<?xml version=\"1.0\" encoding=\"us-ascii\"?>")
      (write-generic-ml sxml)
      (newline))))