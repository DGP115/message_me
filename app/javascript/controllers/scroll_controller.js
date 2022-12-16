import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  /** On start (provided by Stimulus) */
  connect() {
    console.log("Connected");
    const scrollbarhere = document.getElementById("scrollbarhere");
    scrollbarhere.addEventListener("DOMNodeInserted", this.resetScroll);
    this.resetScroll(scrollbarhere);
  }
  /** On Stop (provided by Stimulus) */
  disconnect() {
    console.log("Disconnected");
  }
  /** Custom Functions */
  resetScroll() {
    scrollbarhere.scrollTop = scrollbarhere.scrollHeight - scrollbarhere.clientHeight;
  }
}
