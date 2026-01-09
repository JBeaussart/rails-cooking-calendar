import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "display", "calendar", "monthYear", "grid"]
  static values = { 
    date: String,
    open: Boolean 
  }
  
  connect() {
    this.openValue = false
    this.currentDate = this.dateValue ? new Date(this.dateValue) : new Date()
    this.selectedDate = this.dateValue ? new Date(this.dateValue) : null
    this.viewDate = new Date(this.currentDate)
    
    this.updateDisplay()
    this.boundCloseOnClickOutside = this.closeOnClickOutside.bind(this)
    document.addEventListener("click", this.boundCloseOnClickOutside)
  }
  
  disconnect() {
    document.removeEventListener("click", this.boundCloseOnClickOutside)
  }
  
  toggle(event) {
    event.stopPropagation()
    this.openValue = !this.openValue
    this.updateCalendarVisibility()
    if (this.openValue) {
      this.renderCalendar()
    }
  }
  
  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.openValue = false
      this.updateCalendarVisibility()
    }
  }
  
  updateCalendarVisibility() {
    if (this.hasCalendarTarget) {
      this.calendarTarget.classList.toggle("hidden", !this.openValue)
    }
  }
  
  previousMonth(event) {
    event.stopPropagation()
    this.viewDate.setMonth(this.viewDate.getMonth() - 1)
    this.renderCalendar()
  }
  
  nextMonth(event) {
    event.stopPropagation()
    this.viewDate.setMonth(this.viewDate.getMonth() + 1)
    this.renderCalendar()
  }
  
  selectDate(event) {
    event.stopPropagation()
    const day = parseInt(event.currentTarget.dataset.day)
    const month = parseInt(event.currentTarget.dataset.month)
    const year = parseInt(event.currentTarget.dataset.year)
    
    this.selectedDate = new Date(year, month, day)
    
    // Update hidden input
    if (this.hasInputTarget) {
      const formattedDate = this.formatDateForInput(this.selectedDate)
      this.inputTarget.value = formattedDate
    }
    
    this.updateDisplay()
    this.openValue = false
    this.updateCalendarVisibility()
  }
  
  updateDisplay() {
    if (this.hasDisplayTarget && this.selectedDate) {
      this.displayTarget.innerHTML = this.formatDateDisplay(this.selectedDate)
    }
  }
  
  formatDateForInput(date) {
    const year = date.getFullYear()
    const month = String(date.getMonth() + 1).padStart(2, '0')
    const day = String(date.getDate()).padStart(2, '0')
    return `${year}-${month}-${day}`
  }
  
  formatDateDisplay(date) {
    const days = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam']
    const months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre']
    
    const dayName = days[date.getDay()]
    const dayNum = date.getDate()
    const monthName = months[date.getMonth()]
    const year = date.getFullYear()
    
    return `
      <div class="flex items-center gap-3">
        <div class="w-12 h-12 bg-terracotta/10 rounded-xl flex flex-col items-center justify-center">
          <span class="text-xs text-terracotta font-medium uppercase">${dayName}</span>
          <span class="text-lg font-bold text-terracotta leading-none">${dayNum}</span>
        </div>
        <div>
          <div class="font-semibold text-navy">${monthName} ${year}</div>
          <div class="text-sm text-navy/60">Cliquez pour modifier</div>
        </div>
        <span class="ml-auto text-navy/40">📅</span>
      </div>
    `
  }
  
  renderCalendar() {
    const months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre']
    
    if (this.hasMonthYearTarget) {
      this.monthYearTarget.textContent = `${months[this.viewDate.getMonth()]} ${this.viewDate.getFullYear()}`
    }
    
    if (this.hasGridTarget) {
      this.gridTarget.innerHTML = this.generateCalendarGrid()
    }
  }
  
  generateCalendarGrid() {
    const year = this.viewDate.getFullYear()
    const month = this.viewDate.getMonth()
    
    const firstDay = new Date(year, month, 1)
    const lastDay = new Date(year, month + 1, 0)
    const startDay = firstDay.getDay() === 0 ? 6 : firstDay.getDay() - 1 // Lundi = 0
    const daysInMonth = lastDay.getDate()
    
    const today = new Date()
    today.setHours(0, 0, 0, 0)
    
    let html = ''
    
    // Empty cells before first day
    for (let i = 0; i < startDay; i++) {
      html += '<div class="p-2"></div>'
    }
    
    // Days of the month
    for (let day = 1; day <= daysInMonth; day++) {
      const date = new Date(year, month, day)
      const isToday = date.getTime() === today.getTime()
      const isSelected = this.selectedDate && 
        date.getDate() === this.selectedDate.getDate() &&
        date.getMonth() === this.selectedDate.getMonth() &&
        date.getFullYear() === this.selectedDate.getFullYear()
      
      let classes = 'p-2 text-center rounded-lg cursor-pointer transition-all text-sm font-medium '
      
      if (isSelected) {
        classes += 'bg-terracotta text-white'
      } else if (isToday) {
        classes += 'bg-sage/20 text-sage-dark hover:bg-sage/30'
      } else {
        classes += 'hover:bg-cream text-navy'
      }
      
      html += `<div class="${classes}" data-action="click->date-picker#selectDate" data-day="${day}" data-month="${month}" data-year="${year}">${day}</div>`
    }
    
    return html
  }
}
