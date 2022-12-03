import ApplicationController from "controllers/application_controller"
import { install, uninstall } from "@github/hotkey"

export default class extends ApplicationController {
  static targets = ["shortcut"]

  shortcutTargetConnected(target) {
    install(target, target.getAttribute("aria-keyshortcuts"))
  }

  shortcutTargetDisconnected(target) {
    uninstall(target)
  }
}
