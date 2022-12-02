import ApplicationController from "controllers/application_controller"

export default class extends ApplicationController {
  static outlets = ["element"]

  elementOutletConnected(controller, element) {
    this.element.setAttribute("aria-controls", element.id)
    this.element.setAttribute("aria-expanded", element.open)
    element.addEventListener("close", this.collapse)
  }

  elementOutletDisconnected(controller, element) {
    element.removeEventListener("close", this.collapse)
    this.element.removeAttribute("aria-controls")
    this.element.removeAttribute("aria-expanded")
  }

  expand() {
    for (const elementOutlet of this.elementOutlets) {
      elementOutlet.showModal()
      this.element.setAttribute("aria-expanded", true)
    }
  }

  collapse = () => {
    this.element.setAttribute("aria-expanded", false)
    this.element.focus()
  }
}
