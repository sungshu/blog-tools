<#
.SYNOPSIS
    SFTPGo WebAdmin 繁體中文化 (zh-TW) 自動部署腳本

.DESCRIPTION
    此腳本用於在 Windows 環境下一鍵部署 SFTPGo WebAdmin 繁體中文語系。
    - 下載 GitHub 託管的 translation.json 至暫存目錄
    - 驗證 JSON 語法有效性，避免損毀原設定
    - 自動備份原廠 en/translation.json 檔案（僅備份一次）
    - 覆蓋 en 語系檔以強制 WebAdmin 載入繁體中文
    - 修改 base.html 將 localStorage 快取時間設為 0，避免殘留舊英文快取
    - 自動重啟 SFTPGo 服務套用變更

.NOTES
    Author  : sungshu
    Version : 2.7.5
    Website : https://sungshu.github.io
    GitHub  : https://github.com/sungshu/blog-tools
#>

#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

$Version        = '2.7.5'
$Author         = 'sungshu'
$SiteUrl        = 'https://sungshu.github.io'
$TranslationUrl = 'https://raw.githubusercontent.com/sungshu/blog-tools/main/software/sftpgo/2.7.5/translation.json'

$TemplatesBase = 'C:\ProgramData\SFTPGo\templates\common\base.html'
$LocalesRoot   = 'C:\ProgramData\SFTPGo\static\locales'
$EnDir         = Join-Path $LocalesRoot 'en'
$EnFile        = Join-Path $EnDir 'translation.json'
$EnBackup      = Join-Path $EnDir 'translation.json.bak'
$TempFile      = Join-Path $env:TEMP 'sftpgo-translation.json.download'

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  SFTPGo v$Version 繁體中文化部署工具" -ForegroundColor Cyan
Write-Host "  Author: $Author | Website: $SiteUrl" -ForegroundColor DarkGray
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "翻譯來源：$TranslationUrl" -ForegroundColor DarkGray
Write-Host "目標檔案：$EnFile" -ForegroundColor DarkGray

try {
    # 1. 確認目標目錄
    if (!(Test-Path $EnDir)) {
        New-Item -ItemType Directory -Path $EnDir -Force | Out-Null
    }

    # 2. 下載翻譯 JSON，先存暫存檔，避免下載失敗時破壞現有檔案
    Write-Host '[1/5] 正在下載繁體中文翻譯檔...' -ForegroundColor Yellow
    if (Test-Path $TempFile) {
        Remove-Item $TempFile -Force
    }

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $TranslationUrl -OutFile $TempFile -UseBasicParsing

    if (!(Test-Path $TempFile) -or ((Get-Item $TempFile).Length -eq 0)) {
        throw '下載的 translation.json 為空檔案。'
    }

    # 3. 驗證 JSON，確認內容有效後才覆蓋 en/translation.json
    Write-Host '[2/5] 正在驗證 JSON 格式...' -ForegroundColor Yellow
    $DownloadedJson = Get-Content -Path $TempFile -Raw -Encoding UTF8
    $null = $DownloadedJson | ConvertFrom-Json
    Write-Host '[2/5] JSON 驗證成功。' -ForegroundColor Green

    # 4. 備份原始英文檔，只建立一次
    if (Test-Path $EnFile) {
        if (!(Test-Path $EnBackup)) {
            Copy-Item -Path $EnFile -Destination $EnBackup -Force
            Write-Host "[3/5] 已備份原始英文翻譯檔：$EnBackup" -ForegroundColor Green
        } else {
            Write-Host "[3/5] 原始英文備份已存在，保留：$EnBackup" -ForegroundColor DarkGray
        }
    }

    # 5. 使用 UTF-8 無 BOM 寫入 en translation.json
    $Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($EnFile, $DownloadedJson, $Utf8NoBom)
    Write-Host "[4/5] 已使用繁體中文內容覆蓋：$EnFile" -ForegroundColor Green

    # 6. base.html：將 localStorage 快取時間設為 0，避免瀏覽器持續使用舊英文翻譯
    if (Test-Path $TemplatesBase) {
        if (!(Test-Path "$TemplatesBase.bak")) {
            Copy-Item -Path $TemplatesBase -Destination "$TemplatesBase.bak" -Force
            Write-Host '[5/5] 已備份原始 base.html' -ForegroundColor Green
        }

        $htmlContent = Get-Content -Path $TemplatesBase -Raw -Encoding UTF8
        $changed = $false

        if ($htmlContent -match 'expirationTime:\s*7\s*\*\s*24\s*\*\s*60\s*\*\s*60\s*\*\s*1000') {
            $htmlContent = $htmlContent -replace 'expirationTime:\s*7\s*\*\s*24\s*\*\s*60\s*\*\s*60\s*\*\s*1000', 'expirationTime: 0'
            $changed = $true
            Write-Host '[5/5] 已將 localStorage 快取時間修改為 0。' -ForegroundColor Green
        }

        if ($changed) {
            [System.IO.File]::WriteAllText($TemplatesBase, $htmlContent, $Utf8NoBom)
        } else {
            Write-Host '[5/5] base.html 快取時間已設定過，無需修改。' -ForegroundColor DarkGray
        }
    } else {
        Write-Host "[警告] 找不到 base.html：$TemplatesBase" -ForegroundColor Yellow
    }

    # 7. 重啟 SFTPGo 服務
    Write-Host "`n正在重啟 SFTPGo 服務..." -ForegroundColor Yellow
    Stop-Service -Name 'SFTPGo' -Force -ErrorAction SilentlyContinue
    Get-Process -Name 'sftpgo' -ErrorAction SilentlyContinue | Stop-Process -Force
    Start-Sleep -Seconds 2
    Start-Service -Name 'SFTPGo' -ErrorAction Stop

    Write-Host "`n========== SFTPGo $Version 部署完成 ==========" -ForegroundColor Green
    Write-Host '已將 GitHub 上的 translation.json 覆蓋至 en 語系槽位。' -ForegroundColor Cyan
    Write-Host '請重新整理 WebAdmin；第一次載入若仍有舊快取，按一次 Ctrl + F5。' -ForegroundColor Yellow
    Write-Host 'WebAdmin：http://127.0.0.1:8080/web/admin' -ForegroundColor Cyan
}
catch {
    Write-Host "`n[錯誤] $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
finally {
    if (Test-Path $TempFile) {
        Remove-Item $TempFile -Force -ErrorAction SilentlyContinue
    }
}
