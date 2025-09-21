document.addEventListener("DOMContentLoaded", () => {
  const statsSection = document.querySelector(".stats-section");
  const counters = document.querySelectorAll(".stats-grid h3");
  const duration = 300; // المدة بالمللي ثانية

  const startCounter = (el) => {
    const end = parseInt(el.dataset.count, 10);
    let current = 0;
    const increment = end / (duration / 10);

    const updateCounter = () => {
      current += increment;
      if (current < end) {
        el.innerText = Math.ceil(current).toLocaleString("en-US");
        requestAnimationFrame(updateCounter);
      } else {
        el.innerText = end.toLocaleString("en-US");
      }
    };
    updateCounter();
  };

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          counters.forEach(startCounter);
          observer.unobserve(statsSection);
        }
      });
    },
    {
      threshold: 0.5,
    }
  );

  if (statsSection) {
    observer.observe(statsSection);
  }
});
