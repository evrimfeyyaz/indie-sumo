/*
 * Dropdown Menu
 *
 * Usage
 * =====
 * 1. Add `data-dropdown-menu="toggle"` to the toggle button.
 * 2. Add `data-dropdown-menu="content"` to the content container.
 * 3. Add `data-dropdown-menu="item"` to dropdown items inside the container.
 * 4. (optional) If you would like to add a down arrow after the toggle link,
 *    add `dropdown-menu-down-arrow` to its classes.
 */

(function() {
  const toggleSelector = '[data-dropdown-menu="toggle"]'
  const contentSelector = '[data-dropdown-menu="content"]'
  const activeClass = 'active'

  $(document).on('turbolinks:load', function() {
    $(toggleSelector).click(toggleDropdownMenu)
    $(document).click(hideDropdownMenus)
  })

  function toggleDropdownMenu(event) {
    const target = $(event.currentTarget)

    $(target).toggleClass(activeClass)
    $(target).siblings(contentSelector).toggle()

    return false
  }

  function hideDropdownMenus(event) {
    const target = $(event.currentTarget)

    if (!target.parents(contentSelector).length) {
      $(contentSelector).hide()
      $(toggleSelector).removeClass(activeClass)
    }
  }
})()