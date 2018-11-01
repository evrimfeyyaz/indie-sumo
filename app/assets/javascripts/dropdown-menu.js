const toggleSelector = '[data-dropdown-menu="toggle"]'
const contentSelector = '[data-dropdown-menu="content"]'
const hoveredClass = 'hovered'

$(document).on('turbolinks:load', function() {
  $(toggleSelector).click(toggleDropdownMenu)
  $(document).click(hideDropdownMenus)
})

function toggleDropdownMenu() {
  $(toggleSelector).toggleClass(hoveredClass)
  $(toggleSelector).siblings(contentSelector).toggle()

  return false
}

function hideDropdownMenus(event) {
  const target = $(event.target)

  if (!target.parents(contentSelector).length) {
    $(contentSelector).hide()
    $(toggleSelector).removeClass(hoveredClass)
  }
}