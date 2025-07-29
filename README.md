# gwt - Git Worktree Helper

git worktree をより簡単に作成するためのシェル関数です。

## インストール

### curl でインストール

```bash
mkdir -p ~/.config/gwt
curl -sSL https://raw.githubusercontent.com/pankona/gwt/main/gwt.bash -o ~/.config/gwt/gwt.bash
echo "source ~/.config/gwt/gwt.bash" >> ~/.bashrc
```

### git clone でインストール

```bash
git clone https://github.com/pankona/gwt.git ~/.config/gwt
echo "source ~/.config/gwt/gwt.bash" >> ~/.bashrc
```

## 使い方

```bash
gwt feature/new-feature
```

## 機能

- 現在のブランチから新しい worktree を作成
- worktree の保存先を `$GWT_DIR/host/user/repo/branch-name` に自動設定 (GitHub, GitLab等に対応)
- `GWT_DIR` 環境変数で保存先をカスタマイズ可能（デフォルト: `~/worktrees`）

## License

MIT

## Author

pankona (Yosuke Akatsuka)
