UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
  DYLIB_EXT  := dylib
  DYLIB_FLAG := -dynamiclib
  SSL_CFLAGS := $(shell pkg-config --cflags openssl 2>/dev/null || echo "-I/opt/homebrew/opt/openssl/include")
  SSL_LIBS   := $(shell pkg-config --libs openssl 2>/dev/null || echo "-L/opt/homebrew/opt/openssl/lib -lssl -lcrypto")
else
  DYLIB_EXT  := so
  DYLIB_FLAG := -shared -fPIC
  SSL_CFLAGS := $(shell pkg-config --cflags openssl 2>/dev/null)
  SSL_LIBS   := $(shell pkg-config --libs openssl 2>/dev/null || echo "-lssl -lcrypto")
endif

TARGET := libkaappi_crypto.$(DYLIB_EXT)

all: $(TARGET)

$(TARGET): csrc/kaappi_crypto.c
	$(CC) $(DYLIB_FLAG) -o $@ $< $(SSL_CFLAGS) $(SSL_LIBS) -O2 -Wall -Wextra

clean:
	rm -f $(TARGET)

.PHONY: all clean
