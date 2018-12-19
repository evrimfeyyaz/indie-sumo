$(document).on('turbolinks:load', function () {
  const hideButtonSelector = '[data-flash="hide-button"]'

  $(hideButtonSelector).click(function () {
    $(this).parent().fadeOut()
  })
})