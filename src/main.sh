#!/usr/bin/env bash

source "$PROJECT_HOME/src/ensure.sh"
source "$PROJECT_HOME/src/github.sh"
source "$PROJECT_HOME/src/github_actions.sh"
source "$PROJECT_HOME/src/misc.sh"

main() {
  ensure::env_variable_exist "GITHUB_REPOSITORY"
  ensure::env_variable_exist "GITHUB_EVENT_PATH"
  ensure::total_args 1 "$@"

#  cat "$GITHUB_EVENT_PATH"

  export GITHUB_TOKEN="$1"

  local -r pr_number="$(github_actions::get_pr_number)"
          
 local -r pr_files="$(github::get_pull_request_files $pr_number)"

 local -r num_files=$(echo "$pr_files" | wc -l)

 if [ $num_files -eq 1 ]; then
    if [ "$pr_files" == "composer.lock" ]; then
      github::merge_pull_request "$pr_number"
    fi
 fi

  exit $?
}
