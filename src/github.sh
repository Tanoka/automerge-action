#!/usr/bin/env bash

GITHUB_API_URI="https://api.github.com"
GITHUB_API_HEADER="Accept: application/vnd.github.v3+json"

github::get_commit_modified_files() {
  local -r commit_ref=$1

  curl -sSL -H "Authorization: token $GITHUB_TOKEN" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/commits/$commit_ref" | jq .files | jq -r ".[] | .filename"
}

github::get_pull_request_files() {
  local -r pr_number=$1

  curl -sSL -H "Authorization: token $GITHUB_TOKEN" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/pulls/$pr_number/files" | jq -r ".[] | .filename"
}


github::comment_pr() {
  local -r comment=$2
  local -r pr_number=$1

  curl -sSL \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "$GITHUB_API_HEADER" \
    -X POST \
    -H "Content-Type: application/json" \
    -d "{\"body\":\"$comment\"}" \
    "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/issues/$pr_number/comments"
}

github::comment_commit() {
  local -r comment=$2
  local -r commit_sha=$1

  curl -sSL \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "$GITHUB_API_HEADER" \
    -X POST \
    -H "Content-Type: application/json" \
    -d "{\"body\":\"$comment\"}" \
    "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/commits/$commit_sha/comments"
}

github::merge_pull_request() {
  local -r pull_number=$1
  local -r sha=$2
  
#  local data='{"sha":"'"$sha"'","commit_title":"Automerge composer.lock file","commit_message":"Automerge composer.lock file"}'
  local data='{"commit_title":"MERGE PULL REQUEST: Automerge composer.lock file"}'

  curl -sSL \
   -H "$GITHUB_API_HEADER" \
   -H "Authorization: token $GITHUB_TOKEN" \
   -X PUT \
   -H "Content-Type: application/json" \
   -d "$data" \
   "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/pulls/$pull_number/merge"
}
