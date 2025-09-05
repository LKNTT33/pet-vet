import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  connect() {
    let mode = this.element.dataset.flatpickrMode || "datetime"

    flatpickr(this.element, {
      enableTime: true,
      noCalendar: mode === "time",
      dateFormat: "H:i",
      // disable saturday and sunday
      disable: [
        function(date) {
          return (date.getDay() === 0 || date.getDay() === 6);
        }
      ]
    })
  }
}
