@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

title Hexo 博客自动部署脚本

echo ========================================
echo    Hexo 博客自动部署工具 v2.0
echo ========================================
echo.

REM 检查 Hexo 是否安装
where hexo > nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Hexo，请先安装 Hexo
    echo 运行: npm install -g hexo-cli
    pause
    exit /b 1
)
echo [√] Hexo 已安装
echo.

REM 检查 Git 是否安装
where git > nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Git，请先安装 Git
    pause
    exit /b 1
)
echo [√] Git 已安装
echo.

REM 检查是否有更改
git status --short
if %errorlevel% neq 0 (
    echo [警告] Git status 检查失败
) else (
    echo [√] Git 状态正常
)
echo.

REM 步骤 1: 清理缓存
echo ========================================
echo 步骤 1/4: 清理 Hexo 缓存
echo ========================================
call npx hexo clean
if %errorlevel% neq 0 (
    echo [错误] 清理缓存失败
    pause
    exit /b 1
)
echo [√] 缓存清理完成
echo.

REM 步骤 2: 生成静态文件
echo ========================================
echo 步骤 2/4: 生成静态文件
echo ========================================
call npx hexo generate
if %errorlevel% neq 0 (
    echo [错误] 生成静态文件失败
    pause
    exit /b 1
)
echo [√] 静态文件生成完成
echo.

REM 步骤 3: 提交更改
echo ========================================
echo 步骤 3/4: 提交更改到 Git
echo ========================================
git add .

REM 检查是否有暂存的更改
git diff --cached --quiet
if %errorlevel% equ 0 (
    echo [提示] 没有新的更改需要提交
    goto :skip_commit
)

REM 获取当前时间作为提交信息
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set mydate=%%a-%%b-%%c
for /f "tokens=1-2 delims=:." %%a in ('time /t') do set mytime=%%a:%%b

set commit_msg=博客更新 - %mydate% %mytime%

echo [信息] 提交信息: %commit_msg%
git commit -m "%commit_msg%"
if %errorlevel% neq 0 (
    echo [错误] Git 提交失败
    pause
    exit /b 1
)
echo [√] 提交完成
echo.

:skip_commit

REM 步骤 4: 推送到 GitHub
echo ========================================
echo 步骤 4/4: 推送到 GitHub
echo ========================================

REM 检查远程仓库
git remote -v > nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未配置 Git 远程仓库
    echo 请运行: git remote add origin ^<你的仓库地址^>
)

git push origin main
if %errorlevel% neq 0 (
    echo ========================================
    echo [错误] 推送失败！
    echo ========================================
    echo.
    echo 可能的原因:
    echo 1. 网络连接问题
    echo 2. Git 认证失败（需要 GitHub Token 或 SSH 密钥）
    echo 3. 远程仓库不存在
    echo 4. 分支名称错误（当前: main）
    echo.
    echo 诊断信息:
    git remote -v
    git branch
    echo.
    echo 请检查上述信息后重试
    echo ========================================
    pause
    exit /b 1
)

echo [√] 推送成功！
echo.
echo ========================================
echo    🎉 博客已成功部署到 GitHub！
echo    访问: https://liuroland55.github.io
echo ========================================
echo.

REM 询问是否打开网站
choice /c yn /m "是否打开网站查看？[Y/N]"
if %errorlevel% equ 1 (
    start https://liuroland55.github.io
)

echo.
echo 按任意键退出...
pause > nul
