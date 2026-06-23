#include <string.h>
#include <stdlib.h>
#include <openssl/evp.h>
#include <openssl/hmac.h>

/* All functions use a static hex buffer for output.
   Single-threaded, so global state is safe. */

static char hex_buf[256];

static void to_hex(const unsigned char *data, int len) {
    static const char hex_chars[] = "0123456789abcdef";
    for (int i = 0; i < len && i < 127; i++) {
        hex_buf[i * 2]     = hex_chars[(data[i] >> 4) & 0xf];
        hex_buf[i * 2 + 1] = hex_chars[data[i] & 0xf];
    }
    hex_buf[len * 2] = '\0';
}

/* ---- Hashing ---- */

static const char *hash_string(const char *alg_name, const char *input) {
    const EVP_MD *md = EVP_get_digestbyname(alg_name);
    if (!md) return "";
    unsigned char digest[EVP_MAX_MD_SIZE];
    unsigned int digest_len = 0;
    EVP_MD_CTX *ctx = EVP_MD_CTX_new();
    if (!ctx) return "";
    EVP_DigestInit_ex(ctx, md, NULL);
    EVP_DigestUpdate(ctx, input, strlen(input));
    EVP_DigestFinal_ex(ctx, digest, &digest_len);
    EVP_MD_CTX_free(ctx);
    to_hex(digest, digest_len);
    return hex_buf;
}

/* (string) -> string */
const char *kcrypto_sha256(const char *input) {
    return hash_string("SHA256", input);
}

/* (string) -> string */
const char *kcrypto_sha1(const char *input) {
    return hash_string("SHA1", input);
}

/* (string) -> string */
const char *kcrypto_sha512(const char *input) {
    return hash_string("SHA512", input);
}

/* (string) -> string */
const char *kcrypto_md5(const char *input) {
    return hash_string("MD5", input);
}

/* ---- HMAC ---- */

/* Set-then-execute pattern for HMAC (key + message = 2 args,
   but we need to specify the algorithm too) */

static char stored_key[4096];
static char stored_msg[16384];

/* (string) -> void */
void kcrypto_set_key(const char *key) {
    strncpy(stored_key, key, sizeof(stored_key) - 1);
    stored_key[sizeof(stored_key) - 1] = '\0';
}

/* (string) -> void */
void kcrypto_set_msg(const char *msg) {
    strncpy(stored_msg, msg, sizeof(stored_msg) - 1);
    stored_msg[sizeof(stored_msg) - 1] = '\0';
}

static const char *hmac_compute(const char *alg_name) {
    const EVP_MD *md = EVP_get_digestbyname(alg_name);
    if (!md) return "";
    unsigned char result[EVP_MAX_MD_SIZE];
    unsigned int result_len = 0;
    HMAC(md,
         stored_key, strlen(stored_key),
         (unsigned char *)stored_msg, strlen(stored_msg),
         result, &result_len);
    to_hex(result, result_len);
    return hex_buf;
}

/* () -> string */
const char *kcrypto_hmac_sha256(void) {
    return hmac_compute("SHA256");
}

/* () -> string */
const char *kcrypto_hmac_sha1(void) {
    return hmac_compute("SHA1");
}

/* () -> string */
const char *kcrypto_hmac_sha512(void) {
    return hmac_compute("SHA512");
}

/* () -> string */
const char *kcrypto_hmac_md5(void) {
    return hmac_compute("MD5");
}
