<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, WEB-INF.classes.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduPortal</title>
</head>
<body>
<%
Connection con = null;
PreparedStatement psCheck = null;
PreparedStatement psmt = null;
ResultSet rsCheck = null;

try {
    // 1. फॉर्म से डेटा कलेक्ट करना
    long rollno = Long.parseLong(request.getParameter("rollno"));
    String name = request.getParameter("name");
    int hindi = Integer.parseInt(request.getParameter("hindi"));
    int english = Integer.parseInt(request.getParameter("english"));
    int math = Integer.parseInt(request.getParameter("math"));
    int science = Integer.parseInt(request.getParameter("science"));
    int sst = Integer.parseInt(request.getParameter("sst"));
    int computer = Integer.parseInt(request.getParameter("computer"));

    // 2. कैलकुलेशन और लॉजिक
    int total_marks = hindi + english + math + science + sst + computer;
    float percentage = total_marks / 6.0f; 

    String grade = "";
    String result_status = "";

    // पहले चेक करें कि छात्र किसी विषय में फेल तो नहीं है
    if (hindi < 33 || english < 33 || math < 33 || science < 33 || sst < 33 || computer < 33) {
        grade = "F";
        result_status = "FAIL";
    } 
    else {
        result_status = "PASS";
        
        if (percentage >= 90) {
            grade = "A+";
        } else if (percentage >= 80) {
            grade = "A";
        } else if (percentage >= 70) {
            grade = "B";
        } else if (percentage >= 60) {
            grade = "C";
        } else if (percentage >= 50) {
            grade = "D";
        } else {
            grade = "E";
        }
    }

    // 3. डेटाबेस कनेक्शन
    con = classes.DBConnection.getConnection();
    // 🔥 जादू यहाँ है: INSERT से पहले SELECT करके चेक करना
    String checkQuery = "SELECT roll_no FROM student_results WHERE roll_no = ?";
    psCheck = con.prepareStatement(checkQuery);
    psCheck.setLong(1, rollno);
    rsCheck = psCheck.executeQuery();
    
    if (rsCheck.next()) {
        // अगर रोल नंबर पहले से मौजूद है, तो यहीं से अलर्ट दिखाकर वापस भेज दो
        out.print("<script type='text/javascript'>");
        out.print("alert('Wait! This Student Result is already uploaded.\\n\\nPlease upload another student result.');");
        out.print("window.location.href='add-result.html';"); 
        out.print("</script>");
        return; // आगे का INSERT कोड रन नहीं होगा
    }

    // 4. अगर रोल नंबर नया है, तभी INSERT क्वेरी चलेगी
    String Query = "INSERT INTO student_results (roll_no, student_name, hindi, english, math, science, sst, computer, total_marks, percentage, grade, result_status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
    psmt = con.prepareStatement(Query);
    psmt.setLong(1, rollno);
    psmt.setString(2, name);
    psmt.setInt(3, hindi);
    psmt.setInt(4, english);
    psmt.setInt(5, math);
    psmt.setInt(6, science);
    psmt.setInt(7, sst);
    psmt.setInt(8, computer);
    psmt.setInt(9, total_marks);
    psmt.setFloat(10, percentage);
    psmt.setString(11, grade);
    psmt.setString(12, result_status);
    
    int r = psmt.executeUpdate();
    
    if(r > 0) {
        out.print("<script type='text/javascript'>");
        out.print("alert('Success! Student Result Uploaded Successfully.');");
        out.print("window.location.href='add-result.html';"); 
        out.print("</script>");
    }

} catch (Exception e) {
    // बैकअप के लिए सादा टेक्स्ट एरर स्क्रीन पर प्रिंट करना (अगर ड्राइवर या पासवर्ड की दिक्कत हो)
    out.print("<h3>Unexpected System Error:</h3> " + e.getMessage());
    System.out.println(e);
} finally {
    // रिसोर्सेज को सुरक्षित तरीके से बंद करना
    try { if(rsCheck != null) rsCheck.close(); } catch(Exception e) {}
    try { if(psCheck != null) psCheck.close(); } catch(Exception e) {}
    try { if(psmt != null) psmt.close(); } catch(Exception e) {}
    try { if(con != null) con.close(); } catch(Exception e) {}
}
%>
</body>
</html>
