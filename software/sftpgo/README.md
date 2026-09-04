# SFTPGo

本目錄依 SFTPGo 版本保存繁體中文化資源與部署方式。

## 版本

- `2.7.0/`：對應 Rocky Linux 8/9 安裝與設定文章，包含文章中的繁體中文核心翻譯內容。
- `2.7.5/`：對應 Windows SFTPGo 2.7.5，包含完整繁體中文 `translation.json`、PowerShell 部署腳本與版本說明。

## 使用原則

不同 SFTPGo 版本的 `translation.json` 不應混用。SFTPGo 升級後，應確認新版英文語系檔的 key 結構，再套用對應版本的繁中翻譯。

Rocky Linux 版本的安裝、設定、日誌與中文化流程來源文章：

https://sungshu.blogspot.com/2026/02/sftpgo-install-setup-guide-linux-rocky.html

文章中的中文化方式是將繁中翻譯內容覆蓋 SFTPGo 的 `en/translation.json`，驗證 JSON 後重新啟動 SFTPGo，並清除瀏覽器 localStorage 翻譯快取。
