#!/bin/bash

# --- 設定変数 ---
# レポジトリのベースディレクトリ
DPP_BASE_DIR="$HOME/.cache/dpp"
# プラグインレポジトリのルートディレクトリ
REPOS_DIR="$DPP_BASE_DIR/repos/github.com"

# --- 関数定義 ---
# レポジトリをクローンする関数
clone_repo() {
  local owner="$1"
  local repo="$2"
  local dest_dir="$REPOS_DIR/$owner"
  local repo_url="https://github.com/$owner/$repo"

  # 存在しない場合はディレクトリを作成
  mkdir -p "$dest_dir"

  # レポジトリが既にクローンされているかチェック
  if [ -d "$dest_dir/$repo" ]; then
    echo "Info: $repo_url は既に存在します。スキップします。"
  else
    echo "Cloning $repo_url into $dest_dir/..."
    # git clone を実行し、エラーチェック
    if ! git clone "$repo_url" "$dest_dir/$repo"; then
      echo "Error: $repo_url のクローンに失敗しました。" >&2
      exit 1
    fi
  fi
}

# --- メイン処理 ---
echo "Neovim dpp プラグインをセットアップします..."

# レポジトリのクローン
clone_repo "Shougo" "dpp.vim"
clone_repo "Shougo" "dpp-ext-installer"
clone_repo "Shougo" "dpp-protocol-git"
clone_repo "Shougo" "dpp-ext-lazy"
clone_repo "Shougo" "dpp-ext-toml"
clone_repo "vim-denops" "denops.vim"

echo "セットアップが完了しました。"

