# SFTPGo 2.7.0｜Rocky Linux 繁體中文化

本目錄對應 `sungshu手札筆記本` 的 SFTPGo 2.7.0 Rocky Linux 8/9 安裝與設定文章。

文章內容包含：

- Rocky Linux 8/9 系統準備
- SFTPGo Yum Repository 與 systemd
- `/var/sftp/users`、`/var/sftp/share` 目錄規劃
- WebAdmin、群組與使用者設定
- JSON 日誌、輪替與 `/etc/sftpgo/sftpgo.env`
- WebAdmin 繁體中文化
- `en/translation.json` 備份、覆蓋與 JSON 驗證
- 瀏覽器 localStorage / i18next 快取清除
- 常見問題與升級後重新套用中文化

## 繁體中文化方式

此版本使用繁中內容覆蓋 SFTPGo 的：

```text
/usr/share/sftpgo/static/locales/en/translation.json
```

套用前先備份原始英文檔，使用 `python3 -m json.tool` 驗證 JSON，完成後重新啟動 SFTPGo。

## 翻譯檔

`translation.json` 保存文章中提供的 SFTPGo 2.7.0 繁體中文核心翻譯內容。文章本身標示這份內容為「100+ 行核心 JSON 翻譯」，不是完整 SFTPGo 全部語系字典。

若日後取得完整版本，應以完整版本取代此檔，但仍保留在 `2.7.0` 目錄，不覆蓋其他 SFTPGo 版本。

## 原始文章

https://sungshu.blogspot.com/2026/02/sftpgo-install-setup-guide-linux-rocky.html
