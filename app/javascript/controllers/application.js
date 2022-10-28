import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.registerActionOption("reload", ({ event, value }) => {
  if (event.type == "submit") {
    const { submitter, target: form } = event
    const turboFrame = getTurboFrame(submitter) || getTurboFrame(form)
    const action = submitter?.getAttribute("formaction") || form.action
    const url = new URL(action, document.baseURI)
    const reload = turboFrame ?
      url.href == new URL(turboFrame.src, turboFrame.baseURI).href :
      url.href == new URL(location.href).href

    return reload == value
  } else {
    return true
  }
})

function getTurboFrame(element) {
  if (element) {
    return document.getElementById(element.getAttribute("data-turbo-frame"))
  } else {
    return null
  }
}

export { application }
