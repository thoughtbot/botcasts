// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

// Delete me when https://github.com/hotwired/turbo/pull/790 is released
// and we've upgraded to Turbo 7.2.5
//
// START BACKPORT
for (const { delegate } of document.querySelectorAll("turbo-frame")) {
  backportLazyLoadedFramePromotion(delegate)
}

new MutationObserver((mutationRecords) => {
  for (const { addedNodes } of mutationRecords) {
    for (const addedNode of addedNodes) {
      if (addedNode.localName == "turbo-frame") {
        backportLazyLoadedFramePromotion(addedNode.delegate)
      }
    }
  }
}).observe(document.documentElement, { subtree: true, childList: true })

function backportLazyLoadedFramePromotion(frameController) {
  function elementAppearedInViewport(element) {
    this.proposeVisitIfNavigatedWithAction(element, element)
    this.loadSourceURL()
  }

  frameController.elementAppearedInViewport = elementAppearedInViewport.bind(frameController)
}
// END BACKPORT
