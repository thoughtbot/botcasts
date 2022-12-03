import ApplicationController from "controllers/application_controller"
import { install, uninstall } from "@github/hotkey"

export default class extends ApplicationController {
  static targets = ["shortcut"]

  shortcutTargetConnected(target) {
    target.setAttribute("aria-shortcuts", target.getAttribute("data-hotkey"))
    install(target)
  }

  shortcutTargetDisconnected(target) {
    target.removeAttribute("aria-shortcuts")
    uninstall(target)
  }
}
