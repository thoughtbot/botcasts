import ApplicationController from "controllers/application_controller"
import ComboboxNav from "@github/combobox-nav"

export default class extends ApplicationController {
  static targets = ["combobox", "listbox"]

  comboboxTargetConnected(combobox) {
    combobox.setAttribute("autocomplete", "off")
    combobox.setAttribute("autocorrect", "off")
    this.start()
  }

  comboboxTargetDisconnected() {
    this.stop()
  }

  listboxTargetConnected(listbox) {
    listbox.setAttribute("role", "listbox")
  }

  listboxTargetDisconnected(listbox) {
    listbox.removeAttribute("role")
  }

  start() {
    if (this.comboboxNav) this.comboboxNav.destroy()

    this.comboboxNav = new ComboboxNav(this.comboboxTarget, this.listboxTarget)
    this.comboboxNav.start()
  }

  stop() {
    if (this.comboboxNav) this.comboboxNav.stop()
  }
}
