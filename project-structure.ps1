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
New-Item -ItemType File -Force -Path "assets/css/abstracts/_variables.scss"
New-Item -ItemType File -Force -Path "assets/css/abstracts/_mixins.scss"
New-Item -ItemType File -Force -Path "assets/css/base/_base.scss"
New-Item -ItemType File -Force -Path "assets/css/components/_buttons.scss"
New-Item -ItemType File -Force -Path "assets/css/components/_forms.scss"
New-Item -ItemType File -Force -Path "assets/css/layout/_header.scss"
New-Item -ItemType File -Force -Path "assets/css/layout/_header.scss"
New-Item -ItemType File -Force -Path "assets/css/layout/_grid.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_homepage.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_about.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/school-registration.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_achievements.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_contact-us.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_contribute.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_school-blog.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_school-page.scss"
New-Item -ItemType File -Force -Path "assets/css/pages/_blog.scss"
# New-Item -ItemType File -Force -Path "assets/css/pages/_platform-blog.scss"
New-Item -ItemType File -Force -Path "assets/js/main.js"
New-Item -ItemType File -Force -Path "assets/js/vendor.js"
New-Item -ItemType File -Force -Path "assets/js/counter.js"
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
New-Item -ItemType File -Force -Path "pages/schools.html"
New-Item -ItemType File -Force -Path "pages/contribute.html"

New-Item -ItemType File -Force -Path ".gitignore"
# New-Item -ItemType File -Force -Path "CONTRIBUTING.md"
# New-Item -ItemType File -Force -Path "README.md"
New-Item -ItemType File -Force -Path "docs/srs-document.md"

Write-Host "Project structure created successfully. Ready for development." -ForegroundColor Green

# for build this tree you have to follow this steps :
#       1. build folder and make it name tag_alwaqar_platform 
#       2. open terminal with powersell and get this command:  ./project-structure.ps1







# This script collects all file contents from the project structure into a single text file

# Define output file
$outputFile = "project-contents.txt"

Write-Host "جمع محتويات الملفات إلى $outputFile ..." -ForegroundColor Cyan

# Initialize output file with a header
"=== محتويات مشروع technical_laboratory ===`n" | Out-File -FilePath $outputFile -Encoding UTF8
"تم إنشاء هذا الملف في: $(Get-Date)`n" | Out-File -FilePath $outputFile -Encoding UTF8 -Append

# Function to process files and add their contents to the output
function Process-Files {
    param([string]$path)
    
    Get-ChildItem -Path $path -File | ForEach-Object {
        $relativePath = $_.FullName.Substring((Get-Location).Path.Length + 1)
        "`n" + "="*80 | Out-File -FilePath $outputFile -Encoding UTF8 -Append
        "ملف: $relativePath" | Out-File -FilePath $outputFile -Encoding UTF8 -Append
        "="*80 | Out-File -FilePath $outputFile -Encoding UTF8 -Append
        
        try {
            # Try to read the file as text
            $content = Get-Content -Path $_.FullName -Raw -Encoding UTF8
            $content | Out-File -FilePath $outputFile -Encoding UTF8 -Append
        }
        catch {
            # If it's a binary file, note that instead
            "[ملف غير نصي - لا يمكن عرض المحتوى]" | Out-File -FilePath $outputFile -Encoding UTF8 -Append
        }
    }
    
    # Process subdirectories recursively
    Get-ChildItem -Path $path -Directory | ForEach-Object {
        Process-Files -path $_.FullName
    }
}

# Start processing from the current directory
Process-Files -path "."

Write-Host "تم تجميع المحتويات بنجاح في ملف $outputFile" -ForegroundColor Green

