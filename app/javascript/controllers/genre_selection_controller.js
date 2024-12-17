import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  openGenreModal(event) {
    // Récupère l'index du bouton cliqué pour l'associer au genre
    this.currentGenreIndex = event.currentTarget.dataset.genreIndex;
    this.modalTarget.classList.remove("hidden");
  }

  closeGenreModal() {
    // Cache la modale
    this.modalTarget.classList.add("hidden");
  }

  selectGenre(event) {
    const selectedGenre = event.currentTarget.dataset.genre;

    // Met à jour le texte du bouton sélectionné
    const genreButton = document.querySelector(
      `[data-genre-index="${this.currentGenreIndex}"]`
    );
    genreButton.textContent = selectedGenre;

    // Met à jour la valeur dans le champ caché correspondant
    const hiddenField = document.getElementById(
      `selected-genre-${this.currentGenreIndex}`
    );
    hiddenField.value = selectedGenre;

    // Ferme la modale
    this.closeGenreModal();
  }
}

