#!/bin/bash

# 終了ステータスは以下の通りとする
# 0: 正常終了
# 1: 引数の数が2ではない
# 2: 引数が自然数ではない
# 3: 引数が整数の最大値を超えている

CHECK_ARG_COUNT () {
    if [ $# -ne 2 ]; then
        echo "引数を2つ入力してください"
        exit 1
    fi
}


CHECK_IS_NATURAL_NUMBER () {
    # exprは解が0のときに終了ステータス1を返す
    # exprは引数が整数でないときに終了ステータス2を返す
    expr $1 + 0 >/dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo "$1 は自然数ではありません"
        exit 2
    # 整数の最大値を超えているか確認する
    # オーバーフローして文字列として一致しないことを確認する
    elif [ $(( $1 + 0 )) != $1 ]; then
        echo "整数の最大値を超えています"
        exit 3
    # 負の数か確認する
    elif [ $1 -lt 0 ]; then
        echo "$1 は自然数ではありません"
        exit 2
    fi
}


CALCULATE_GREATEST_COMMON_DIVISOR () {
    # ユークリッドの互除法で最大公約数を求める
    if [ $1 -ge $2 ]; then
        a=$1
        b=$2
    else
        a=$2
        b=$1
    fi

    remainder=1 # 初期値
    while [ ${remainder} -gt 0 ]; do
        remainder=$(( ${a} % ${b} )) 

        a=${b}
        b=${remainder}
    done

    echo "$1 と $2 の最大公約数は $a です"
}

# Main
CHECK_ARG_COUNT $@

for i in "$@"; do
    CHECK_IS_NATURAL_NUMBER ${i}
done

CALCULATE_GREATEST_COMMON_DIVISOR $1 $2