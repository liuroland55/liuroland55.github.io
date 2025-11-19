@echo off
chcp 65001
setlocal enabledelayedexpansion

echo 正在清理 Hexo 缓存...
call npx.cmd hexo clean

echo 正在生成博客内容...
call npx.cmd hexo generate

echo 正在提交更改...
git add .
git commit -m "更新博客"
git push origin main

echo 博客已更新并推送，按任意键退出。
pause
