## Kubernetes Deployments
### Components
* `deploy.sh`
* `./kubernetes/*`
* `circle.yml`

### Component Goals
#### deploy.sh
* perform a deploy of the following:
  * application configurations, only when changed, this will also complete a
    deploy...
  * if not application configurations are detected, it'll just do a deploy

#### ./kubernetes/*
* directory to contain all compenents required for the applications, things such
  as:
  * deployments
  * services
  * ingress controllers
  * config maps

#### circle.yml
* Gathers dependencies:
  * Install/Update gcloud command line tools and kubectl
  * Gathers the service account specific to circleci
  * Sets the environment dependant on the branch it's operating on
* Tests the code
* builds the docker container
  * Builds one tagged with the sha of the commit
  * Tags the same built container with `release`
  * pushed both containers to our registry
* Executes deploy.sh

### Variable Configuration
#### deploy.sh
* Tightly coupled to the names of stuff configured in the appropriate
  `./kubernets/*` files
  * `image` = the name of the docker container that we'll update on each deploy
  * `deployment` = name of the deployment configuration
  * `environment` = passed in via circleci's yml configuration

### Caveats
#### deploy.sh
* Will not deploy the application configuration if it doesn't exist and if there
  are no changes to anything in `./kubernetes/*`
* A deploy will fail if the application configuration has never been deployed
  into the cluster

#### ./kubernetes/*
* I've chosen to create an image name with `release`
  * Otherwise anytime we'd deploy we'd also need to bump the sha contained in
    the deployment config
  * I'm avoiding the use of latest and master since those might contain code not
    relevent to the latest release circleci is working on.
