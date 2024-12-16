import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    console.log("modal connected")
  }

  modalReset() {
    console.log("delete")
    this.element.remove()
  }
}
