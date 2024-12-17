import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "button"]

  toggleSearch(event) {
    // Empêcher la propagation par défaut
    event.preventDefault()

    // Clic sur le bouton d'ouverture
    if (event.currentTarget === this.buttonTarget) {
      this.formTarget.classList.add("show-search")
      return
    }

    // Clic sur le bouton de fermeture ou sur l'overlay
    if (event.currentTarget === this.formTarget || event.target.closest('.close-search')) {
      this.closeSearch()
      return
    }
  }

  closeSearch() {
    this.formTarget.classList.remove("show-search")
  }

  connect() {
    this.handleKeyup = this.handleKeyup.bind(this)
    document.addEventListener('keyup', this.handleKeyup)
  }

  disconnect() {
    document.removeEventListener('keyup', this.handleKeyup)
  }

  handleKeyup(event) {
    if (event.key === 'Escape' && this.formTarget.classList.contains('show-search')) {
      this.closeSearch()
    }
  }
}
