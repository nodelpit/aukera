import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];

  playTrailer(event) {
    event.preventDefault();

    // Vérifier si une URL de trailer existe dans le dataset
    const trailerLink = this.element.dataset.trailerLink;
    if (!trailerLink) return;

    // Remplacer le contenu par une iframe YouTube
    this.element.innerHTML = `
    <iframe
      width="100%"
      height="100%"
      src="${trailerLink}?autoplay=1&controls=2&showinfo=1&modestbranding=1&rel=0&fs=0"
      frameborder="0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen>
    </iframe>
  `;
  }
}
