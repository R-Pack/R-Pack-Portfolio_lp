#!/bin/bash
cd "$(dirname "$0")"
SRC=~/Desktop/R-Pack-LP.html
echo "自動公開を開始しました。"
echo "R-Pack-LP.html を保存すると、約30秒後にサイトへ反映されます。"
echo "止めるときは、このウィンドウを閉じるか control+C を押してください。"
echo
last=""
while true; do
  now=$(stat -f %m "$SRC" 2>/dev/null)
  if [ -n "$now" ] && [ "$now" != "$last" ]; then
    if [ -n "$last" ]; then
      sleep 3
      cp -f "$SRC" ./index.html
      if ! (git diff --quiet && git diff --cached --quiet); then
        git add -A && git commit -q -m "更新 $(date '+%Y-%m-%d %H:%M')"
        if git push -q origin main 2>/dev/null; then
          echo "[$(date '+%H:%M:%S')] 公開しました"
        else
          echo "[$(date '+%H:%M:%S')] 送信に失敗しました（通信かGitHubの設定をご確認ください）"
        fi
      fi
    fi
    last="$now"
  fi
  sleep 10
done
