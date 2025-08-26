# Sử dụng image Tomcat chính thức
FROM tomcat:9.0-jdk17

# Xóa các webapp mặc định (ROOT, docs, examples…) để Tomcat sạch sẽ
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR của bạn vào thư mục webapps, đổi tên thành ROOT.war
# để khi mở domain là chạy luôn (khỏi cần /survey_sol)
COPY survey_sol.war /usr/local/tomcat/webapps/ROOT.war

# Render yêu cầu app phải lắng nghe trên cổng $PORT
# => chỉnh lại server.xml để thay cổng 8080 bằng $PORT
RUN sed -i 's/port="8080"/port="${PORT}"/' /usr/local/tomcat/conf/server.xml

# Expose port (không bắt buộc, Render tự mapping nhưng để rõ ràng)
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
