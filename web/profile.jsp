<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Profile</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/theme.js" defer></script>
</head>
<body>
<nav>
    <div class="logo-section">
        <img src="images/logo1.png" alt="Logo" class="logo">
    </div>
    <button class="mode-toggle">🌙/☀️</button>
</nav>

<div class="container">
    <h1>Your Profile</h1>

    <div class="result-box" id="profileCard">
        <p class="result-item"><strong>Name:</strong> ${name}</p>
        <p class="result-item"><strong>Student ID:</strong> ${studentID}</p>
        <p class="result-item"><strong>Program:</strong> ${program}</p>
        <p class="result-item"><strong>Email:</strong> ${email}</p>
        <p class="result-item"><strong>Hobbies:</strong> ${hobbies}</p>
        <p class="result-item"><strong>About Me:</strong> ${about}</p>
    </div>

    <div style="margin-top: 25px;">
        <a href="index.html"><button class="btn">Back to Home</button></a>
        <a href="profile.html"><button class="btn">Edit Profile</button></a>
        <!-- Print Button -->
        <button class="btn" onclick="printProfile()">Print / Download</button>
    </div>
</div>

<script>
function printProfile() {
    const profileContent = document.getElementById("profileCard").innerHTML;
    const printWindow = window.open('', '', 'height=600,width=800');
    printWindow.document.write('<html><head><title>Print Profile</title>');
    printWindow.document.write('<link rel="stylesheet" href="css/style.css">'); // optional styling
    printWindow.document.write('</head><body>');
    printWindow.document.write('<h1>Your Profile</h1>');
    printWindow.document.write(profileContent);
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    printWindow.print();
}
</script>
<footer>
    © 2025 Starshine University | Designed by Imannur Umairah
</footer>
</body>
</html>
