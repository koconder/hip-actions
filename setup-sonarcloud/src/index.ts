import  { SonarCloudClient } from './sonar';

const core = require('@actions/core');

const repo = <string> process.env.CI_REPOSITORY_NAME;
const owner = <string> process.env.CI_REPOSITORY_OWNER;
const token = core.getInput('sonar_token', { required: true });

const defaultMasterBranch = "master"
const client = new SonarCloudClient(owner, token);

try {
    core.info(`Setting up SonarCloud for repository: ${repo}`);
    client.register(repo, defaultMasterBranch);
    core.info('SonarCloud setup completed!');
} catch (error) {
    core.setFailed(error);
}
