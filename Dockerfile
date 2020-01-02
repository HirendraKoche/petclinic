FROM hirendrakoche/jre:8 as builder

ENV MAVEN_HOME /opt/maven
ENV PATH ${MAVEN_HOME}/bin:$PATH
ENV SOURCE_DIR /root/source

WORKDIR ${MAVEN_HOME}

RUN set -eux; \
    yum install -y tar gzip; \
    rm -rf /var/cache/yum; \
    curl -s http://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | tar xvz --strip-component 1

WORKDIR ${SOURCE_DIR}

ADD . .

RUN set -eux;\
    mvn clean package


FROM hirendrakoche/tomcat:9.0.30

WORKDIR ${CATALINA_HOME}/webapps

COPY --from=builder /root/source/target/petclinic.war .
