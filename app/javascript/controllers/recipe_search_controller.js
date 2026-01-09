import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "card", "empty", "count"]
  
  connect() {
    this.totalCount = this.cardTargets.length
  }
  
  // Normalize text: remove accents, convert ligatures, lowercase
  normalize(text) {
    return text
      .toLowerCase()
      // Replace ligatures
      .replace(/œ/g, 'oe')
      .replace(/æ/g, 'ae')
      .replace(/ß/g, 'ss')
      // Remove accents using Unicode normalization
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
  }
  
  filter() {
    const query = this.normalize(this.inputTarget.value.trim())
    let visibleCount = 0
    
    this.cardTargets.forEach(card => {
      const title = this.normalize(card.dataset.title || "")
      const ingredients = this.normalize(card.dataset.ingredients || "")
      
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
