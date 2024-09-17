#!/bin/bash

# 読み込むファイルのパス
file_path="/home/ec2-user/file.dat"

# ファイルからデータを1行として読み込む
data=$(cat "$file_path")

# 読み込んだデータを確認
echo "ファイルの内容: $data"

# 文字列を固定長で分割
# 例：データが "アプルオレンジスイカ" の場合、各データの長さを指定
apple=${data:0:3}       # アプルは先頭から3文字
orange=${data:3:4}      # オレンジは3文字目から4文字
watermelon=${data:7:3}  # スイカは7文字目から3文字

# 結果を表示
echo "アプル: $apple"
echo "オレンジ: $orange"
echo "スイカ: $watermelon"
