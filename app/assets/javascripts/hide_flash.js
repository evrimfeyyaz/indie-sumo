$(document).on('turbolinks:load', function () {
  $('#flash-close-button').click(function () {
    $('#flash').fadeOut()
  })
})