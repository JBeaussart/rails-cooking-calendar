import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "dropdown", "search", "option", "selected", "hiddenInput"]
  static values = { open: Boolean }
  
  connect() {
    this.openValue = false
    // Close dropdown when clicking outside
    this.boundCloseOnClickOutside = this.closeOnClickOutside.bind(this)
    document.addEventListener("click", this.boundCloseOnClickOutside)
  }
  
  disconnect() {
    document.removeEventListener("click", this.boundCloseOnClickOutside)
  }
  
  toggle(event) {
    event.stopPropagation()
    this.openValue = !this.openValue
    this.updateDropdown()
    if (this.openValue && this.hasSearchTarget) {
      this.searchTarget.focus()
    }
  }
  
  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.openValue = false
      this.updateDropdown()
    }
  }
  
  updateDropdown() {
    if (this.hasDropdownTarget) {
      this.dropdownTarget.classList.toggle("hidden", !this.openValue)
    }
    if (this.hasInputTarget) {
      this.inputTarget.setAttribute("aria-expanded", this.openValue)
    }
  }
  
  filter(event) {
    const query = event.target.value.toLowerCase().trim()
    
    this.optionTargets.forEach(option => {
      const title = option.dataset.title?.toLowerCase() || ""
      const matches = title.includes(query)
      option.classList.toggle("hidden", !matches)
    })
  }
  
  select(event) {
    const option = event.currentTarget
    const id = option.dataset.id
    const title = option.dataset.title
    const time = option.dataset.time || ""
    const ingredients = option.dataset.ingredients || "0"
    
    // Update hidden input
    if (this.hasHiddenInputTarget) {
      this.hiddenInputTarget.value = id
    }
    
    // Update displayed selection
    if (this.hasSelectedTarget) {
      this.selectedTarget.innerHTML = `
        <div class="flex items-center gap-3 sm:gap-4">
          <div class="w-10 h-10 sm:w-12 sm:h-12 bg-terracotta/10 rounded-xl flex items-center justify-center text-xl sm:text-2xl flex-shrink-0">
            🍳
          </div>
          <div class="flex-1 min-w-0">
            <h4 class="font-semibold text-navy text-sm sm:text-base truncate">${this.escapeHtml(title)}</h4>
            <div class="flex items-center gap-2 sm:gap-4 text-xs sm:text-sm text-navy/60 mt-0.5 sm:mt-1">
              ${time ? `<span>⏱️ ${time}min</span>` : ''}
              <span>🥕 ${ingredients}</span>
            </div>
          </div>
          <div class="text-sage text-xl">✓</div>
        </div>
      `
    }
    
    // Mark selected option
    this.optionTargets.forEach(opt => {
      opt.classList.toggle("ring-2", opt.dataset.id === id)
      opt.classList.toggle("ring-terracotta", opt.dataset.id === id)
      opt.classList.toggle("bg-terracotta/5", opt.dataset.id === id)
    })
    
    // Close dropdown
    this.openValue = false
    this.updateDropdown()
    
    // Clear search
    if (this.hasSearchTarget) {
      this.searchTarget.value = ""
      this.filter({ target: { value: "" } })
    }
  }
  
  escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }
}
