#!/usr/bin/env bash

source "$PROJECT_HOME/src/ensure.sh"
source "$PROJECT_HOME/src/github.sh"
source "$PROJECT_HOME/src/github_actions.sh"
source "$PROJECT_HOME/src/misc.sh"

main() {
  ensure::env_variable_exist "GITHUB_REPOSITORY"
  ensure::env_variable_exist "GITHUB_EVENT_PATH"
  ensure::total_args 2 "$@"

#  cat "$GITHUB_EVENT_PATH"

  export GITHUB_TOKEN="$1"

  local -r pr_number="$(github_actions::get_pr_number)"
  
  echo "pr_number $pr_number"
      
 local -r commit_sha="$(github_actions::commit_sha)"
  
  echo "commit_sha $commit_sha"
  
 local -r pr_files="$(github::get_pull_request_files $pr_number)"

 echo "pr_files $pr_files"

 local -r num_files="$(echo \"$pr_files\" | wc -l )"

echo "num $num_files"

 if [ $num_files -eq 1 ]; then
    if [ "$pr_files" == "composer.lock" ]; then
      github::merge_pull_request "$pr_number" "$commit_sha"
      echo "IF 2"
    fi
    echo "IF 1"
 fi
 echo "FIN"

  exit $?
}
