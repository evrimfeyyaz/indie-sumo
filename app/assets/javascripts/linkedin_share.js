$(function () {
  function loadLinkedIn() {
    delete IN
    $.getScript("//platform.linkedin.com/in.js")
    console.log('test')
  }

  loadLinkedIn();
  $(document).on('turbolinks:load', loadLinkedIn)
})
