FROM tomcat:9.0-jdk17-openjdk-slim

ADD https://jdbc.postgresql.org/download/postgresql-42.7.3.jar /usr/local/tomcat/lib/

COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
