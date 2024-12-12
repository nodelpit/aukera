import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Nous gardons uniquement les targets que nous utilisons réellement
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

  submitFilters() {
    // Nous récupérons le formulaire directement avec querySelector
    const searchForm = document.querySelector('form')

    // Si nous ne trouvons pas de formulaire, nous créons une nouvelle URL
    const baseUrl = searchForm ? searchForm.action : window.location.href
    const url = new URL(baseUrl)

    // Ajout des genres sélectionnés si présents
    if (this.selectedGenres.size > 0) {
      url.searchParams.set('genres', Array.from(this.selectedGenres).join(','))
    }

    // Ajout des plateformes sélectionnées si présentes
    if (this.selectedPlatforms.size > 0) {
      url.searchParams.set('services', Array.from(this.selectedPlatforms).join(','))
    }

    // Ajout de la durée du slider si présent
    const durationSlider = document.querySelector('.slider')
    if (durationSlider) {
      url.searchParams.set('duration', durationSlider.value)
    }

    // Ajout des paramètres de recherche existants s'il y en a
    if (searchForm) {
      const formData = new FormData(searchForm)
      for (let [key, value] of formData.entries()) {
        if (value) {
          url.searchParams.set(key, value)
        }
      }
    }

    // Redirection vers la nouvelle URL avec tous les filtres
    window.location.href = url.toString()

    // Fermeture de la carte des filtres
    this.close()
  }
}
