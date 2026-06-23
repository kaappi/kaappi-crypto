(import (scheme base) (scheme write)
        (kaappi crypto))

(define pass 0)
(define fail 0)

(define-syntax check
  (syntax-rules (=>)
    ((_ expr => expected)
     (let ((result expr) (exp expected))
       (if (equal? result exp)
           (set! pass (+ pass 1))
           (begin
             (set! fail (+ fail 1))
             (display "FAIL: ") (write 'expr)
             (display " => ") (write result)
             (display ", expected ") (write exp)
             (newline)))))))

;; --- SHA-256 (NIST test vectors) ---

(display "SHA-256\n")

(check (sha256 "")
  => "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")

(check (sha256 "abc")
  => "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")

(check (sha256 "hello")
  => "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824")

;; --- SHA-1 ---

(display "SHA-1\n")

(check (sha1 "")
  => "da39a3ee5e6b4b0d3255bfef95601890afd80709")

(check (sha1 "abc")
  => "a9993e364706816aba3e25717850c26c9cd0d89d")

;; --- SHA-512 ---

(display "SHA-512\n")

(check (sha512 "abc")
  => "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f")

;; --- MD5 ---

(display "MD5\n")

(check (md5 "")
  => "d41d8cd98f00b204e9800998ecf8427e")

(check (md5 "hello")
  => "5d41402abc4b2a76b9719d911017c592")

;; --- HMAC-SHA256 (RFC 4231 test vector) ---

(display "HMAC-SHA256\n")

(check (hmac-sha256 "key" "The quick brown fox jumps over the lazy dog")
  => "f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8")

;; --- HMAC-SHA1 ---

(display "HMAC-SHA1\n")

(check (hmac-sha1 "key" "The quick brown fox jumps over the lazy dog")
  => "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9")

;; --- HMAC-MD5 (RFC 2104 test vector) ---

(display "HMAC-MD5\n")

(check (hmac-md5 "key" "The quick brown fox jumps over the lazy dog")
  => "80070713463e7749b90c2dc24911e275")

;; --- Summary ---

(newline)
(display pass) (display " passed, ")
(display fail) (display " failed\n")
(when (> fail 0) (exit 1))
