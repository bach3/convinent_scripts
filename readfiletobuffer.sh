#!/bin/bash

# 読み込むファイルのパス
file_path="/home/ec2-user/data.txt"

# バッファサイズ（100バイトずつ読み込む）
buffer_size=100

# ファイルディスクリプタを使ってファイルを開く
exec 3< "$file_path"

# バッファを使ってファイルを100バイトずつ処理するループ
while IFS= read -r -n "$buffer_size" buffer
do
  # 読み込んだデータを表示
  echo "バッファ内容: $buffer"

  # ここでバッファの内容を処理
  # 例えば、100バイトずつ何かしらの処理をしたい場合に使います
  # 例：バッファの内容を分割したり、特定の文字列を探したり

done <&3

# ファイルディスクリプタを閉じる
exec 3<&-
