# :octocat: :rocket: GitHub Environment Variables Action


[![license: MIT](https://img.shields.io/badge/license-MIT-brightgreen.svg)](./LICENSE)

A [GitHub Action](https://github.com/features/actions) to expose useful environment variables.

### Environment Variables exposed by **this Action**

| Environment Variable Name      | Description                                                                                                                                                    | Example value                          |
|--------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| `CI_REPOSITORY_SLUG`       | The slug of the owner and repository name (i.e. slug of `FranzDiebold/github-env-vars-action`).                                                                | `franzdiebold-github-env-vars-action`      |
| `CI_REPOSITORY_OWNER`      | The owner of the repository.                                                                                                                                   | `FranzDiebold`                             |
| `CI_REPOSITORY_OWNER_SLUG` | The slug of the owner of the repository.                                                                                                                       | `franzdiebold`                             |
| `CI_REPOSITORY_NAME`       | The name of the repository.                                                                                                                                    | `github-env-vars-action`                   |
| `CI_REPOSITORY_NAME_SLUG`  | The slug of the name of the repository.                                                                                                                        | `github-env-vars-action`                   |
| `CI_REPOSITORY`            | The owner and repository name. Copy of `GITHUB_REPOSITORY` - for reasons of completeness.                                                                      | `FranzDiebold/github-env-vars-action`      |
| `CI_REF_SLUG`              | The slug of the branch, tag or PR number *ref* that triggered the workflow (i.e. slug of `refs/heads/feat/feature-branch-1`). <br>If neither a branch, tag or PR number is available for the event type, the variable will not exist. | `refs-heads-feat-feature-branch-1` or<br> `refs-tags-v1-3-7` or<br> `refs-pull-42-merge` |
| `CI_ACTION_REF_NAME`       | The branch or tag *name* that triggered the workflow. For pull requests it is the *head* branch name.                                                          | `feat/feature-branch-1` or<br> `v1.3.7`    |
| `CI_ACTION_REF_NAME_SLUG`  | The slug of the branch or tag *name* that triggered the workflow. For pull requests it is the slug of the *head* branch name.                                  | `feat-feature-branch-1` or<br> `v1-3-7`    |
| `CI_REF_NAME`              | The branch *name*, tag *name* or PR number that triggered the workflow. <br>If neither a branch, tag or PR number is available for the event type, the variable will not exist. | `feat/feature-branch-1` or<br> `v1.3.7` or<br> `42/merge` |
| `CI_REF_NAME_SLUG`         | The slug of the branch *name*, tag *name* or PR number that triggered the workflow. <br>If neither a branch, tag or PR number is available for the event type, the variable will not exist. | `feat-feature-branch-1` or<br> `v1-3-7` or<br> `42-merge` |
| `CI_REF`                   | The branch, tag or PR number *ref* that triggered the workflow. <br>If neither a branch, tag or PR number is available for the event type, the variable will not exist. Copy of `GITHUB_REF` - for reasons of completeness. | `refs/heads/feat/feature-branch-1` or<br> `refs/tags/v1.3.7` or<br> `refs/pull/42/merge` |
| `CI_HEAD_REF_SLUG`         | The slug of the head branch *name*. <br>Only set for event type *pull request* or forked repositories.                                                         | `feat-feature-branch-1`                    |
| `CI_HEAD_REF`              | Only set for forked repositories / pull request. The branch of the head repository / the head branch name. Copy of `GITHUB_HEAD_REF` - for reasons of completeness. | `feat/feature-branch-1`               |
| `CI_BASE_REF_SLUG`         | The slug of the base branch *name*. <br>Only set for event type *pull request* or forked repositories.                                                         | `main`                                     |
| `CI_BASE_REF`              | Only set for forked repositories / pull request. The branch of the base repository / the base branch name. Copy of `GITHUB_BASE_REF` - for reasons of completeness. | `main`                                |
| `CI_SHA_SHORT`             | The shortened commit SHA (8 characters) that triggered the workflow.                                                                                           | `ffac537e`                                 |
| `CI_SHA`                   | The commit SHA that triggered the workflow. Copy of `GITHUB_SHA` - for reasons of completeness.                                                                | `ffac537e6cbbf934b08745a378932722df287a53` |
| `CI_PR_SHA_SHORT`          | The shortened latest commit SHA in the pull request's base branch. Short version of `CI_PR_SHA`. Only set for pull requests.                                   | `010b249`                                  |
| `CI_PR_SHA`                | The latest commit SHA in the pull request's base branch. Long version of `CI_PR_SHA_SHORT`. Only set for pull requests.                                        | `010b2491902d50e8623934f5bc43763ff5991642` |
| `CI_PR_NUMBER`             | The number of the pull request. Only set for pull requests.                                                                                                    | `42`                                       |
| `CI_PR_ID`                 | Copy of `CI_PR_NUMBER` for completeness.                                                                                                                       | `42`                                       |
| `CI_PR_TITLE`              | The title of the pull request. Only set for pull requests.                                                                                                     | `Add feature xyz.`                         |
| `CI_PR_DESCRIPTION`        | The description of the pull request. Only set for pull requests.                                                                                               | `The feature xyz is the [...]`             |
| `CI_ACTOR`                 | The name of the person or app that initiated the workflow. Copy of `GITHUB_ACTOR` - for reasons of completeness.                                               | `octocat`                                  |
| `CI_EVENT_NAME`            | The name of the webhook event that triggered the workflow. Copy of `GITHUB_EVENT_NAME` - for reasons of completeness.                                          | `push` or `pull_request`                   |
| `CI_RUN_ID`                | A unique number for each run within a repository. This number does not change if you re-run the workflow run. Copy of `GITHUB_RUN_ID` - for reasons of completeness. | `397746731`                          |
| `CI_RUN_NUMBER`            | A unique number for each run of a particular workflow in a repository. This number begins at 1 for the workflow's first run, and increments with each new run. This number does not change if you re-run the workflow run. Copy of `GITHUB_RUN_NUMBER` - for reasons of completeness. | `73` |
| `CI_WORKFLOW`              | The name of the workflow. Copy of `GITHUB_WORKFLOW` - for reasons of completeness.                                                                             | `Demo`                                     |
| `CI_ACTION`                | The unique identifier (`id`) of the action. Copy of `GITHUB_ACTION` - for reasons of completeness.                                                             | `run2`                                     |
| `CI_HIPAGES_APP_NAME` | A custom hipages variable consisting of the value of `CI_REPOSITORY_NAME_SLUG` | `attchments-api`
| `CI_HIPAGES_RELEASE_NAME` | A custom hipages variable that can be used when deploying apps to staging / non-prod environments. The value of this variable consists of `CI_REPOSITORY_NAME_SLUG`-`CI_REF_NAME_SLUG` | `attachments-api-staging`
| `CI_HIPAGES_IS_MASTER` | A custom hipages variable that is set to true in case the running branch is master. False otherwise | `true`
| `CI_HIPAGES_BRANCH_SLUG` | A custom hipages variable that sets the correct branch name for PRs or normal push | `master`

> The [slugified](https://en.wikipedia.org/wiki/Clean_URL#Slug) values are designed to be used in a URL.

### Default Environment Variables exposed by GitHub

For a full list of default environment variables exposed by GitHub see [https://docs.github.com/en/free-pro-team@latest/actions/reference/environment-variables#default-environment-variables](https://docs.github.com/en/free-pro-team@latest/actions/reference/environment-variables#default-environment-variables).

| Environment Variable Name | Description                                                                                                                                     | Example value                              |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
| `GITHUB_ACTOR`            | The name of the person or app that initiated the workflow.                                                                                      | `octocat`                                  |
| `GITHUB_REPOSITORY`       | The owner and repository name.                                                                                                                  | `FranzDiebold/github-env-vars-action`      |
| `GITHUB_SHA`              | The commit SHA that triggered the workflow.                                                                                                     | `ffac537e6cbbf934b08745a378932722df287a53` |
| `GITHUB_REF`              | The branch or tag ref that triggered the workflow. <br>If neither a branch or tag is available for the event type, the variable will not exist. | `refs/heads/feat/feature-branch-1`         |
| `GITHUB_HEAD_REF`         | Only set for forked repositories / pull request. The branch of the head repository / the head branch name.                                      | `feat/feature-branch-1`                    |
| `GITHUB_BASE_REF`         | Only set for forked repositories / pull request. The branch of the base repository / the base branch name.                                      | `main`                                     |
| `GITHUB_EVENT_NAME`       | The name of the webhook event that triggered the workflow.                                                                                      | `push`                                     |
| `GITHUB_RUN_ID`           | A unique number for each run within a repository. This number does not change if you re-run the workflow run.                                   | `397746731`                                |
| `GITHUB_RUN_NUMBER`       | A unique number for each run of a particular workflow in a repository. This number begins at 1 for the workflow's first run, and increments with each new run. This number does not change if you re-run the workflow run. | `73` |
| `GITHUB_WORKFLOW`         | The name of the workflow.                                                                                                                       | `Demo`                                     |
| `GITHUB_ACTION`           | The unique identifier (`id`) of the action.                                                                                                     | `run2`                                     |

