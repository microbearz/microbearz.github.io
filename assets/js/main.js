function roundedYearsSince(startDate, now) {
  const start = new Date(`${startDate}T00:00:00`);
  let months = (now.getFullYear() - start.getFullYear()) * 12;
  months += now.getMonth() - start.getMonth();

  if (now.getDate() < start.getDate()) {
    months -= 1;
  }

  return Math.max(Math.round(months / 12), 0);
}

document.querySelectorAll("[data-career-years]").forEach((element) => {
  const startDate = element.getAttribute("data-start-date");
  const years = roundedYearsSince(startDate, new Date());
  element.textContent = `${years}+`;
});

document.querySelectorAll("[data-current-year]").forEach((element) => {
  element.textContent = String(new Date().getFullYear());
});
