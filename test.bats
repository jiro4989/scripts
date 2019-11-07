#!/usr/bin/env bats

coverage() {
  # kcovのインストールされている環境でのみ実行
  if which kcov >& /dev/null; then
    kcov coverage "$@" || true
  fi
}

@test "5ktrillion" {
  coverage 5ktrillion
  coverage thx System
  coverage color 1f
  coverage rainbow -f ansi_f -t text
  coverage thx test
}
