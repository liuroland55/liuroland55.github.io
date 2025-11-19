@echo off
chcp 65001
setlocal enabledelayedexpansion

REM 检查是否在 Hexo 根目录
if not exist "_config.yml" (
  echo [错误] 当前目录不是 Hexo 项目根目录，未找到 _config.yml。
  goto end
)

REM 清理旧文件
echo 正在清理 Hexo 缓存...
call npx.cmd hexo clean
if errorlevel 1 (
  echo [错误] hexo clean 执行失败。
  goto end
)

REM 生成静态文件
echo 正在生成博客内容...
call npx.cmd hexo generate
if errorlevel 1 (
  echo [错误] hexo generate 执行失败。
  goto end
)

REM 检查是否有更改
for /f "tokens=1" %%a in ('git status --porcelain ^| find /v "" /c') do set CHANGED=%%a
if "!CHANGED!"=="0" (
  echo 没有检测到更改，跳过提交。
) else (
  echo 添加更改到 Git...
  git add .

  echo 提交更改...
  git commit -m "一键更新博客"
  if errorlevel 1 (
    echo [错误] git commit 执行失败。
    goto end
  )
)

REM 推送到 GitHub
echo 正在推送到远程仓库...
git push origin main
if errorlevel 1 (
  echo [错误] git push 执行失败。
  goto end
)

echo [成功] 博客更新已推送，GitHub Actions 将自动部署。
:end
echo.
echo 脚本执行完毕，按任意键关闭窗口。
pause
