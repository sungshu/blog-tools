# blog-tools

`sungshu手札筆記本` 使用的工具、程式碼、翻譯檔與設定範例。

這個 Repository 主要用來保存 Blog 文章中可以直接使用、下載或參考的檔案。

## 目錄

| 目錄 | 說明 |
|---|---|
| `software/` | 開源軟體相關翻譯、部署工具、設定與範例 |
| `powershell/` | PowerShell 程式 |
| `bash/` | Bash / Shell 程式 |
| `python/` | Python 程式 |
| `network/` | 網路設備相關工具與範例 |
| `pve/` | Proxmox VE 相關工具 |
| `examples/` | 教學與設定範例 |

## 軟體目錄原則

軟體相關內容統一放在 `software/`，再依軟體名稱與版本分層保存。

例如：

```text
software/
└── sftpgo/
    └── 2.7.5/
        ├── README.md
        ├── deploy-sftpgo-zhTW.ps1
        └── translation.json
```

不同版本的軟體或工具分開保存，避免新版本檔案覆蓋舊版本內容。

## 注意

本 Repository 的內容主要配合 `sungshu手札筆記本` Blog 文章使用。

實際使用前，請先閱讀各項目目錄中的 `README.md`，確認適用版本與使用方式。
