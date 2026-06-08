FROM tomcat:9.0-jdk17-openjdk-slim

# पूरे प्रोजेक्ट को सीधे टॉमकेट के webapps/ROOT/ फोल्डर में कॉपी करना
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
