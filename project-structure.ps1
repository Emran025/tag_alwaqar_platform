# تعيين اسم مجلد المشروع الرئيسي
$ProjectRoot = "my-educational-platform"

# إنشاء المجلد الرئيسي
New-Item -ItemType Directory -Path $ProjectRoot -Force

# الانتقال إلى المجلد الرئيسي
Set-Location -Path $ProjectRoot

# إنشاء مجلدات الأصول (assets)
New-Item -ItemType Directory -Path assets/css/abstracts -Force
New-Item -ItemType Directory -Path assets/css/base -Force
New-Item -ItemType Directory -Path assets/css/components -Force
New-Item -ItemType Directory -Path assets/css/layout -Force
New-Item -ItemType Directory -Path assets/css/pages -Force
New-Item -ItemType Directory -Path assets/css/vendor -Force
New-Item -ItemType Directory -Path assets/images/icons -Force
New-Item -ItemType Directory -Path assets/images/illustrations -Force
New-Item -ItemType Directory -Path assets/js/modules -Force

# إنشاء مجلد الصفحات (pages)
New-Item -ItemType Directory -Path pages -Force

# إنشاء مجلد الوثائق (docs)
New-Item -ItemType Directory -Path docs -Force

# إنشاء الملفات الأساسية
New-Item -ItemType File -Path assets/css/main.scss -Force
New-Item -ItemType File -Path assets/js/main.js -Force
New-Item -ItemType File -Path assets/js/vendor.js -Force

# إنشاء ملفات HTML الأساسية
New-Item -ItemType File -Path pages/index.html -Force
New-Item -ItemType File -Path pages/about-us.html -Force
New-Item -ItemType File -Path pages/contact-us.html -Force

# إنشاء ملفات الجذر (Root Files)
New-Item -ItemType File -Path .gitignore -Force
New-Item -ItemType File -Path CONTRIBUTING.md -Force
New-Item -ItemType File -Path README.md -Force

# إضافة محتوى إلى ملفات معينة
"node_modules`n`n# SASS compilation files`nassets/css/main.css" | Out-File -FilePath .gitignore
"نص ملف المساهمة الذي قمنا بإنشائه" | Out-File -FilePath CONTRIBUTING.md
"نص ملف README الذي قمنا بإنشائه" | Out-File -FilePath README.md
"<!DOCTYPE html>`n<html lang='ar' dir='rtl'>`n<head>`n    <meta charset='UTF-8'>`n    <meta name='viewport' content='width=device-width, initial-scale=1.0'>`n    <title>المنصة التعليمية</title>`n    <link rel='stylesheet' href='../assets/css/main.css'>`n</head>`n<body>`n    <header>`n        <h1>المنصة التعليمية</h1>`n    </header>`n    <main>`n        <p>مرحباً بكم في صفحتنا الرئيسية.</p>`n    </main>`n    <footer>`n        <p>&copy; 2025 المنصة التعليمية</p>`n    </footer>`n    <script src='../assets/js/main.js'></script>`n</body>`n</html>" | Out-File -FilePath pages/index.html
"" | Out-File -FilePath assets/css/main.scss
"" | Out-File -FilePath assets/js/main.js

# رسالة تأكيد النجاح
Write-Host "✅ تم إنشاء هيكل المشروع بنجاح في مجلد '$ProjectRoot'." -ForegroundColor Green