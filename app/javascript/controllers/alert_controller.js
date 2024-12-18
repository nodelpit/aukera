import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {
  static values = {
    text: String
  }

  initSweetalert(event) {
    event.preventDefault()
    const form = event.target.closest('form')

    Swal.fire({
      title: "Confirmation",
      text: event.currentTarget.dataset.text,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Oui, supprimer',
      cancelButtonText: 'Annuler',
      confirmButtonColor: '#d33',
      cancelButtonColor: '#563a78',
    }).then((result) => {
      if (result.isConfirmed && form) {
        form.submit()
      }
    })
  }
}
