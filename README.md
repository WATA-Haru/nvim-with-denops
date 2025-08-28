# Neovim設定 with vim.pack

Neovimネイティブのパッケージマネージャー（`vim.pack`）とDenops統合を使用したモダンなNeovim設定。

[English README](docs/README.en.md)

## 要件

- **Neovim**: >= 0.12.0 (prerelease)
- **パッケージマネージャー**: vim.pack（>= **Neovim prelease 12.0**)
- **ランタイム**: Deno（Denopsプラグイン用）

## ディレクトリ構成

```
nvim-with-denops/
├── init.lua                    # メイン設定エントリーポイント
├── lsp/                        # LSPサーバー設定
├── lua/
│   ├── config/                # Neovimコア設定
│   │   ├── clipboard.lua      # クリップボード設定（WSL win32yank）
│   │   ├── keys.lua           # キーマッピング
│   │   ├── lsp.lua            # LSPグローバル設定
│   │   ├── opts.lua           # Neovimオプション
│   │   └── plugins.lua        # プラグイン読み込み制御
│   └── plugins/               # プラグイン設定
└── vimscript_for_plugins/     # VimScript設定
```

### ディレクトリ説明

- **`lsp/`**: `vim.lsp.config()`を使用した個別LSPサーバー設定
- **`lua/config/`**: 関心事別に分離されたNeovimコア設定
- **`lua/plugins/`**: `vim.pack.add()`を使用したプラグインインストールと設定
- **`vimscript_for_plugins/`**: VimScriptが必要なプラグイン用設定

### lua/config/ファイル詳細

- **`clipboard.lua`**: WSL win32yankクリップボード統合
- **`keys.lua`**: キーマッピングとショートカット
- **`lsp.lua`**: LSPグローバル設定と診断
- **`opts.lua`**: Neovimオプション（UI、動作など）
- **`plugins.lua`**: プラグイン読み込み制御

## パッケージ管理
この設定はNeovimネイティブの`vim.pack.add()`システムを使用：

- **インストール**: 初回起動時に自動
- **更新**: Neovim再起動で手動、または`vim.pack.update()`関数使用
- **依存関係**: プラグインファイル内の読み込み順序で処理

**参考**:
- ドキュメント: https://neovim.io/doc/user/pack.html#vim.pack.update()
- 動画: https://youtu.be/UE6XQTAxwE0?si=aVc1tpYEP0Wmy2NX

## LSPサーバー（mise管理 + nvim-lspconfig）
LSPサーバーは**mise**（masonではなく）経由で管理しています。以下のツールをインストールしてパスを設定してください：

mise.tomlの例は`docs/sample.mise.toml`にあります。
`lsp/`ディレクトリのファイル内のパスがmiseインストールパスと一致していることを確認してください。

## WSL: Win32yank（WSLクリップボード）
WSLユーザーは、クリップボード統合のためにwin32yankをインストールしてください：

```bash
# win32yankを~/.local/bin/にインストール
curl -L https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip -o /tmp/win32yank.zip
unzip /tmp/win32yank.zip -d ~/.local/bin/
chmod +x ~/.local/bin/win32yank.exe
```

設定は`lua/config/clipboard.lua`にあります。
