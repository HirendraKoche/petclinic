# Base image
FROM hirendrakoche/tomcat:9.0.30

# copy app war
COPY target/petclinic.war /opt/tomcat/9.0.30/webapps

