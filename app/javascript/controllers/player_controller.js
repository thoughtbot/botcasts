import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    if (this.element.paused) this.element.play()
    else this.element.pause()
  }
}
