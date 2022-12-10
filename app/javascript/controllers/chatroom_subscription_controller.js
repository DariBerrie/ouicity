import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number };
  static targets = ["messages"];
  connect() {
    this.channel = createConsumer().subscriptions.create({ channel: "ChatroomChannel", id: this.chatroomIdValue }, { received: (data) => this.#insertMessageAndScrollDown(data) });
    console.log(`Subscribe to the chatroom with the id ${this.chatroomIdValue}.`);
  }

  resetForm(event) {
    console.log("reset form method")
    event.target.reset();
  }

  // Private
  #insertMessageAndScrollDown(data) {
    console.log("insert message method")
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }
}
