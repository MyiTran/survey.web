FROM openjdk:24-jdk-slim AS base

# Cài wget + tar để tải Tomcat
RUN apt-get update && apt-get install -y wget tar && rm -rf /var/lib/apt/lists/*

# Tải và cài Tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz \
    && tar xzf apache-tomcat-9.0.108.tar.gz \
    && mv apache-tomcat-9.0.108 /usr/local/tomcat \
    && rm apache-tomcat-9.0.108.tar.gz

# Biến môi trường Tomcat
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Xóa webapps mặc định và copy file WAR của bạn vào ROOT
RUN rm -rf /usr/local/tomcat/webapps/*
COPY survey_sol.war /usr/local/tomcat/webapps/ROOT.war

# Render cung cấp biến môi trường PORT, ta cần Tomcat lắng nghe ở đó
RUN sed -i 's/port="8080"/port="${PORT}"/' /usr/local/tomcat/conf/server.xml

# Expose port
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
