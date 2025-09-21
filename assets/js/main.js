// عناصر DOM
const menuToggle = document.querySelector(".menu-toggle");
const mobileNav = document.getElementById("mobileNav");
const mobileOverlay = document.getElementById("mobileOverlay");
const mobileNavClose = document.querySelector(".mobile-nav-close");
const loginButtons = document.querySelectorAll(".login-button");
const loginDialog = document.getElementById("loginDialog");
const dialogClose = document.querySelector(".dialog-close");

// عناصر DOM
const mainNav = document.querySelector(".main-nav");
const filterModal = document.getElementById("filterModal");
const openFilterModalBtn = document.querySelector(".search-button");
const closeFilterModalBtn = document.getElementById("closeFilterModal");
const applyFiltersBtn = document.querySelector(".filter-apply");
const citySelect = document.getElementById("modal-city");
const curriculumSelect = document.getElementById("modal-curriculum");
const stageSelect = document.getElementById("modal-stage");

// دالة لإظهار نافذة الفلاتر
function openModal() {
  // استخدام فئة 'show' الموجودة في CSS
  filterModal.classList.add("show");
  // إضافة فئة لتعتيم الخلفية
  document.body.classList.add("modal-open");
}

// دالة لإخفاء نافذة الفلاتر
function closeModal() {
  // إزالة فئة 'show' لإخفاء النافذة
  filterModal.classList.remove("show");
  // إزالة فئة تعتيم الخلفية
  document.body.classList.remove("modal-open");
}

// دالة لفتح القائمة المتنقلة
function openMobileNav() {
  mainNav.classList.add("active");
  document.body.style.overflow = "hidden";
}

// دالة لإغلاق القائمة المتنقلة
function closeMobileNav() {
  mainNav.classList.remove("active");
  document.body.style.overflow = "";
}

// مستمعي الأحداث
if (openFilterModalBtn) {
  openFilterModalBtn.addEventListener("click", (event) => {
    // منع السلوك الافتراضي لزر الإرسال داخل النموذج
    event.preventDefault();
    openModal();
  });
}

if (closeFilterModalBtn) {
  closeFilterModalBtn.addEventListener("click", closeModal);
}

// إغلاق النافذة عند الضغط خارج محتوى النافذة
if (filterModal) {
  filterModal.addEventListener("click", (event) => {
    if (event.target === filterModal) {
      closeModal();
    }
  });
}

// معالجة حدث الضغط على زر "تطبيق الفلاتر"
if (applyFiltersBtn) {
  applyFiltersBtn.addEventListener("click", () => {
    const selectedCity = citySelect.value;
    const selectedCurriculum = curriculumSelect.value;
    const selectedStage = stageSelect.value;

    console.log("--- Filter Values Applied ---");
    console.log("City:", selectedCity);
    console.log("Curriculum:", selectedCurriculum);
    console.log("Stage:", selectedStage);
    console.log("------------------------------");

    closeModal();
  });
}

// فتح القائمة المتنقلة
if (menuToggle) {
  menuToggle.addEventListener("click", openMobileNav);
}

// إغلاق القائمة المتنقلة عند الضغط على أي رابط داخلها
if (mainNav) {
  mainNav.addEventListener("click", (event) => {
    if (event.target.tagName === "A") {
      closeMobileNav();
    }
  });
}

// إغلاق النوافذ عند الضغط على مفتاح Escape
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    if (filterModal.classList.contains("show")) {
      closeModal();
    }
    if (mainNav.classList.contains("active")) {
      closeMobileNav();
    }
  }
});

// فتح القائمة المتنقلة
menuToggle.addEventListener("click", () => {
  mobileNav.classList.add("active");
  mobileOverlay.classList.add("active");
  document.body.style.overflow = "hidden";
});

// إغلاق القائمة المتنقلة
function closeMobileNav() {
  mobileNav.classList.remove("active");
  mobileOverlay.classList.remove("active");
  document.body.style.overflow = "";
}

mobileNavClose.addEventListener("click", closeMobileNav);
mobileOverlay.addEventListener("click", closeMobileNav);

// فتح نافذة تسجيل الدخول
loginButtons.forEach((button) => {
  button.addEventListener("click", () => {
    loginDialog.classList.add("active");
    document.body.style.overflow = "hidden";
  });
});

// إغلاق نافذة تسجيل الدخول
dialogClose.addEventListener("click", () => {
  loginDialog.classList.remove("active");
  document.body.style.overflow = "";
});

// إغلاق النافذة عند النقر خارجها
loginDialog.addEventListener("click", (e) => {
  if (e.target === loginDialog) {
    loginDialog.classList.remove("active");
    document.body.style.overflow = "";
  }
});

// إغلاق النوافذ عند الضغط على مفتاح Escape
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    loginDialog.classList.remove("active");
    closeMobileNav();
  }
});
