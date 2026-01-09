import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  addToPlan(event) {
    const button = event.currentTarget
    const recipeId = button.dataset.recipeId
    
    // Utiliser la date d'aujourd'hui et le dîner par défaut
    const date = new Date().toISOString().split('T')[0]
    const mealType = 'dinner'
    
    // Remplir le formulaire caché
    document.getElementById('quick-add-recipe-id').value = recipeId
    document.getElementById('quick-add-date').value = date
    document.getElementById('quick-add-meal-type').value = mealType
    
    // Animation du bouton
    button.classList.add('scale-125')
    setTimeout(() => button.classList.remove('scale-125'), 200)
    
    // Soumettre le formulaire
    document.getElementById('quick-add-form').requestSubmit()
  }
}
