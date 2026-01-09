import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "card", "empty", "count"]
  
  connect() {
    this.totalCount = this.cardTargets.length
  }
  
  filter() {
    const query = this.inputTarget.value.toLowerCase().trim()
    let visibleCount = 0
    
    this.cardTargets.forEach(card => {
      const title = card.dataset.title?.toLowerCase() || ""
      const ingredients = card.dataset.ingredients?.toLowerCase() || ""
      
      const matches = query === "" || title.includes(query) || ingredients.includes(query)
      card.classList.toggle("hidden", !matches)
      
      if (matches) visibleCount++
    })
    
    // Update count
    if (this.hasCountTarget) {
      if (query === "") {
        this.countTarget.textContent = `${this.totalCount} recette(s)`
      } else {
        this.countTarget.textContent = `${visibleCount} / ${this.totalCount} recette(s)`
      }
    }
    
    // Show/hide empty state
    if (this.hasEmptyTarget) {
      this.emptyTarget.classList.toggle("hidden", visibleCount > 0)
    }
  }
  
  clear() {
    this.inputTarget.value = ""
    this.filter()
    this.inputTarget.focus()
  }
}
