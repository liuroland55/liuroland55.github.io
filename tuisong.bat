@echo off
setlocal enabledelayedexpansion


if not exist "_config.yml" (
  echo [错误] 当前目录不是 Hexo 项目根目录，未找到 _config.yml。
  goto end
)

echo 清理旧文件..
npx hexo clean
if errorlevel 1 (
  echo [错误] hexo clean 执行失败。
  goto end
)


npx hexo generate
if errorlevel 1 (
  echo [错误] hexo generate 执行失败。
  goto end
)


for /f "tokens=1" %%a in ('git status --porcelain ^| find /v "" /c') do set CHANGED=%%a
if "!CHANGED!"=="0" (
  echo 没有检测到更改，跳过提交。
) else (
  echo 添加更改...
  git add .

  echo 提交更改...
  git commit -m "一键更新博客"
  if errorlevel 1 (
    echo [错误] git commit 执行失败。
    goto end
  )
)

echo 推送到 GitHub...
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
