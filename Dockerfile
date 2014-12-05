FROM hmtreasury/base
MAINTAINER HM Treasury Guidance Guarantee Programme <pensions-guidance-members@digital.cabinet-office.gov.uk>

RUN apt-get update -q && \
    apt-get install -qy wget git openjdk-7-jre-headless --no-install-recommends && \
    echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list && \
    wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | apt-key add - && \
    apt-get update -q && \
    apt-get install -qy jenkins && \

    cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

VOLUME /var/lib/jenkins
ENV JENKINS_HOME /var/lib/jenkins

ADD http://updates.jenkins-ci.org/latest/credentials.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/git-client.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/git.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/github-api.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/github.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/greenballs.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/jquery.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/mailer.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/matrix-project.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/multiple-scms.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/promoted-builds.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/scm-api.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/simple-theme-plugin.hpi /usr/share/jenkins/ref/plugins/
ADD http://updates.jenkins-ci.org/latest/ssh-credentials.hpi /usr/share/jenkins/ref/plugins/

ADD https://cdnjs.cloudflare.com/ajax/libs/doony/1.6/css/doony.min.css /usr/share/jenkins/ref/userContent/
ADD https://cdnjs.cloudflare.com/ajax/libs/doony/1.6/js/doony.min.js /usr/share/jenkins/ref/userContent/

ADD org.codefirst.SimpleThemeDecorator.xml /usr/share/jenkins/ref/

EXPOSE 8080

COPY jenkins.sh /usr/local/bin/jenkins.sh
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
