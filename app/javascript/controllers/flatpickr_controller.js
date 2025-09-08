import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  connect() {
    let mode = this.element.dataset.flatpickrMode || "datetime"

    flatpickr(this.element, {
      enableTime: mode === "time" || mode === "datetime", // enable time if mode is "time" or "datetime"
      noCalendar: mode === "time",                        // hide calendar for time-only fields
      dateFormat: mode === "time" ? "H:i" : "Y-m-d",      // format accordingly
      disable: [
        function(date) {
          // only disable weekends for date fields
          return mode === "date" && (date.getDay() === 0 || date.getDay() === 6);
        }
      ]
    })
  }
}
