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

 local -r commit_sha="$(github_actions::commit_sha)"
 
 local -r commited_files=$(github::get_commit_modified_files "$commit_sha")

 $num_files=$(echo "$commited_files" | wc -l)
 if [ $num_files -eq 1 ]; then
    if [ "$commited_files" == "composer.lock" ]; then
      github::merge_pull_request 
    fi
 fi

  exit $?
}
