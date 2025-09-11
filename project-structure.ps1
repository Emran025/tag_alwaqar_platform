# This script creates a professional and standardized project structure
# for the educational platform's front-end interface.

# The script does not automatically create the project root directory
# or fill files with content to give the user full control.

Write-Host "Starting project structure creation..." -ForegroundColor Cyan

# --- Main Directories ---
# This section creates the top-level directories for the project.
New-Item -ItemType Directory -Force -Path "assets"
New-Item -ItemType Directory -Force -Path "pages"
New-Item -ItemType Directory -Force -Path "docs"

# --- Assets Directories ---
# This section creates all subdirectories within the 'assets' folder
# to organize CSS, JavaScript, and images according to best practices.
New-Item -ItemType Directory -Force -Path "assets/css"
New-Item -ItemType Directory -Force -Path "assets/css/abstracts"
New-Item -ItemType Directory -Force -Path "assets/css/base"
New-Item -ItemType Directory -Force -Path "assets/css/components"
New-Item -ItemType Directory -Force -Path "assets/css/layout"
New-Item -ItemType Directory -Force -Path "assets/css/pages"
New-Item -ItemType Directory -Force -Path "assets/css/themes"
New-Item -ItemType Directory -Force -Path "assets/css/vendors"

New-Item -ItemType Directory -Force -Path "assets/js"
New-Item -ItemType Directory -Force -Path "assets/js/modules"
New-Item -ItemType Directory -Force -Path "assets/js/utils"

New-Item -ItemType Directory -Force -Path "assets/images"
New-Item -ItemType Directory -Force -Path "assets/images/icons"
New-Item -ItemType Directory -Force -Path "assets/images/illustrations"

# --- Core Files ---
# This section creates all the necessary files at the root and within
# the main directories, serving as the project's foundation.
New-Item -ItemType File -Force -Path "assets/css/main.scss"
New-Item -ItemType File -Force -Path "assets/js/main.js"
New-Item -ItemType File -Force -Path "assets/js/vendor.js"
New-Item -ItemType File -Force -Path "assets/js/modules/school-registration.js"
New-Item -ItemType File -Force -Path "assets/js/modules/school-blog-page.js"
New-Item -ItemType File -Force -Path "assets/js/modules/student-registration.js"
New-Item -ItemType File -Force -Path "assets/js/modules/teacher-registration.js"
New-Item -ItemType File -Force -Path "assets/js/modules/achievements.js"
New-Item -ItemType File -Force -Path "assets/js/modules/about-us-and-policies.js"

New-Item -ItemType File -Force -Path "pages/index.html"
New-Item -ItemType File -Force -Path "pages/school-registration.html"
New-Item -ItemType File -Force -Path "pages/school-blog-page.html"
New-Item -ItemType File -Force -Path "pages/student-registration.html"
New-Item -ItemType File -Force -Path "pages/teacher-registration.html"
New-Item -ItemType File -Force -Path "pages/about-us-and-policies.html"
New-Item -ItemType File -Force -Path "pages/achievements.html"
New-Item -ItemType File -Force -Path "pages/contact-us.html"

New-Item -ItemType File -Force -Path ".gitignore"
# New-Item -ItemType File -Force -Path "CONTRIBUTING.md"
# New-Item -ItemType File -Force -Path "README.md"
New-Item -ItemType File -Force -Path "docs/srs-document.md"

Write-Host "Project structure created successfully. Ready for development." -ForegroundColor Green

# for build this tree you have to follow this steps :
#       1. build folder and make it name tag_alwaqar_platform 
#       2. open terminal with powersell and get this command:  ./project-structure.ps1
