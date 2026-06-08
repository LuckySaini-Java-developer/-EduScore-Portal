# सीधे Apache Tomcat सर्वर का उपयोग करें (बिना मावेन के झंझट के)
FROM tomcat:9.0-jdk17-openjdk-slim

# गिटहब के सभी कोड, HTML, CSS और JSP फाइलों को सीधे Tomcat के webapps फोल्डर में कॉपी करें
COPY . /usr/local/tomcat/webapps/ROOT/

# अगर जावा फाइल्स सीधे बाहर हैं, तो उन्हें वेब-इन्फो के अंदर क्लासेस फोल्डर में कॉपी करें
COPY *.java /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

EXPOSE 8080
CMD ["catalina.sh", "run"]
