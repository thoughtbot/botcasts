import ApplicationController from "controllers/application_controller"

export default class extends ApplicationController {
  replaceWithChildren() {
    this.element.replaceWith(...this.element.children)
  }

  requestSubmit() {
    this.element.requestSubmit()
  }
}
