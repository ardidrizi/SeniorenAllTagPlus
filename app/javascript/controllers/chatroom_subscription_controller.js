import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  static targets = ["messages", "formError"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  resetForm(event) {
    const { success, fetchResponse } = event.detail

    if (success) {
      this.clearError()
      event.target.reset()
      return
    }

    if (fetchResponse) {
      fetchResponse.responseText.then((responseText) => {
        try {
          const parsed = JSON.parse(responseText)
          const errors = parsed.errors || ["Message could not be sent"]
          this.showError(errors.join(", "))
        } catch {
          this.showError("Message could not be sent")
        }
      })
      return
    }

    this.showError("Message could not be sent")
  }

  showError(message) {
    if (!this.hasFormErrorTarget) return

    this.formErrorTarget.textContent = message
    this.formErrorTarget.classList.remove("d-none")
  }

  clearError() {
    if (!this.hasFormErrorTarget) return

    this.formErrorTarget.textContent = ""
    this.formErrorTarget.classList.add("d-none")
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    if (this.channel) this.channel.unsubscribe()
  }
}
