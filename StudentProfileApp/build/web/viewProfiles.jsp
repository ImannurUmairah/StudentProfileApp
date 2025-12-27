<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View All Profiles</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/theme.js" defer></script>
    <style>
        /* ---------- Container ---------- */
        .container {
            max-width: 1000px;
            width: 95%;
            margin: 50px auto;
            padding: 20px 30px;
            background: rgba(255,255,255,0.9);
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        /* ---------- Table ---------- */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #333;
            padding: 10px;
            text-align: left;
            color: #000; 
        th {
            background-color: #eee;
        }

        /* ---------- Search Input ---------- */
        input[type="text"] {
            padding: 8px;
            width: 250px;
            margin-right: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        /* ---------- Buttons ---------- */
        button, a button {
            background: #ffadad;
            color: #fff; 
            padding: 6px 12px;
            margin: 5px 2px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        button:hover, a button:hover {
            background: #ff6f91;
            transform: scale(1.05);
        }

        /* ---------- Mode Toggle ---------- */
        .mode-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #a8d5ba;
            color: #333;
            font-size: 20px;
            border-radius: 12px;
            padding: 8px 15px;
            transition: all 0.3s ease;
        }
        .mode-toggle:hover {
            background: #ffd6a5;
            transform: scale(1.1);
        }

        h1 {
            color: #ff6f91;
        }
    </style>
</head>
<body>

<nav>
    <div class="logo-section">
        <img src="images/logo1.png" alt="Logo" class="logo">
    </div>
    <button class="mode-toggle">🌙/☀️</button>
</nav>

<div class="container">
    <h1>All Student Profiles</h1>

    <!-- Search Form -->
    <form method="get">
        <input type="text" name="search" placeholder="Search by Name or Student ID" 
               value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <button type="submit">Search</button>
    </form>

<%
    String url = "jdbc:derby://localhost:1527/student_profiles";
    String user = "app";
    String pass = "app";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(url, user, pass);

        String search = request.getParameter("search");
        String sql = "SELECT * FROM STUDENT_PROFILES";

        if (search != null && !search.trim().isEmpty()) {
            sql += " WHERE UPPER(name) LIKE ? OR UPPER(studentID) LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + search.toUpperCase() + "%");
            ps.setString(2, "%" + search.toUpperCase() + "%");
        } else {
            ps = conn.prepareStatement(sql);
        }
        rs = ps.executeQuery();
%>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Student ID</th>
            <th>Program</th>
            <th>Email</th>
            <th>Hobbies</th>
            <th>About Me</th>
            <th>Actions</th>
        </tr>

<%
        while(rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("studentID") %></td>
            <td><%= rs.getString("program") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("hobbies") %></td>
            <td><%= rs.getString("about") %></td>
            <td>
                <a href="editProfile.jsp?id=<%= rs.getInt("id") %>"><button>Edit</button></a>
                <a href="DeleteProfileServlet?id=<%= rs.getInt("id") %>" 
                   onclick="return confirm('Are you sure you want to delete this profile?');">
                   <button>Delete</button>
                </a>
            </td>
        </tr>
<%
        }
%>
    </table>

<%
    } catch(Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if(rs!=null) rs.close(); } catch(Exception e){}
        try { if(ps!=null) ps.close(); } catch(Exception e){}
        try { if(conn!=null) conn.close(); } catch(Exception e){}
    }
%>

    <div style="margin-top: 20px;">
        <a href="index.html"><button>Back to Home</button></a>
        <a href="profile.html"><button>Create New Profile</button></a>
    </div>
</div>

<footer>
    © 2025 Starshine University | Designed by Imannur Umairah
</footer>
</body>
</html>
