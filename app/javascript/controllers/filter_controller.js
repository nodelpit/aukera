import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "overlay", "genreCounter", "platformCounter", "durationSlider", "durationDisplay", "genreInput", "platformInput", "durationInput"]

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
    const button = event.currentTarget;
    const genreName = button.dataset.genre;

    button.classList.toggle('active');

    if (button.classList.contains('active')) {
      this.selectedGenres.add(genreName);
    } else {
      this.selectedGenres.delete(genreName);
    }

    this.genreInputTarget.value = Array.from(this.selectedGenres).join(',');
    this.updateGenreCounter();
  }

  updateGenreCounter() {
    this.genreCounterTarget.textContent = this.selectedGenres.size
  }

  togglePlatform(event) {
    const button = event.currentTarget;
    const platformName = button.dataset.platform;

    button.classList.toggle('active');

    if (button.classList.contains('active')) {
      this.selectedPlatforms.add(platformName);
    } else {
      this.selectedPlatforms.delete(platformName);
    }

    this.platformInputTarget.value = Array.from(this.selectedPlatforms).join(',');
    this.updatePlatformCounter();
  }

  updatePlatformCounter() {
    this.platformCounterTarget.textContent = this.selectedPlatforms.size
  }

  submitFilters() {
    this.durationInputTarget.value = this.durationSliderTarget.value;

    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.click();
    } else if (this.searchForm) {
      this.searchForm.submit();
    }

    this.close();
  }

  updateDurationDisplay() {
    const durationInMinutes = parseInt(this.durationSliderTarget.value)
    this.durationDisplayTarget.querySelector('span').textContent = durationInMinutes
  }

  get searchForm() {
    return this.element.querySelector('form');
  }
}
