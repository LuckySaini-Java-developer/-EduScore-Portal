# 🎓 EduScore-Portal - Student Result Management System

EduScore Portal is a secure and role-based student web portal built using Java Web Technologies (JSP) and PostgreSQL. It features clean segregation of modules between Students and Faculty.

## 🚀 Core Features
- **Secure Teacher Gateway:** Form-level authentication to secure student mark entry.
- **Smart PostgreSQL Integration:** Duplication filter that automatically checks and blocks pre-existing Roll Numbers using backend query logic.
- **Official Tabular Marksheet View:** Dynamic data rendering from a PostgreSQL database into an official-looking university report card format.
- **A4 Print Engine:** Embedded printer utility with custom `@media print` rules to ensure proper scaling on physical sheets while auto-hiding navigation controls.
- **Client-Side Validation:** Inline JavaScript restriction framework preventing values greater than 100 or lower than 0 in standard grids.

## 🛠️ Tech Stack & Architecture
- **Backend Infrastructure:** Java Runtime Environment, JSP (JavaServer Pages), JDBC API
- **Database Engine:** PostgreSQL Database Engine
- **Presentation Layer:** Semantic HTML5, Dynamic CSS3 (Flexbox & Multi-Column Layout Grid), Client-Side JavaScript
- **Application Deployment:** Apache Tomcat Web Server v9.0
