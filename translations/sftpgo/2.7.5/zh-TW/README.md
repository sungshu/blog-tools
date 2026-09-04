# SFTPGo 2.7.5｜繁體中文翻譯

本目錄保存 SFTPGo **2.7.5** 使用的繁體中文翻譯檔與部署腳本。

## 檔案

- `translation.json`：從原部署腳本 `$ZhContent` 抽出的完整繁體中文翻譯內容。
- `deploy-sftpgo-zhTW.ps1`：從 GitHub 下載 `translation.json`，驗證 JSON 後覆蓋 SFTPGo 的 `en` 語系檔。

## 部署方式

部署腳本會將：

```text
translations/sftpgo/2.7.5/zh-TW/translation.json
```

下載後覆蓋：

```text
C:\ProgramData\SFTPGo\static\locales\en\translation.json
```

也就是**使用 `en` 語系槽位顯示繁體中文**，並不是新增原生 `zh-TW` 語系。

原始英文檔若尚未備份，會保留為：

```text
C:\ProgramData\SFTPGo\static\locales\en\translation.json.bak
```

另外會將 `base.html` 的 localStorage 翻譯快取時間調整為 `0`，完成後重啟 `SFTPGo` 服務。

## 注意

此版本檔案專門對應 **SFTPGo 2.7.5**。不同 SFTPGo 版本請使用各自版本目錄中的翻譯檔與部署方式，不要直接混用。
