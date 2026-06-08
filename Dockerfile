FROM tomcat:9.0-jdk17-openjdk-slim

# 1. पूरा प्रोजेक्ट टॉमकेट के webapps/ROOT/ में कॉपी करें
COPY . /usr/local/tomcat/webapps/ROOT/

# 2. टॉमकेट के अंदर आपकी DBConnection.java फ़ाइल को मैन्युअल कंपाइल करना
RUN javac -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/DBConnection.java

EXPOSE 8080
CMD ["catalina.sh", "run"]
