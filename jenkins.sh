#!/bin/bash

# Copy files from /usr/share/jenkins/ref into $JENKINS_HOME so that the initial $JENKINS_HOME has expected content.
# Don't override, as this is a reference setup, usage from then UI will change server configuration.
copy_jenkins_reference_file() {
    f=${1%/}
	rel=${f:23}
    dir=$(dirname ${f})
    if [[ ! -e $JENKINS_HOME/${rel} ]]; then
		mkdir -p $JENKINS_HOME/${dir:23}
		cp -r /usr/share/jenkins/ref/${rel} $JENKINS_HOME/${rel};
	fi;
}
export -f copy_jenkins_reference_file

find /usr/share/jenkins/ref/ -type f -exec bash -c 'copy_jenkins_reference_file {}' \;

# If `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
	exec java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS "$@"
fi

# As argument is not jenkins, assume user want to run his own process, for sample a `bash` shell to explore this image
exec "$@"
