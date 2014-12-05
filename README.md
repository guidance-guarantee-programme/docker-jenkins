# Docker - Jenkins

Provides a [Jenkins] LTS server configured with the following plugins:

* [Credentials Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Credentials+Plugin)
* [Doony](http://doony.org)
* [Git Client Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Client+Plugin)
* [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)
* [GitHub API Plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+API+Plugin)
* [GitHub Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Github+Plugin)
* [Green Balls](https://wiki.jenkins-ci.org/display/JENKINS/Green+Balls)
* [jQuery Plugin](https://wiki.jenkins-ci.org/display/JENKINS/jQuery+Plugin)
* [Mailer](https://wiki.jenkins-ci.org/display/JENKINS/Mailer)
* [Matrix Project Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Project+Plugin)
* [Multiple SCMs Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Multiple+SCMs+Plugin)
* [Promoted Builds Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Promoted+Builds+Plugin)
* [SCM API Plugin](https://wiki.jenkins-ci.org/display/JENKINS/SCM+API+Plugin)
* [Simple Theme Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Simple+Theme+Plugin)
* [SSH Credentials Plugin](https://wiki.jenkins-ci.org/display/JENKINS/SSH+Credentials+Plugin)


## Prerequisites

* [Docker]
* [Git]


## Building an image

```sh
$ docker build --tag hmtreasury/jenkins .
```


## Running a container

Create a data volume container to persist the server configuration:

```sh
$ docker run --volume /var/lib/jenkins \
             --name jenkins_home \
             busybox true
```

Run a container to start the Jenkins server:

```sh
$ docker run --detach \
             --volumes-from jenkins_home \
             --publish 8080:8080 \
             --name jenkins \
             hmtreasury/jenkins
```

Jenkins will now be available on port `8080` of your Docker host.


## Backing up the server configuration

The following command creates a tarball of the server configuration in the current directory.

```sh
$ docker run --rm \
             --volumes-from jenkins_home \
             --volume $(pwd):/tmp/backup \
             hmtreasury/base \
             tar -cvf /tmp/backup/jenkins_home.tar /var/lib/jenkins
```


## Contributing

Please see the [contributing guidelines](/CONTRIBUTING.md).


[docker]: https://www.docker.com
[git]: http://git-scm.com
[jenkins]: http://jenkins-ci.org
