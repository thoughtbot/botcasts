import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static outlets = ["player"]

  playerOutletConnected(controller, element) {
    element.addEventListener("play", this.#press)
    element.addEventListener("pause", this.#unpress)
    element.addEventListener("ended", this.#unpress)

    element.setAttribute("aria-controls", element.id)

    if (element.paused) this.#unpress()
    else this.#press()
  }

  playerOutletDisconnected(controller, element) {
    element.removeEventListener("play", this.#press)
    element.removeEventListener("pause", this.#unpress)
    element.removeEventListener("ended", this.#unpress)

    element.removeAttribute("aria-controls")
    this.#unpress()
  }

  toggle() {
    for (const playerOutlet of this.playerOutlets) {
      playerOutlet.toggle()
    }
  }

  #press = () => {
    this.element.setAttribute("aria-pressed", true)
  }

  #unpress = () => {
    this.element.setAttribute("aria-pressed", false)
  }
}
