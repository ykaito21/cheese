function initUpdateNavbarOnScroll() {
  const navbar = document.querySelector('.navbar-wagon');
  const banner = document.querySelector('.banner');
  const search = document.querySelector('.search-container ');
  const bannerHeight = banner.clientHeight;
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= bannerHeight) {
        navbar.classList.add('navbar-fixed-top');
        search.classList.add('show-search-container');
      } else {
        navbar.classList.remove('navbar-fixed-top');
        search.classList.remove('show-search-container');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
