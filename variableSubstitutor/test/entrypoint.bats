#!/usr/bin/env bats

TEST_BREW_PREFIX="$(brew --prefix)"
load "${TEST_BREW_PREFIX}/lib/bats-support/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-assert/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-file/load.bash"

function teardown() {
  rm -f test/mocks/argocd.yaml.predist
  rm -f test/mocks/argocd.yaml.dist
}

@test "should print usage upon invoking entrypoint without arguments" {
  run ./entrypoint.sh

  assert_equal $status 0
  assert_line --partial 'usage: entrypoint.sh <app-deploy|app-delete>'
}

@test "generate_manifest - should return not found if argocd.yml not present" {
  source ./functions.sh
  run generate_manifest

  assert_equal $status 1
  assert_line --partial 'not found'
}

@test "generate_manifest - produces a valid manifest" {
    source ./functions.sh
    GITHUB_EVENT_PATH=test/mocks/github_event.json
    run generate_manifest test/mocks/argocd.yaml

    assert_equal $status 0
    assert_file_exist test/mocks/argocd.yaml.dist
}

@test "generate_app_name - should return regular app name" {
  source ./functions.sh
  run generate_app_name repo1 branch1

  assert_equal $status 0
  assert_output 'repo1-branch1'
}

@test "generate_app_name - should truncate app name if too large" {
  source ./functions.sh
  run generate_app_name repo1 superlongbranchname1234567890123456789012345678901234567890

  assert_equal $status 0
  assert_output 'repo1-ac28655'
}

@test "generate_app_name - should return APP_NAME if it exists as env" {
  source ./functions.sh
  APP_NAME=foobar
  run generate_app_name repo1 branch1

  assert_equal $status 0
  assert_output 'foobar'
}

@test "generate_app_name - should append APP_SUFFIX if it exists" {
  source ./functions.sh
  APP_SUFFIX=-foobar
  run generate_app_name repo1 branch1

  assert_equal $status 0
  assert_output 'repo1-branch1-foobar'
}
