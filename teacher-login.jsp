<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Teacher Security Gateway</title>
</head>
<body>
<% 
// 1. index.html के फॉर्म से डेटा रिसीव करना
String teacher_id = request.getParameter("teacher_id");
String password = request.getParameter("password");

// 2. सुरक्षा जांच (लॉगिन ऑथेंटिकेशन)
if(teacher_id.equals("Admin") && password.equals("Admin@123")){
	
	// 🔥 सुधार: सही होने पर सीधे मार्क्स अपलोड करने वाले फॉर्म पेज पर भेजें
	response.sendRedirect("add-result.html");
}
else {
	// 3. गलत होने पर एरर अलर्ट और वापस होमपेज पर ट्रांसफर
	out.print("<script type='text/javascript'>");
    out.print("alert('Access Denied! Invalid Teacher ID or Password.');");
    out.print("window.location.href='index.html';");
    out.print("</script>");
}
%>
</body>
</html>
