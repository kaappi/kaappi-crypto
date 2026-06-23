(define-library (kaappi crypto ffi)
  (import (scheme base) (kaappi ffi))
  (export %sha256 %sha1 %sha512 %md5
          %set-key %set-msg
          %hmac-sha256 %hmac-sha1 %hmac-sha512 %hmac-md5)
  (begin

    (define %lib (ffi-open "libkaappi_crypto"))

    ;; Hashing
    (define %sha256 (ffi-fn %lib "kcrypto_sha256" '(string) 'string))
    (define %sha1   (ffi-fn %lib "kcrypto_sha1"   '(string) 'string))
    (define %sha512 (ffi-fn %lib "kcrypto_sha512" '(string) 'string))
    (define %md5    (ffi-fn %lib "kcrypto_md5"    '(string) 'string))

    ;; HMAC setup
    (define %set-key (ffi-fn %lib "kcrypto_set_key" '(string) 'void))
    (define %set-msg (ffi-fn %lib "kcrypto_set_msg" '(string) 'void))

    ;; HMAC compute
    (define %hmac-sha256 (ffi-fn %lib "kcrypto_hmac_sha256" '() 'string))
    (define %hmac-sha1   (ffi-fn %lib "kcrypto_hmac_sha1"   '() 'string))
    (define %hmac-sha512 (ffi-fn %lib "kcrypto_hmac_sha512" '() 'string))
    (define %hmac-md5    (ffi-fn %lib "kcrypto_hmac_md5"    '() 'string))))
