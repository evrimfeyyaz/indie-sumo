/*
 * Circle Words
 *
 * Circles the content of an element between given words.
 *
 * Usage
 * =====
 * 1. Add comma separated words (without spaces) to the `data-circle-words` attribute of the element.
 * 2. Add the first word as the content of the element.
 *
 * Example: `<span data-circle-words="apple,orange,pear">apple</span>`
 *
 */

(function() {
  const elementSelector = '[data-circle-words]'
  const dataAttribute = 'circle-words'
  const changeInterval = 3000 // in milliseconds

  $(document).on('turbolinks:load', function() {
    $(elementSelector).each(function() {
      const element = $(this)
      const words = element.data(dataAttribute).split(',')

      setInterval(function() {
        circleContent(element, words)
      }, changeInterval)
    })
  })

  function circleContent(el, words) {
    const currentWord = $(el).text()
    const currentWordIndex = $.inArray(currentWord, words)
    const nextWordIndex = (currentWordIndex + 1) % words.length
    const nextWord = words[nextWordIndex]

    $(el).fadeOut(200, function() {
      $(this).text(nextWord)
      $(this).fadeIn(200)
    })
  }
})()