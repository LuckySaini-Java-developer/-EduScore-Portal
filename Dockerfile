FROM tomcat:9.0-jdk17-openjdk-slim

# 1. पूरा प्रोजेक्ट टॉमकेट के webapps फोल्डर में कॉपी करना
COPY . /usr/local/tomcat/webapps/ROOT/

# 2. लिनक्स कमांड (wget) का उपयोग करके ड्राइवर को केवल और केवल 'एक ही जगह' डाउनलोड करना
# इससे पुराने सारे कस्टमाइज्ड ड्राइवर डिलीट हो जाएंगे और टकराव खत्म हो जाएगा
RUN apt-get update && apt-get install -y wget && \
    wget https://postgresql.org -O /usr/local/tomcat/lib/postgresql-42.7.3.jar

EXPOSE 8080
CMD ["catalina.sh", "run"]
