/*
 * Tabs Control
 *
 * Instructions
 * ------------
 * 1. Add `data-tabs=tab` to all tabs.
 * 2. Add `data-tabs=pane` to all tab panes.
 * 3. Add `data-tab-id` to all tabs and tab panes.
 * 4. Add `tab-bar` class to the tabs container.
 * 5. Add `tab` class to tabs.
 * 6. Add `tab-content` to the area that will show tabs. This should
 * contain all the tab panes.
 */

(function () {
  const tabsSelector = '[data-tabs="tab"]'
  const tabPanesSelector = '[data-tabs="pane"]'
  const activeClass = 'active'

  $(document).on('turbolinks:load', function () {
    showFirstPane()
    $(tabsSelector).click(handleTabClick)
  })

  function showFirstPane() {
    $(tabPanesSelector).first().show()
    $(tabPanesSelector).addClass(activeClass)
    $(tabsSelector).first().addClass(activeClass)
  }

  function handleTabClick(event) {
    const tab = $(event.target)
    const tabId = getTabId(tab)

    if (tab.hasClass(activeClass)) return

    showTabPane(tabId)

    return false
  }

  function showTabPane(tabId) {
    $(tabsSelector).removeClass(activeClass)

    const tabToActivate = getTabById(tabId)
    tabToActivate.addClass(activeClass)

    $(tabPanesSelector).hide()

    const activeTabPane = getTabPaneById(tabId)
    activeTabPane.fadeIn()
  }

  function getTabId(tab) {
    return tab.data('tab-id')
  }

  function getTabPaneById(id) {
    return $(tabPanesSelector + '[data-tab-id="' + id + '"')
  }

  function getTabById(id) {
    return $(tabsSelector + '[data-tab-id="' + id + '"')
  }
})()