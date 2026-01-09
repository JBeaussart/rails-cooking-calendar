import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "card", "empty", "count"]
  
  connect() {
    this.totalCount = this.cardTargets.length
    console.log("Recipe search connected, cards:", this.totalCount)
    // Debug: log first card's data
    if (this.cardTargets.length > 0) {
      const firstCard = this.cardTargets[0]
      console.log("First card - title:", firstCard.dataset.title)
      console.log("First card - ingredients:", firstCard.dataset.ingredients)
    }
  }
  
  filter() {
    const query = this.inputTarget.value.toLowerCase().trim()
    console.log("Filtering with query:", query)
    let visibleCount = 0
    
    this.cardTargets.forEach(card => {
      const title = card.dataset.title?.toLowerCase() || ""
      const ingredients = card.dataset.ingredients?.toLowerCase() || ""
      
      const matches = query === "" || title.includes(query) || ingredients.includes(query)
      card.classList.toggle("hidden", !matches)
      
      if (matches) visibleCount++
    })
    console.log("Visible count:", visibleCount)
    
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
