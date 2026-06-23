(import (kaappi crypto))

(display "SHA-256 of 'hello': ")
(display (sha256 "hello"))
(newline)

(display "MD5 of 'hello': ")
(display (md5 "hello"))
(newline)

(display "HMAC-SHA256: ")
(display (hmac-sha256 "secret-key" "message to sign"))
(newline)
