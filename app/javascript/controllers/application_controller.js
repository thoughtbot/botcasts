import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  preventDefault(event) {
    event.preventDefault()
  }
}
