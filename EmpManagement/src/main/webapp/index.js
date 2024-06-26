
document.addEventListener("DOMContentLoaded", function() {
    const themeSwitcher = document.getElementById("theme-switcher");
    const currentTheme = localStorage.getItem("theme") || "light-theme";

    document.body.className = currentTheme;

    themeSwitcher.addEventListener("click", function() {
        let newTheme = "light-theme";
        if (document.body.classList.contains("light-theme")) {
            newTheme = "dark-theme";
        }
        document.body.className = newTheme;
        localStorage.setItem("theme", newTheme);
    });
});

