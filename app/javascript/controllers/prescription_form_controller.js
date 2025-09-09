import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="prescription-form"
export default class extends Controller {
  static targets = [
    "prescriptionTypeSelect",
    "pillsFields",
    "vaccineFields",
    "medicineFields"
  ]

  static values = {
    medicine: Array
  }

  connect() {
    console.log("connected from prescriptions")
    console.log(this.medicineValue)

  }

  toggleFields() {
      const selected = this.prescriptionTypeSelectTarget.value

      if (selected === "pills") {
        this.pillsFieldsTarget.style.display = "block"
        this.vaccineFieldsTarget.style.display = "none"
        this.displayPills()
      } else if (selected === "vaccine") {
        this.pillsFieldsTarget.style.display = "none"
        this.vaccineFieldsTarget.style.display = "block"
        this.displayVaccines()
      } else {
        this.pillsFieldsTarget.style.display = "none"
        this.vaccineFieldsTarget.style.display = "none"
      }
    }

  displayPills() {
    //iterate true my medicines value this.medicinesValue
    //select the element where category is == pills
    //take the medicine field and remove the html
    this.medicineFieldsTarget.innerHTML = ""
    console.log(this.medicineValue)
    this.medicineValue.filter(med => med.category === "pills")
    .forEach(med => {
      console.log(med)
      const option = document.createElement("option")
      option.value = med.id
      option.textContent = med.name
      this.medicineFieldsTarget.appendChild(option)
    })
  }

  displayVaccines() {
    this.medicineFieldsTarget.innerHTML = ""
    this.medicineValue

    .filter(med => med.category === "vaccine")
    .forEach(med => {
      const option = document.createElement("option")
      option.value = med.id
      option.textContent = med.name
      this.medicineFieldsTarget.appendChild(option)
    })
  }
}
