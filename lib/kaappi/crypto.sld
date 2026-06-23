(define-library (kaappi crypto)
  (import (scheme base)
          (kaappi crypto ffi))
  (export sha256 sha1 sha512 md5
          hmac-sha256 hmac-sha1 hmac-sha512 hmac-md5)
  (begin

    (define (sha256 str) (%sha256 str))
    (define (sha1 str)   (%sha1 str))
    (define (sha512 str) (%sha512 str))
    (define (md5 str)    (%md5 str))

    (define (hmac-sha256 key msg)
      (%set-key key) (%set-msg msg) (%hmac-sha256))

    (define (hmac-sha1 key msg)
      (%set-key key) (%set-msg msg) (%hmac-sha1))

    (define (hmac-sha512 key msg)
      (%set-key key) (%set-msg msg) (%hmac-sha512))

    (define (hmac-md5 key msg)
      (%set-key key) (%set-msg msg) (%hmac-md5))))
