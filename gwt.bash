gwt() {
  local branch_name="$1"
  local worktree_base="${GWT_DIR:-$HOME/worktrees}"
  local current_branch=$(git branch --show-current)
  
  # リモートURLからホストとパスを取得
  local remote_url=$(git remote get-url origin)
  # SSH形式 (git@host:user/repo.git) またはHTTPS形式 (https://host/user/repo.git) に対応
  local host_and_path=$(echo "$remote_url" | sed -E 's|^(https?://)?([^@]+@)?([^:/]+)[:/](.*)\.git$|\3/\4|')
  
  local target_dir="$worktree_base/$host_and_path/$branch_name"
  
  # ディレクトリを作成
  mkdir -p "$(dirname "$target_dir")"
  
  git worktree add -b "$branch_name" "$target_dir" "$current_branch"
}
