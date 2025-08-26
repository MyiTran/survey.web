FROM openjdk:24-jdk-slim AS base

RUN apt-get update && apt-get install -y wget tar && rm -rf /var/lib/apt/lists/*

RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz \
    && tar xzf apache-tomcat-9.0.108.tar.gz \
    && mv apache-tomcat-9.0.108 /usr/local/tomcat \
    && rm apache-tomcat-9.0.108.tar.gz

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

RUN rm -rf /usr/local/tomcat/webapps/*
COPY survey_sol.war /usr/local/tomcat/webapps/ROOT.war

RUN sed -i 's/port="8080"/port="${PORT}"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080
CMD ["catalina.sh", "run"]
