// -----------------------------------------------------------------------------
// General Site Logic (Navigation, Filters, Login)
// -----------------------------------------------------------------------------

// عناصر DOM العامة
const menuToggle = document.querySelector(".menu-toggle");
const mobileNav = document.getElementById("mobileNav");
const mobileOverlay = document.getElementById("mobileOverlay");
const mobileNavClose = document.querySelector(".mobile-nav-close");
const loginButtons = document.querySelectorAll(".login-button");
const loginDialog = document.getElementById("loginDialog");
const dialogClose = document.querySelector(".dialog-close");

// عناصر الفلترة
const mainNav = document.querySelector(".main-nav");
const filterModal = document.getElementById("filterModal");
const openFilterModalBtn = document.querySelector(".search-button");
const closeFilterModalBtn = document.getElementById("closeFilterModal");
const applyFiltersBtn = document.querySelector(".filter-apply");
const citySelect = document.getElementById("modal-city");
const curriculumSelect = document.getElementById("modal-curriculum");
const stageSelect = document.getElementById("modal-stage");

// --- منطق الفلترة ---
function openModal() {
  if (filterModal) {
    filterModal.classList.add("show");
    document.body.classList.add("modal-open");
  }
}

function closeModal() {
  if (filterModal) {
    filterModal.classList.remove("show");
    document.body.classList.remove("modal-open");
  }
}

if (openFilterModalBtn) {
  openFilterModalBtn.addEventListener("click", (event) => {
    event.preventDefault();
    openModal();
  });
}

if (closeFilterModalBtn) {
  closeFilterModalBtn.addEventListener("click", closeModal);
}

if (filterModal) {
  filterModal.addEventListener("click", (event) => {
    if (event.target === filterModal) {
      closeModal();
    }
  });
}

if (applyFiltersBtn) {
  applyFiltersBtn.addEventListener("click", () => {
    // يمكنك إضافة منطق الفلترة هنا
    closeModal();
  });
}

// --- القائمة المتنقلة (Mobile Nav) ---
if (menuToggle) {
  menuToggle.addEventListener("click", () => {
    if (mobileNav) mobileNav.classList.add("active");
    if (mobileOverlay) mobileOverlay.classList.add("active");
    document.body.style.overflow = "hidden";
  });
}

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

// --- نافذة تسجيل الدخول ---
if (loginButtons) {
  loginButtons.forEach((button) => {
    button.addEventListener("click", () => {
      if (loginDialog) loginDialog.classList.add("active");
      document.body.style.overflow = "hidden";
    });
  });
}

// إغلاق عام للنوافذ عند الضغط على زر الإغلاق
// ملاحظة: هذا يعالج زر الإغلاق العام، وسيتم معالجة أزرار لوحة التحكم لاحقاً بشكل منفصل
if (dialogClose) {
  dialogClose.addEventListener("click", () => {
    if (loginDialog) loginDialog.classList.remove("active");
    document.body.style.overflow = "";
  });
}

if (loginDialog) {
  loginDialog.addEventListener("click", (e) => {
    if (e.target === loginDialog) {
      loginDialog.classList.remove("active");
      document.body.style.overflow = "";
    }
  });
}

// إغلاق النوافذ بمفتاح Escape
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    if (filterModal && filterModal.classList.contains("show")) closeModal();
    if (loginDialog && loginDialog.classList.contains("active")) {
      loginDialog.classList.remove("active");
      document.body.style.overflow = "";
    }
    if (mobileNav && mobileNav.classList.contains("active")) closeMobileNav();
  }
});

// -----------------------------------------------------------------------------
// School Page-Specific JavaScript (Counters)
// -----------------------------------------------------------------------------

function initSchoolCounters() {
  const counters = document.querySelectorAll(".stat-number");
  const speed = 200;

  if (counters.length === 0) return;

  counters.forEach((counter) => {
    const animate = () => {
      const target = +counter.getAttribute("data-target");
      const count = +counter.innerText;
      const inc = target / speed;

      if (count < target) {
        counter.innerText = Math.ceil(count + inc);
        setTimeout(animate, 1);
      } else {
        counter.innerText = target;
      }
    };
    animate();
  });
}

document.addEventListener("DOMContentLoaded", initSchoolCounters);

// -----------------------------------------------------------------------------
// Control Panel-Specific JavaScript (Updated for New UI)
// -----------------------------------------------------------------------------

document.addEventListener("DOMContentLoaded", () => {
  // 1. Tab Switching Logic (Updated Class Name: .tab-btn)
  const tabs = document.querySelectorAll(".tab-btn");
  const tabContents = document.querySelectorAll(".tab-content");

  if (tabs.length > 0) {
    tabs.forEach((tab) => {
      tab.addEventListener("click", () => {
        const targetId = tab.dataset.tab;
        const targetContent = document.getElementById(targetId);

        // إزالة التفعيل من جميع الأزرار والمحتوى
        tabs.forEach((t) => t.classList.remove("active"));
        tabContents.forEach((c) => c.classList.remove("active"));

        // تفعيل الزر المضغوط والمحتوى المستهدف
        tab.classList.add("active");
        if (targetContent) {
          targetContent.classList.add("active");
        }
      });
    });
  }

  // 2. Dialog Management (Control Panel Specific)
  const applicantProfileDialog = document.getElementById(
    "applicantProfileDialog"
  );
  const confirmationDialog = document.getElementById("confirmationDialog");

  // أزرار الفتح والإغلاق
  const viewApplicantButtons = document.querySelectorAll(".view-applicant");
  const closeDialogButtons = document.querySelectorAll(".dialog-close"); // يعمل مع الزر الجديد الذي يحتوي على أيقونة

  // أزرار الإجراءات داخل المودال
  const acceptApplicantButton = document.getElementById("acceptApplicant");
  const rejectApplicantButton = document.getElementById("rejectApplicant");
  const confirmAcceptanceButton = document.getElementById("confirmAcceptance");
  const cancelAcceptanceButton = document.getElementById("cancelAcceptance");

  // دالة مساعدة لفتح النافذة
  const openDialog = (dialog) => {
    if (dialog) {
      dialog.classList.add("active");
      document.body.style.overflow = "hidden"; // منع التمرير في الخلفية
    }
  };

  // دالة مساعدة لإغلاق النافذة
  const closeDialog = (dialog) => {
    if (dialog) {
      dialog.classList.remove("active");
      document.body.style.overflow = ""; // إعادة التمرير
    }
  };

  // فتح نافذة تفاصيل المدرسة عند الضغط على "عرض الطلب"
  if (viewApplicantButtons.length > 0) {
    viewApplicantButtons.forEach((button) => {
      button.addEventListener("click", (e) => {
        e.preventDefault(); // منع أي سلوك افتراضي
        openDialog(applicantProfileDialog);
      });
    });
  }

  // إغلاق أي نافذة عند الضغط على زر الإغلاق (X)
  if (closeDialogButtons.length > 0) {
    closeDialogButtons.forEach((button) => {
      button.addEventListener("click", () => {
        const dialog = button.closest(".dialog-overlay");
        closeDialog(dialog);
      });
    });
  }

  // التعامل مع زر "قبول الطلب" -> يفتح نافذة التأكيد
  if (acceptApplicantButton) {
    acceptApplicantButton.addEventListener("click", () => {
      closeDialog(applicantProfileDialog); // إغلاق البروفايل أولاً
      setTimeout(() => {
        openDialog(confirmationDialog); // فتح التأكيد
      }, 200); // تأخير بسيط لجمالية الحركة
    });
  }

  // التعامل مع زر "رفض الطلب"
  if (rejectApplicantButton) {
    rejectApplicantButton.addEventListener("click", () => {
      if (confirm("هل أنت متأكد من رفض هذا الطلب؟")) {
        closeDialog(applicantProfileDialog);
        console.log("Applicant rejected.");
      }
    });
  }

  // التعامل مع زر "تأكيد" النهائي
  if (confirmAcceptanceButton) {
    confirmAcceptanceButton.addEventListener("click", () => {
      // هنا تضع منطق إرسال البيانات للسيرفر
      console.log("Applicant accepted!");

      // إغلاق النافذة
      closeDialog(confirmationDialog);

      // (اختياري) إظهار رسالة نجاح أو تحديث الجدول
      alert("تم تفعيل المدرسة بنجاح!");
    });
  }

  // التعامل مع زر "إلغاء" في نافذة التأكيد
  if (cancelAcceptanceButton) {
    cancelAcceptanceButton.addEventListener("click", () => {
      closeDialog(confirmationDialog);
      // اختياري: إعادة فتح نافذة البروفايل
      setTimeout(() => {
        openDialog(applicantProfileDialog);
      }, 200);
    });
  }

  // إغلاق النافذة عند الضغط على المساحة المظللة (Overlay)
  [applicantProfileDialog, confirmationDialog].forEach((dialog) => {
    if (dialog) {
      dialog.addEventListener("click", (e) => {
        if (e.target === dialog) {
          closeDialog(dialog);
        }
      });
    }
  });

  // إضافة دعم زر Escape لنوافذ لوحة التحكم أيضاً
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") {
      if (
        applicantProfileDialog &&
        applicantProfileDialog.classList.contains("active")
      ) {
        closeDialog(applicantProfileDialog);
      }
      if (
        confirmationDialog &&
        confirmationDialog.classList.contains("active")
      ) {
        closeDialog(confirmationDialog);
      }
    }
  });
});
