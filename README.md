# Docker - Jenkins

Provides a [Jenkins] server configured with the following plugins:

* [Doony](http://doony.org)
* [Green Balls](https://wiki.jenkins-ci.org/display/JENKINS/Green+Balls)
* [jQuery Plugin](https://wiki.jenkins-ci.org/display/JENKINS/jQuery+Plugin)
* [Simple Theme Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Simple+Theme+Plugin)


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
