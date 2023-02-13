## Website/blog for flowix.tech

:wrench: **IN DEVELOPMENT**

This is the source code for the website that is hosted at [flowix.tech](https://flowix.tech).
It aims to showcase modern web development techniques and best practices around 
Nextjs 13 web development and website/MDX blog creation.


## Features
- Complete CI/CD pipeline with GitHub Actions
- Automatic build of application Docker image and deployment to Kubernetes cluster



## CI/CD pipeline
The CI/CD pipeline is defined in the `.github/workflows` directory.
It has two files `test.yml` and `deploy.yml`. Former is used for testing the code and the latter for 
deploying the code to the Kubernetes cluster after each closed pull request from dev to main branch.
Bellow you can find the description for pipeline:

### 1.Testing
Testing GitHub action which runs on every commit. It caches `node_modules/` and `cypress/`, then
starts e2e tests with cypress.

### 2. Building and deploying
Builds the application docker image with `buildx` and authenticates to private 
Docker registry where registry url, username and password are handled with GitHub secrets.
After building phase successfully completes, new version of website is deployed to privately managed
Kubernetes cluster. For that we use `check_deployment.sh` script that works like this:


