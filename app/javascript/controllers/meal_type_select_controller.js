import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "input", "form"]

  select(event) {
    const selectedType = event.currentTarget.dataset.mealType
    
    // Update hidden input
    this.inputTarget.value = selectedType
    
    // Update button styles
    this.btnTargets.forEach(btn => {
      if (btn.dataset.mealType === selectedType) {
        btn.classList.remove('text-white/80', 'hover:bg-white/20')
        btn.classList.add('bg-white', 'text-navy', 'shadow-md')
      } else {
        btn.classList.remove('bg-white', 'text-navy', 'shadow-md')
        btn.classList.add('text-white/80', 'hover:bg-white/20')
      }
    })
    
    // Update form action URL with new meal_type
    const form = this.formTarget.closest('form')
    if (form) {
      const url = new URL(form.action)
      url.searchParams.set('meal_type', selectedType)
      form.action = url.toString()
    }
  }
}
