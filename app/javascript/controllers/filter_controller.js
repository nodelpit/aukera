import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["card", "overlay", "genreCounter", "platformCounter"]

  connect() {
    this.selectedGenres = new Set()
    this.selectedPlatforms = new Set()
    console.log("Filter controller connected")
  }

  open(event) {
    event.preventDefault()
    this.cardTarget.style.display = "block"
    this.overlayTarget.style.display = "block"
  }

  close() {
    this.cardTarget.style.display = "none"
    this.overlayTarget.style.display = "none"
  }

  toggleGenre(event) {
    const button = event.currentTarget
    button.classList.toggle('active')

    const genreName = button.dataset.genre

    if (button.classList.contains('active')) {
      this.selectedGenres.add(genreName)
    } else {

      this.selectedGenres.delete(genreName)
    }
    this.updateGenreCounter()
  }

  updateGenreCounter() {
    this.genreCounterTarget.textContent = this.selectedGenres.size
  }

  togglePlatform(event) {
    const button = event.currentTarget
    button.classList.toggle('active')

    const platformName = button.dataset.platform

    if (button.classList.contains('active')) {
      this.selectedPlatforms.add(platformName)
    } else {
      this.selectedPlatforms.delete(platformName)
    }

    this.updatePlatformCounter()
  }

  updatePlatformCounter() {
    this.platformCounterTarget.textContent = this.selectedPlatforms.size
  }
}
