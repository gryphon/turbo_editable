import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["pencil"];

  connect() {
  }

  show() {
    this.pencilTarget.click()
  }

}
