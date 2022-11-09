import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  loadPage({ target }) {
    target.replaceWith(...target.children)
  }
}
