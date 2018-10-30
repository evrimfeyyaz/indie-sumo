const toggleSelector = '[data-dropdown="toggle"]'
const contentSelector = '[data-dropdown="content"]'

$(document).on('turbolinks:load', function() {
  $(toggleSelector).click(toggleDropdownMenu)
  $(document).click(hideDropdownMenus)
})

function toggleDropdownMenu() {
  $(toggleSelector).toggleClass('hovered')
  $(toggleSelector).siblings(contentSelector).toggle()

  return false
}

function hideDropdownMenus(event) {
  const target = $(event.target)

  if (!target.parents(contentSelector).length) {
    $(contentSelector).hide()
  }
}