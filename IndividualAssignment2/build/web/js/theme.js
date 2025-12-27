const toggleBtn = document.querySelector(".mode-toggle");

toggleBtn.addEventListener("click", () => {
    document.body.classList.toggle("dark");

    if (document.body.classList.contains("dark")) {
        localStorage.setItem("mode", "dark");
    } else {
        localStorage.setItem("mode", "light");
    }
});

// Load saved mode
window.addEventListener("DOMContentLoaded", () => {
    if (localStorage.getItem("mode") === "dark") {
        document.body.classList.add("dark");
    }
});
