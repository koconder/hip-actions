const core = require('@actions/core');
const github = require('@actions/github');
const fs = require('fs')

// List of files / policies to check
const github_token = core.getInput('token');
const context = github.context;

console.log(github_token);

console.log("Checking policies...")
// console.log("PR context: ");
// console.log(context.payload);
// Loop through policies

if (context.payload.pull_request != null) {
     const path = '.argocd.yaml'

    fs.access(path, fs.F_OK, (err) => {
    if (err) {
        const message = "Failed to validate ArgoCD file, please add argocd deployment file to your repository!";
        const pull_request_number = context.payload.pull_request.number;
        const octokit = new github.getOctokit(github_token);
        const new_comment = octokit.issues.createComment({
            ...context.repo,
            issue_number: pull_request_number,
            body: message
          });
        core.setFailed(message);
        return
    }

    })
}

// If violate return github exit code