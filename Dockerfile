FROM tomcat:9.0-jdk17-openjdk-slim

# 1. सीधे इंटरनेट से सबसे भरोसेमंद PostgreSQL ड्राइवर डाउनलोड करना
ADD https://postgresql.org /usr/local/tomcat/lib/

# 2. पूरे प्रोजेक्ट को सीधे टॉमकेट के webapps फोल्डर में कॉपी करना
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

# 3. जावा इंजन को लाइव क्लाउड (Neon SSL) से सुरक्षित हाथ मिलाने (Handshake) की परमिशन देना
ENV JAVA_OPTS="-Djsse.enableSNIExtension=true"

CMD ["catalina.sh", "run"]
