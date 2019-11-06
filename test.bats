#!/usr/bin/env bats

coverage() {
  echo "Start coverage"
  # kcovのインストールされている環境でのみ実行
  if which kcov >& /dev/null; then
    echo "kcov was installed"
    local options=("--tap")
    #local options=(--bash-dont-parse-binary-dir)

    # CI上で実行されているときだけオプションを追加
    if [[ ! "$TRAVIS_JOB_ID" == "" ]]; then
      echo "Set options"
      options+=("--coveralls-id=$TRAVIS_JOB_ID")
    fi

    echo kcov "${options[@]}" coverage "$@"
    kcov "${options[@]}" coverage "$@" || true
  fi
}

@test "5ktrillion" {
  # run bash -c "5ktrillion"
  # [ "$status" -eq 0 ]
  coverage 5ktrillion
  coverage thx System

  # run bash -c "5ktrillion -h"
  # [ "$status" -eq 0 ]
  #
  # run bash -c "5ktrillion -v"
  # [ "$status" -eq 0 ]
  #
  # run bash -c "5ktrillion -n"
  # [ "$status" -eq 0 ]
  #
  # run bash -c "5ktrillion -g"
  # [ "$status" -eq 0 ]
  #
  # run bash -c "5ktrillion -u ドル"
  # [ "$status" -eq 0 ]
  #
  # run bash -c "5ktrillion 1 2 3 4 5"
  # [ "$status" -eq 0 ]
  #
  # run bash -c "5ktrillion -n -f -g -u ジンバブエドル"
  # [ "$status" -eq 0 ]
  #
  # run bash -c "5ktrillion -5 -n -f -g -u ジンバブエドル 1"
  # [ "$status" -eq 0 ]
  # [ "$output" = "5000兆円欲しい！" ]
  #
  # run bash -c "5ktrillion --5000-cho-yen-hosii"
  # [ "$status" -eq 0 ]
  # [ "$output" = "5000兆円欲しい！" ]
}

@test "color" {
  run bash -c "color 1f"
  [ "$output" = '[30m  \x1b[30m  [m[31m  \x1b[31m  [m[32m  \x1b[32m  [m[33m  \x1b[33m  [m[34m  \x1b[34m  [m[35m  \x1b[35m  [m[36m  \x1b[36m  [m[37m  \x1b[37m  [m' ]
  [ "$status" -eq 0 ]

  run bash -c "color 1b"
  [ "$status" -eq 0 ]

  run bash -c "color 256f"
  [ "$status" -eq 0 ]

  run bash -c "color 256b"
  [ "$status" -eq 0 ]

  run bash -c "color a"
  [ "$status" -ne 0 ]
}

@test "rainbow" {
  run bash -c "rainbow -f ansi_f -t text"
#   [ "$output" = '[38;2;255;0;0mtext[m
# [38;2;255;13;0mtext[m
# [38;2;255;26;0mtext[m
# [38;2;255;39;0mtext[m
# [38;2;255;52;0mtext[m
# [38;2;255;69;0mtext[m
# [38;2;255;106;0mtext[m
# [38;2;255;143;0mtext[m
# [38;2;255;180;0mtext[m
# [38;2;255;217;0mtext[m
# [38;2;255;255;0mtext[m
# [38;2;204;230;0mtext[m
# [38;2;153;205;0mtext[m
# [38;2;102;180;0mtext[m
# [38;2;51;155;0mtext[m
# [38;2;0;128;0mtext[m
# [38;2;0;103;51mtext[m
# [38;2;0;78;102mtext[m
# [38;2;0;53;153mtext[m
# [38;2;0;28;204mtext[m
# [38;2;0;0;255mtext[m
# [38;2;15;0;230mtext[m
# [38;2;30;0;205mtext[m
# [38;2;45;0;180mtext[m
# [38;2;60;0;155mtext[m
# [38;2;75;0;130mtext[m
# [38;2;107;26;151mtext[m
# [38;2;139;52;172mtext[m
# [38;2;171;78;193mtext[m
# [38;2;203;104;214mtext[m
# [38;2;238;130;238mtext[m
# [38;2;241;104;191mtext[m
# [38;2;244;78;144mtext[m
# [38;2;247;52;97mtext[m
# [38;2;250;26;50mtext[m' ]
  [ "$status" -eq 0 ]

  # run bash -c "rainbow -f test -t text"
  # [ "$status" -ne 0 ]
  run bash -c "rainbow text"
  [ "$status" -ne 0 ]
}

@test "thx stdin" {
  run bash -c 'echo オペレータ | thx'
  [ "$status" -eq 0 ]
  [ "$(grep オペレータ <<< $output | wc -l)" -eq 1 ]
}

@test "thx -h" {
  run thx -h
  [ "$status" -eq 0 ]
  [ "$(grep ありがとう <<< ${lines[0]} | wc -l)" -eq 1 ]
}

@test "thx --help" {
  run thx --help
  [ "$status" -eq 0 ]
  [ "$(grep ありがとう <<< ${lines[0]} | wc -l)" -eq 1 ]
}

@test "thx -v" {
  run thx -v
  [ "$status" -eq 0 ]
  [ "$(grep scripts <<< $output | wc -l)" -eq 1 ]
}

@test "thx --version" {
  run thx --version
  [ "$status" -eq 0 ]
  [ "$(grep scripts <<< $output | wc -l)" -eq 1 ]
}

@test "thx <target>" {
  run thx システム管理者
  [ "$status" -eq 0 ]
  [ "$(grep システム管理者 <<< $output | wc -l)" -eq 1 ]
}

@test "thx <target1> <target2>" {
  run thx システム管理者 オペレータ
  [ "$status" -eq 0 ]
  [ "$(grep システム管理者 <<< ${lines[0]} | wc -l)" -eq 1 ]
  [ "$(grep オペレータ <<< ${lines[1]} | wc -l)" -eq 1 ]
}
