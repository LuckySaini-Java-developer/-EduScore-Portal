FROM tomcat:9.0-jdk17-openjdk-slim

# इंटरनेट से सीधे PostgreSQL ड्राइवर डाउनलोड करके सर्वर की मुख्य लाइब्रेरी (lib) में रखना
ADD https://maven.org /usr/local/tomcat/lib/

# पूरे प्रोजेक्ट को सीधे टॉमकेट के webapps फोल्डर में कॉपी करना
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
