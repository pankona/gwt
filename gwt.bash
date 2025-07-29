gwt() {
  local branch_name="$1"
  local worktree_base="${GWT_DIR:-$HOME/worktrees}"
  local current_branch=$(git branch --show-current)
  
  # リモートURLからホストとパスを取得
  local remote_url=$(git remote get-url origin)
  local host_and_path
  
  if [[ "$remote_url" =~ ^git@([^:]+):(.*)\.git$ ]]; then
    # SSH形式: git@host:user/repo.git
    host_and_path="${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
  elif [[ "$remote_url" =~ ^https?://([^/]+)/(.*)\.git$ ]]; then
    # HTTPS形式: https://host/user/repo.git
    host_and_path="${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
  else
    echo "Error: Unsupported remote URL format: $remote_url" >&2
    return 1
  fi
  
  local target_dir="$worktree_base/$host_and_path/$branch_name"
  
  # ディレクトリを作成
  mkdir -p "$(dirname "$target_dir")"
  
  git worktree add -b "$branch_name" "$target_dir" "$current_branch"
}
