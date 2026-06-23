# kaappi-crypto

Cryptographic hashing and HMAC for [Kaappi Scheme](https://github.com/kaappi/kaappi).

Uses OpenSSL via C FFI.

## Install

```bash
thottam install kaappi-crypto
```

Requires OpenSSL:
- macOS: `brew install openssl`
- Linux: `sudo apt install libssl-dev`

## Quick start

```scheme
(import (kaappi crypto))

(sha256 "hello")
;=> "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"

(hmac-sha256 "secret-key" "message")
;=> "..."
```

## API

### Hashing

```scheme
(sha256 string)    ; SHA-256 hash, returns hex string
(sha512 string)    ; SHA-512 hash
(sha1 string)      ; SHA-1 hash
(md5 string)       ; MD5 hash
```

### HMAC

```scheme
(hmac-sha256 key message)    ; HMAC-SHA256, returns hex string
(hmac-sha512 key message)    ; HMAC-SHA512
(hmac-sha1 key message)      ; HMAC-SHA1
(hmac-md5 key message)       ; HMAC-MD5
```

All functions accept strings and return lowercase hex-encoded strings.

## License

MIT
