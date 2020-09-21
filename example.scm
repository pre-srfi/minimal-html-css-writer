(import (scheme base) (scheme file) (srfi-minimal-html))

(with-output-to-file "example.html"
  (lambda ()
    (let ((title "Hello, 世界"))
      (write-html
       `(html
         (head
          (title ,title))
         (body
          (h1 ,title)
          (p (a (@ (href "http://scheme.org"))
                "Scheme!"))
          (ul
           (li "One")
           (li "Two"
               (ul (li "Three")
                   (li "Four")))
           (li "Five"))))))))
