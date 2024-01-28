import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list"];
  connect() {
    this.showAlertList();
  }

  showAlertList(event) {
    Window.scrollTo({
      top: this.listTarget.scrollTop,
      behavior: 'smooth'
    })
  }
}
