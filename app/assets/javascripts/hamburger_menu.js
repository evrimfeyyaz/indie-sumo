(function() {
  const toggleSelector = '[data-hamburger-menu="toggle"]'
  const contentSelector = '[data-hamburger-menu="content"]'
  const activeClass = 'active'

  $(document).on('turbolinks:load', function() {
    $(toggleSelector).click(toggleHamburgerMenu)
  })

  function toggleHamburgerMenu() {
    $(toggleSelector).toggleClass(activeClass)
    $(contentSelector).slideToggle()

    return false
  }
})()