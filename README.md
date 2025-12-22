# Starshine University Student Profile Management System

## Requirements
- NetBeans IDE
- MySQL Server
- GlassFish / Tomcat
- MySQL Connector/J

## Database Setup
1. Open MySQL Workbench
2. Run `database/student_profiles.sql`
3. Database name: student_profiles

## Database Configuration
If MySQL root has a password, update in the servlets:

```java
String DB_USER = "root";
String DB_PASSWORD = "";
