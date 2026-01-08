import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  addToPlan(event) {
    const button = event.currentTarget
    const recipeId = button.dataset.recipeId
    const recipeTitle = button.dataset.recipeTitle
    
    // Récupérer la date sélectionnée
    const dateInput = document.querySelector('input[name="planning_date"]:checked')
    const date = dateInput ? dateInput.value : new Date().toISOString().split('T')[0]
    
    // Récupérer le type de repas sélectionné
    const mealTypeInput = document.querySelector('input[name="planning_meal_type"]:checked')
    const mealType = mealTypeInput ? mealTypeInput.value : 'dinner'
    
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
