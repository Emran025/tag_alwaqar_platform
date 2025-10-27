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
    menuToggle.addEventListener("click", () => {
        if (mobileNav) mobileNav.classList.add("active");
        if (mobileOverlay) mobileOverlay.classList.add("active");
        document.body.style.overflow = "hidden";
    });
}

// إغلاق القائمة المتنقلة
function closeMobileNav() {
  if (mobileNav) mobileNav.classList.remove("active");
  if (mobileOverlay) mobileOverlay.classList.remove("active");
  document.body.style.overflow = "";
}

if (mobileNavClose) {
    mobileNavClose.addEventListener("click", closeMobileNav);
}

if (mobileOverlay) {
    mobileOverlay.addEventListener("click", closeMobileNav);
}

// فتح نافذة تسجيل الدخول
if (loginButtons) {
    loginButtons.forEach((button) => {
      button.addEventListener("click", () => {
        if (loginDialog) loginDialog.classList.add("active");
        document.body.style.overflow = "hidden";
      });
    });
}


// إغلاق نافذة تسجيل الدخول
if (dialogClose) {
    dialogClose.addEventListener("click", () => {
      if (loginDialog) loginDialog.classList.remove("active");
      document.body.style.overflow = "";
    });
}

// إغلاق النافذة عند النقر خارجها
if (loginDialog) {
    loginDialog.addEventListener("click", (e) => {
      if (e.target === loginDialog) {
        loginDialog.classList.remove("active");
        document.body.style.overflow = "";
      }
    });
}


// إغلاق النوافذ عند الضغط على مفتاح Escape
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    if (filterModal && filterModal.classList.contains("show")) {
      closeModal();
    }
    if (loginDialog && loginDialog.classList.contains("active")) {
      loginDialog.classList.remove("active");
      document.body.style.overflow = "";
    }
    if (mobileNav && mobileNav.classList.contains("active")) {
      closeMobileNav();
    }
  }
});
// -----------------------------------------------------------------------------
// School Page-Specific JavaScript
// -----------------------------------------------------------------------------

/**
 * Initializes the animated counters for school statistics.
 */
function initSchoolCounters() {
    const counters = document.querySelectorAll('.stat-number');
    const speed = 200; // The lower the number, the faster the count

    counters.forEach(counter => {
        const animate = () => {
            const target = +counter.getAttribute('data-target');
            const count = +counter.innerText;

            // Calculate the increment
            const inc = target / speed;

            if (count < target) {
                // Add increment to count and ceil it
                counter.innerText = Math.ceil(count + inc);
                // Call function every ms
                setTimeout(animate, 1);
            } else {
                counter.innerText = target;
            }
        };

        animate();
    });
}

// Run the counter initialization when the page loads
document.addEventListener('DOMContentLoaded', initSchoolCounters);
