import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    const typed = new Typed(this.element, {
      strings: ["1...2...3...ouicity!"],
      typeSpeed: 50,
      loop: false
    })
    typed.current.destroy()
  }
}
