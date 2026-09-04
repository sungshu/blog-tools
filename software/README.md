# 軟體工具與版本檔案

本目錄統一保存開源軟體相關的翻譯檔、部署腳本、設定與使用範例。

## 目錄結構原則

軟體必須依「軟體名稱 → 版本」分層保存，讓 GitHub 可以逐層瀏覽，不使用把單一路徑壓縮成 `software/sftpgo/2.7.5` 的路徑表示方式。

例如：

```text
software/
└── sftpgo/
    ├── README.md
    ├── 2.7.0/
    │   ├── README.md
    │   └── translation.json
    └── 2.7.5/
        ├── README.md
        ├── deploy-sftpgo-zhTW.ps1
        └── translation.json
```

每個版本均為獨立內容，不應以新版檔案覆蓋舊版本。

## SFTPGo

目前保存：

- SFTPGo 2.7.0：Rocky Linux 安裝文章使用的繁體中文翻譯內容。
- SFTPGo 2.7.5：Windows 部署使用的繁體中文翻譯檔與 PowerShell 部署腳本。

版本差異請依各版本目錄中的 `README.md` 說明使用。
