<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduScore - Official Marksheet</title>
<!-- 🔗 आपकी एक्सटर्नल CSS फाइल -->
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<%
String searchRollNo = request.getParameter("rollno");

if (searchRollNo == null || searchRollNo.trim().isEmpty()) {
    response.sendRedirect("index.html");
    return;
}

Connection con = null;
PreparedStatement psCheck = null;
ResultSet rsCheck = null;

try {
    String url = "jdbc:postgresql://localhost:5432/eduscore_db";
    String unm = "postgres";
    String pwd = "Lucky@16"; 
    
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection(url, unm, pwd);
    
    String checkQuery = "SELECT * FROM student_results WHERE roll_no = ?";
    psCheck = con.prepareStatement(checkQuery);
    psCheck.setLong(1, Long.parseLong(searchRollNo.trim()));
    rsCheck = psCheck.executeQuery();

    if (rsCheck.next()) {
        long rollNo = rsCheck.getLong("roll_no");
        String name = rsCheck.getString("student_name");
        int hindi = rsCheck.getInt("hindi");
        int english = rsCheck.getInt("english");
        int math = rsCheck.getInt("math");
        int science = rsCheck.getInt("science");
        int sst = rsCheck.getInt("sst");
        int computer = rsCheck.getInt("computer");
        int total = rsCheck.getInt("total_marks");
        float percentage = rsCheck.getFloat("percentage");
        String grade = rsCheck.getString("grade");
        String status = rsCheck.getString("result_status");
%>
        <!-- 📄 आपकी मार्कशीट का मुख्य सफ़ेद कार्ड -->
        <div class="marksheet-card">
            
            <!-- 🏫 1. कॉलेज का लोगो कंटेनर -->
            <div class="logo-container">
                <img src="images/logo.png" alt="University Logo" class="marksheet-logo">
            </div>
            
            <h2 class="marksheet-title">EduScore Portal - Examination Result</h2>
            <h4 class="marksheet-subtitle">Provisional Statement of Marks</h4>
            
            <!-- 👤 सेक्शन 1: कैंडिडेट डिटेल्स टेबल (कोर्स वाली फालतू लाइन हटा दी गई है) -->
            <table class="marksheet-table details-table">
                <tr class="table-header"><th colspan="2">CANDIDATE DETAILS</th></tr>
                <tr><td class="bold-text">Roll No:</td><td><%= rollNo %></td></tr>
                <tr><td class="bold-text">Candidate Name:</td><td><%= name %></td></tr>
            </table>
            
            <!-- 📊 सेक्शन 2: मार्क्स डिटेल्स टेबल -->
            <table class="marksheet-table score-table">
                <tr class="table-header">
                    <th class="text-left">SUBJECT</th>
                    <th>MAX MARKS</th>
                    <th>MARKS OBTAINED</th>
                </tr>
                <tr><td class="text-left">HINDI</td><td>100</td><td><%= hindi %></td></tr>
                <tr><td class="text-left">ENGLISH</td><td>100</td><td><%= english %></td></tr>
                <tr><td class="text-left">MATHEMATICS</td><td>100</td><td><%= math %></td></tr>
                <tr><td class="text-left">SCIENCE</td><td>100</td><td><%= science %></td></tr>
                <tr><td class="text-left">SOCIAL STUDIES</td><td>100</td><td><%= sst %></td></tr>
                <tr><td class="text-left">COMPUTER SCIENCE</td><td>100</td><td><%= computer %></td></tr>
                
                <tr class="summary-row">
                    <td class="text-left">TOTAL MARKS</td>
                    <td>600</td>
                    <td><%= total %></td>
                </tr>
                <tr class="summary-row-white">
                    <td class="text-left">PERCENTAGE / GRADE</td>
                    <td><%= percentage %>%</td>
                    <td><%= grade %></td>
                </tr>
                <tr class="final-status-row">
                    <td class="text-left">FINAL RESULT</td>
                    <td colspan="2" class="status-text <%= status.equals("FAIL") ? "fail-color" : "pass-color" %>"><%= status %></td>
                </tr>
            </table>
            
            <!-- ⚠️ 5 ऑफिशियल डिस्क्लेमर लाइन्स -->
            <div class="disclaimer-box">
                <p class="disclaimer-title">DISCLAIMER / RULES:</p>
                <ol class="disclaimer-list">
                    <li>This is a Computer Generated Provisional Score Card. The results published on this portal are only for immediate information to the examinees and cannot be treated as official degree or original mark sheet.</li>
                    <li>Original statement of marks will be issued by the University Examination Board separately after thorough verification of physical records.</li>
                    <li>Neither the University Board nor the online service provider is responsible for any inadvertent or printing errors that may have crept into the score card data published on this hosting platform.</li>
                    <li>In case of any mismatch, clerical omission, or needed clarification, candidates are strictly advised to report immediately to the Registrar / Controller of Examinations.</li>
                    <li>Passing criteria requires a minimum of 33% marks in every individual subject. Failure in any single subject will result in an automatic 'FAIL' status on the overall card regardless of the final percentage.</li>
                </ol>
            </div>
            
            <!-- 🖨️ ऐक्शन्स लिंक्स/बटन्स -->
            <div class="actions-container">
                <a href="index.html" class="btn btn-inline">New Search</a>
                <button id="print-btn" class="btn btn-inline" onclick="window.print()">Print Result</button>
            </div>
            
        </div>
<%
    } else {
        out.print("<script type='text/javascript'>");
        out.print("alert('Result Not Found!\\nPlease check the Roll Number and try again.');");
        out.print("window.location.href='index.html';");
        out.print("</script>");
    }
} catch (Exception e) {
    out.print("<h3 style='color:red; text-align:center;'>System Error: " + e.getMessage() + "</h3>");
} finally {
    try { if(rsCheck != null) rsCheck.close(); } catch(Exception e) {}
    try { if(psCheck != null) psCheck.close(); } catch(Exception e) {}
    try { if(con != null) con.close(); } catch(Exception e) {}
}
%>

</body>
</html>
