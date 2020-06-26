#!/usr/bin/env bash

source "$PROJECT_HOME/src/ensure.sh"
source "$PROJECT_HOME/src/github.sh"
source "$PROJECT_HOME/src/github_actions.sh"
source "$PROJECT_HOME/src/misc.sh"

main() {
  ensure::env_variable_exist "GITHUB_REPOSITORY"
  ensure::env_variable_exist "GITHUB_EVENT_PATH"
  ensure::total_args 2 "$@"

  export GITHUB_TOKEN="$1"
 echo "INIII"
 local -r commit_sha="$(github_actions::commit_sha)"
 echo "$commit_sha"
 local -r commited_files=$(github::get_commit_modified_files "$commit_sha")
 
 local -r num_files=$(echo "$commited_files" | wc -l)
 echo "$num_files"
 if [ $num_files -eq 1 ]; then
    echo "$commited_files"
    if [ "$commited_files" == "composer.lock" ]; then
      echo "INNNN"
      local -r pr_number="$(github_actions::get_pr_number)"
      github::merge_pull_request "$pr_number"
    fi
 fi

  exit $?
}
