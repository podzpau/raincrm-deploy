import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = ["column", "card"]
  static values = { 
    updateUrl: String,
    csrfToken: String 
  }

  connect() {
    this.initializeSortable()
    this.initializeNotifications()
  }

  initializeSortable() {
    this.columnTargets.forEach((column, index) => {
      const sortable = new Sortable(column, {
        group: "deals",
        animation: 300,
        ghostClass: "opacity-50",
        chosenClass: "ring-2 ring-brand-primary",
        dragClass: "rotate-3 scale-105",
        
        onStart: (evt) => {
          evt.item.classList.add("transition-transform", "duration-300")
        },
        
        onEnd: (evt) => {
          evt.item.classList.remove("transition-transform", "duration-300", "rotate-3", "scale-105")
          
          if (evt.from !== evt.to) {
            this.updateDealStatus(evt.item, evt.to)
          }
        }
      })
      
      // Store sortable instance for cleanup
      column.sortable = sortable
    })
  }

  updateDealStatus(dealElement, newColumn) {
    const dealId = dealElement.dataset.dealId
    const newStatus = newColumn.dataset.status
    
    // Show loading state
    dealElement.classList.add("opacity-60", "pointer-events-none")
    
    const formData = new FormData()
    formData.append("deal[status]", newStatus)
    formData.append("authenticity_token", this.csrfTokenValue)
    
    fetch(`${this.updateUrlValue}/${dealId}/update_status`, {
      method: "PATCH",
      body: formData,
      headers: {
        "Accept": "application/json"
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        // Update deal card with new status
        this.updateDealCard(dealElement, data.deal)
        this.showNotification("Deal status updated successfully", "success")
      } else {
        this.showNotification("Failed to update deal status", "error")
        // Revert the move
        this.revertDealMove(dealElement)
      }
    })
    .catch(error => {
      console.error("Error:", error)
      this.showNotification("Network error occurred", "error")
      this.revertDealMove(dealElement)
    })
    .finally(() => {
      dealElement.classList.remove("opacity-60", "pointer-events-none")
    })
  }

  updateDealCard(element, dealData) {
    // Update the deal card content with new data
    const statusBadge = element.querySelector(".status-badge")
    if (statusBadge) {
      statusBadge.textContent = dealData.status_display
      statusBadge.className = `status-badge ${this.getStatusBadgeClass(dealData.status)}`
    }
    
    // Add success animation
    element.classList.add("ring-2", "ring-green-400")
    setTimeout(() => {
      element.classList.remove("ring-2", "ring-green-400")
    }, 2000)
  }

  getStatusBadgeClass(status) {
    const classes = {
      'lead': 'bg-yellow-100 text-yellow-800',
      'pre_approval': 'bg-blue-100 text-blue-800',
      'under_contract': 'bg-purple-100 text-purple-800',
      'closing': 'bg-green-100 text-green-800',
      'closed': 'bg-gray-100 text-gray-800'
    }
    return classes[status] || 'bg-gray-100 text-gray-800'
  }

  revertDealMove(element) {
    // Logic to revert the deal back to its original position
    const originalStatus = element.dataset.originalStatus
    const originalColumn = this.element.querySelector(`[data-status="${originalStatus}"]`)
    if (originalColumn) {
      originalColumn.appendChild(element)
    }
  }

  initializeNotifications() {
    // Initialize real-time notifications
    this.notificationContainer = this.createNotificationContainer()
  }

  createNotificationContainer() {
    let container = document.getElementById("notification-container")
    if (!container) {
      container = document.createElement("div")
      container.id = "notification-container"
      container.className = "fixed top-4 right-4 z-50 space-y-2"
      document.body.appendChild(container)
    }
    return container
  }

  showNotification(message, type = "info") {
    const notification = document.createElement("div")
    notification.className = `px-6 py-4 rounded-lg shadow-lg transition-all duration-300 transform translate-x-full ${this.getNotificationClass(type)}`
    notification.innerHTML = `
      <div class="flex items-center justify-between">
        <span class="font-medium">${message}</span>
        <button onclick="this.parentElement.parentElement.remove()" class="ml-4 text-lg">&times;</button>
      </div>
    `
    
    this.notificationContainer.appendChild(notification)
    
    // Animate in
    setTimeout(() => {
      notification.classList.remove("translate-x-full")
    }, 100)
    
    // Auto remove after 5 seconds
    setTimeout(() => {
      notification.classList.add("translate-x-full")
      setTimeout(() => notification.remove(), 300)
    }, 5000)
  }

  getNotificationClass(type) {
    const classes = {
      'success': 'bg-green-500 text-white',
      'error': 'bg-red-500 text-white',
      'warning': 'bg-yellow-500 text-white',
      'info': 'bg-blue-500 text-white'
    }
    return classes[type] || classes.info
  }

  disconnect() {
    // Cleanup sortable instances
    this.columnTargets.forEach(column => {
      if (column.sortable) {
        column.sortable.destroy()
      }
    })
  }
}