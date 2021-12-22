import axios, { AxiosInstance, AxiosError } from 'axios'

export const SONAR_URL = 'https://sonarcloud.io'

export class SonarCloudClient {
  private axios: AxiosInstance

  public constructor(private org: string, private token: string) {
    this.axios = axios.create({
      baseURL: SONAR_URL,
      timeout: 5000,
      auth: { username: this.token, password: '' },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    })
  }

  public async register(repositoryName: string, mainBranchName: string): Promise<void> {
    const project = `${this.org}_${repositoryName}`
    try {
      const { components } = await this.searchProjects(this.org, repositoryName)
      const found = components.find(({ key, name }) => key === project && name === repositoryName)
      if (!found) {
        await this.createProject(repositoryName, project, this.org)
      }
      const { branches } = await this.getBranches(project)
      if (branches.find(({ name, isMain }) => name === mainBranchName && isMain === false)) {
        await this.deleteBranch(project, mainBranchName)
      }
      await this.renameBranch(project, mainBranchName)
    } catch (error: Error | AxiosError | any) {
      SonarCloudClient.handle(error)
    }
  }

  private async searchProjects(organization: string, q: string): Promise<SonarSearchResponse> {
    const { data } = await this.axios.get<SonarSearchResponse>('/api/projects/search', { params: { organization, q } })
    return data
  }

  private async createProject(name: string, project: string, organization: string): Promise<void> {
    const params = new URLSearchParams()
    params.append('name', name)
    params.append('project', project)
    params.append('organization', organization)
    await this.axios.post('/api/projects/create', params)
  }

  private async getBranches(project: string): Promise<SonarBranchesListResponse> {
    const { data } = await this.axios.get<SonarBranchesListResponse>('/api/project_branches/list', { params: { project } })
    return data
  }

  private async deleteBranch(project: string, branch: string): Promise<void> {
    const params = new URLSearchParams()
    params.append('project', project)
    params.append('branch', branch)
    await this.axios.post('/api/project_branches/delete', params)
  }

  private async renameBranch(project: string, name: string): Promise<void> {
    await this.axios.post('/api/project_branches/rename', null, { params: { project, name } })
  }

  private static handle(error: Error | AxiosError | any) {
    if (axios.isAxiosError(error)) {
      const message = (error.response?.data as SonarErrorResponse)?.errors?.map((error) => error?.msg)?.shift()
      throw new Error(message || error?.message)
    } else {
      throw error
    }
  }
}

export interface SonarSearchResponse {
  components: {
    key: string
    name: string
  }[]
}

export interface SonarBranchesListResponse {
  branches: {
    name: string
    isMain: boolean
  }[]
}

export interface SonarErrorResponse {
  errors: { msg: string }[]
}