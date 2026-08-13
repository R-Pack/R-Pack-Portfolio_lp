#!/bin/bash
cd "$(dirname "$0")"
cp -f ~/Desktop/R-Pack-LP.html ./index.html
if git diff --quiet && git diff --cached --quiet; then
  echo "変更はありません。すでに最新です。"
else
  git add -A && git commit -q -m "更新 $(date '+%Y-%m-%d %H:%M')"
  git push -q origin main && echo "公開しました。1分ほどでサイトに反映されます。"
fi
echo; echo "このウィンドウは閉じて大丈夫です。"
