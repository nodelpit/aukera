import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["watchButton"]

  connect() {
    console.log("ServiceSelectorController connecté");
    console.log(this.watchButtonTarget)
    this.selectedLink = null;
  }

  select(event) {
    console.log("Élément cliqué:", event.target); // je stock dans une var js
    const selectedService = event.currentTarget;

    this.element.querySelectorAll(".service-card").forEach(card => {
      card.classList.remove("active");
    });

    selectedService.parentElement.classList.add("active");
    // console.log("Classe 'active' ajoutée à la div de service", selectedService);

    // je vais chercher le lien
    this.selectedLink = selectedService.dataset.link;
    // j'ai bien mon lien
    // console.log("lien du service:", this.selectedLink);
    // je dois donc le balancer sur le bouton regarder service_selector_target: "watchButton"
    this.watchButtonTarget.href = this.selectedLink;
    // console.log("contenu mise à jour du bouton", this.watchButtonTarget);

    this.watchButtonTarget.parentElement.classList.add("active");
    // console.log("Classe 'active' ajoutée à la div parent");
  }
}
