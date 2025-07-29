gwt() {
  local branch_name="$1"
  local worktree_base="${GWT_DIR:-$HOME/worktrees}"
  local current_branch=$(git branch --show-current)

  # リモートURLからホストとパスを取得
  local remote_url=$(git remote get-url origin)
  local host_and_path

  if [[ "$remote_url" =~ ^git@([^:]+):(.*)$ ]]; then
    # SSH形式: git@host:user/repo[.git]
    local path="${BASH_REMATCH[2]}"
    # .git 拡張子を削除
    path="${path%.git}"
    host_and_path="${BASH_REMATCH[1]}/${path}"
  elif [[ "$remote_url" =~ ^https?://([^/]+)/(.*)$ ]]; then
    # HTTPS形式: https://host/user/repo[.git]
    local path="${BASH_REMATCH[2]}"
    # .git 拡張子を削除
    path="${path%.git}"
    host_and_path="${BASH_REMATCH[1]}/${path}"
  else
    echo "Error: Unsupported remote URL format: $remote_url" >&2
    return 1
  fi

  local target_dir="$worktree_base/$host_and_path/$branch_name"

  # ディレクトリを作成
  mkdir -p "$(dirname "$target_dir")"

  git worktree add -b "$branch_name" "$target_dir" "$current_branch"
  echo "$target_dir"
}

gwtcd() {
  local worktree_base="${GWT_DIR:-$HOME/worktrees}"
  
  # worktree_base配下のディレクトリを検索してfzfで選択
  local selected_dir
  selected_dir=$(find "$worktree_base" -type d -name ".git" -prune -o -type d -print 2>/dev/null | \
    grep -v "\.git$" | \
    sed "s|^$worktree_base/||" | \
    grep -v "^$" | \
    fzf --height=40% --reverse --prompt="Select worktree: ")
  
  if [[ -n "$selected_dir" ]]; then
    cd "$worktree_base/$selected_dir"
  fi
}
