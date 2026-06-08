# Apache Tomcat का सही एनवायरनमेंट यूज़ करना जिसमें जावा कंपाइलर (JDK) शामिल हो
FROM tomcat:9.0-jdk17-openjdk-slim

# 1. पूरा प्रोजेक्ट टॉमकेट के webapps/ROOT/ में कॉपी करें
COPY . /usr/local/tomcat/webapps/ROOT/

# 2. गिटहब की जावा फ़ाइल को टॉमकेट के नियमों के अनुसार सही जगह पर कंपाइल (Compile) करना
RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar:/usr/local/tomcat/lib/jsp-api.jar -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/DBConnection.java

EXPOSE 8080
CMD ["catalina.sh", "run"]
