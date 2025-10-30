# -*- GNUMakefile -*-
#
# Build Common Core Protcol Buffer bindings on POSIX systems

PROTOC    = protoc
SRC_DIR   = cc
OUT_DIR   = gen
BUF_BIN   = $(HOME)/.local/bin/buf
BUF_SRC   = https://github.com/bufbuild/buf/releases/latest/download/buf-$(shell uname -s)-$(shell uname -m)

define remove
	if [ -e "${1}" ]; then \
		echo "Removing: ${1}"; \
		rm -rf "${1}"; \
	fi
endef


.PHONY: default
default: lint

.PHONY: lint
lint: buf
	@buf lint
	@echo "✅ Checks passed"

.PHONY: check_breaking
check_breaking: buf
	@buf breaking --against '.git#branch=main'
	@echo "✅ No breaking changes"

.PHONY: build
build: generate

.PHONY: generate
generate: bufgenerate
	@echo "✅ Native language bindings generated under 'gen/'"
	@echo
	@echo "Reminder:"
	@echo "    These are provided only as a reference; do not include them in your own build."
	@echo "    Instead, use the build tools from your parent repository (e.g. CMake, pantsbuild,"
	@echo "    buf.build, plain Makefile, etc) to generate native-language bindings".
	@echo

.PHONY: bufgenerate
bufgenerate: buf
	@echo "Generating bindings for multiple languages with 'buf'"
	@buf generate

.PHONY: buf install_buf
buf install_buf: $(BUF_BIN)
	@chmod +x $(BUF_BIN)

.PHONY: clean/buf uninstall_buf
clean/buf uninstall_buf:
	@rm -fv '$(BUF_BIN)'
	@rmdir --ignore-fail-on-non-empty --parents '$(dir $(BUF_BIN))'

.PHONY: clean
clean:
	@$(call remove,$(OUT_DIR))

$(OUT_DIR):
	@mkdir -p '$(OUT_DIR)'

$(BUF_BIN):
	@echo "Fetching and installing: $(BUF_BIN)"
	@mkdir -p '$(dir $(BUF_BIN))'
	@curl -#L '$(BUF_SRC)' -o '$(BUF_BIN)'

### Use `protoc` for C++, Java and Python
.PHONY: cpp java python
cpp: protobuf-cpp grpc-cpp
python: protobuf-python grpc-python
java: protobuf-java grpc-java
cpp python java:
	@echo "✅ Bindings are generated under 'gen/$@/'"

protobuf-%:
	@echo "Generating ProtoBuf bindings for language: $*"
	@mkdir -p '$(OUT_DIR)/$*'
	@find $(SRC_DIR) -name *.proto -exec \
		$(PROTOC) --$*_out=$(OUT_DIR)/$* {} +

grpc-%:
	@echo "Generating gRPC binding for language: $*"
	@mkdir -p '$(OUT_DIR)/$*'
	@find $(SRC_DIR) -name *.proto -exec \
		$(PROTOC) --grpc_out=$(OUT_DIR)/$* --plugin=protoc-gen-grpc=/usr/bin/grpc_$*_plugin {} +

