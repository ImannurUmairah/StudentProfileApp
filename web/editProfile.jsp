<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String dbURL = "jdbc:mysql://localhost:3306/student_profiles";
    String dbUser = "root";
    String dbPass = "";
    String name = "", studentID = "", program = "", email = "", hobbies = "", about = "";

    if(id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM profile WHERE id=?");
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                name = rs.getString("name");
                studentID = rs.getString("studentID");
                program = rs.getString("program");
                email = rs.getString("email");
                hobbies = rs.getString("hobbies");
                about = rs.getString("about");
            }
            rs.close();
            ps.close();
            conn.close();
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/theme.js" defer></script>
    <style>
        /* ---------- Form Layout ---------- */
        form label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            text-align: left;
        }

        form input[type="text"],
        form input[type="email"],
        form textarea {
            display: block;
            width: 100%;
            margin-top: 5px;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        form textarea {
            resize: vertical;
        }

        /* ---------- Buttons ---------- */
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button-group button,
        .button-group .btn.cancel-btn {
            width: 48%;
            padding: 12px;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            color: #fff;
            transition: all 0.3s ease;
        }

        /* Update button style */
        .button-group button {
            background: #ff6f91;
        }

        .button-group button:hover {
            background: #ff3d6f;
        }

        /* Cancel button style */
        .button-group .btn.cancel-btn {
            background: #aaa;
        }

        .button-group .btn.cancel-btn:hover {
            background: #777;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Edit Profile</h1>
    <form action="UpdateProfileServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">

        <label>Name:</label>
        <input type="text" name="name" value="<%= name %>" required>

        <label>Student ID:</label>
        <input type="text" name="studentID" value="<%= studentID %>" required>

        <label>Program:</label>
        <input type="text" name="program" value="<%= program %>" required>

        <label>Email:</label>
        <input type="email" name="email" value="<%= email %>" required>

        <label>Hobbies:</label>
        <input type="text" name="hobbies" value="<%= hobbies %>">

        <label>About Me:</label>
        <textarea name="about" rows="4"><%= about %></textarea>

        <div class="button-group">
            <button type="submit">Update Profile</button>
            <a href="viewProfiles.jsp" class="btn cancel-btn">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
