import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "checkedList", "uncheckedList", "counter"]

  connect() {
    this.loadCheckedItems()
    this.updateCounter()
  }

  toggle(event) {
    const checkbox = event.target
    const item = checkbox.closest("[data-shopping-list-target='item']")
    const ingredientId = item.dataset.ingredientId

    if (checkbox.checked) {
      // Ajouter aux cochés (localStorage)
      this.saveCheckedItem(ingredientId)
      // Déplacer vers la liste des cochés
      this.moveToChecked(item)
    } else {
      // Retirer des cochés
      this.removeCheckedItem(ingredientId)
      // Déplacer vers la liste des non-cochés
      this.moveToUnchecked(item)
    }

    this.updateCounter()
  }

  moveToChecked(item) {
    item.classList.add("opacity-50", "line-through")
    this.checkedListTarget.appendChild(item)
  }

  moveToUnchecked(item) {
    item.classList.remove("opacity-50", "line-through")
    // Insérer en respectant l'ordre alphabétique
    const name = item.dataset.ingredientName.toLowerCase()
    const items = this.uncheckedListTarget.querySelectorAll("[data-shopping-list-target='item']")
    
    let inserted = false
    for (const existingItem of items) {
      if (existingItem.dataset.ingredientName.toLowerCase() > name) {
        this.uncheckedListTarget.insertBefore(item, existingItem)
        inserted = true
        break
      }
    }
    
    if (!inserted) {
      this.uncheckedListTarget.appendChild(item)
    }
  }

  loadCheckedItems() {
    const checked = this.getCheckedItems()
    
    this.itemTargets.forEach(item => {
      const ingredientId = item.dataset.ingredientId
      const checkbox = item.querySelector("input[type='checkbox']")
      
      if (checked.includes(ingredientId)) {
        checkbox.checked = true
        item.classList.add("opacity-50", "line-through")
        this.checkedListTarget.appendChild(item)
      }
    })
  }

  getCheckedItems() {
    const stored = localStorage.getItem("shopping_list_checked")
    return stored ? JSON.parse(stored) : []
  }

  saveCheckedItem(id) {
    const checked = this.getCheckedItems()
    if (!checked.includes(id)) {
      checked.push(id)
      localStorage.setItem("shopping_list_checked", JSON.stringify(checked))
    }
  }

  removeCheckedItem(id) {
    let checked = this.getCheckedItems()
    checked = checked.filter(item => item !== id)
    localStorage.setItem("shopping_list_checked", JSON.stringify(checked))
  }

  clearAll() {
    localStorage.removeItem("shopping_list_checked")
    
    this.itemTargets.forEach(item => {
      const checkbox = item.querySelector("input[type='checkbox']")
      checkbox.checked = false
      item.classList.remove("opacity-50", "line-through")
    })

    // Déplacer tous les items vers la liste non-cochée et trier
    const items = Array.from(this.itemTargets)
    items.sort((a, b) => a.dataset.ingredientName.toLowerCase().localeCompare(b.dataset.ingredientName.toLowerCase()))
    items.forEach(item => this.uncheckedListTarget.appendChild(item))

    this.updateCounter()
  }

  updateCounter() {
    const total = this.itemTargets.length
    const checked = this.getCheckedItems().length
    
    if (this.hasCounterTarget) {
      this.counterTarget.textContent = `${checked}/${total}`
    }
  }
}
