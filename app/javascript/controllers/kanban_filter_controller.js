import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filterButton", "dropdown", "searchInput"]
  static values = { 
    currentFilter: String,
    currentSearch: String 
  }

  connect() {
    this.initializeFilters()
  }

  initializeFilters() {
    // Set initial filter state
    this.updateFilterDisplay()
  }

  toggleDropdown() {
    this.dropdownTarget.classList.toggle("hidden")
  }

  filterByParty(event) {
    const party = event.currentTarget.dataset.party
    this.currentFilterValue = party
    this.applyFilters()
    this.hideDropdown()
  }

  searchDeals(event) {
    clearTimeout(this.searchTimeout)
    this.searchTimeout = setTimeout(() => {
      this.currentSearchValue = event.target.value
      this.applyFilters()
    }, 300)
  }

  clearFilters() {
    this.currentFilterValue = ""
    this.currentSearchValue = ""
    this.searchInputTarget.value = ""
    this.applyFilters()
  }

  applyFilters() {
    const url = new URL(window.location)
    
    if (this.currentFilterValue) {
      url.searchParams.set("party", this.currentFilterValue)
    } else {
      url.searchParams.delete("party")
    }
    
    if (this.currentSearchValue) {
      url.searchParams.set("search", this.currentSearchValue)
    } else {
      url.searchParams.delete("search")
    }

    // Use Turbo to navigate without full page reload
    Turbo.visit(url.toString(), { action: "replace" })
    
    this.updateFilterDisplay()
  }

  updateFilterDisplay() {
    // Update the filter button text
    const filterText = this.currentFilterValue || "All Parties"
    if (this.hasFilterButtonTarget) {
      this.filterButtonTarget.querySelector(".filter-text").textContent = filterText
    }

    // Add visual indicators for active filters
    this.element.classList.toggle("has-active-filters", 
      this.currentFilterValue || this.currentSearchValue)
  }

  hideDropdown() {
    this.dropdownTarget.classList.add("hidden")
  }

  // Close dropdown when clicking outside
  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
  }

  handleOutsideClick = (event) => {
    if (!this.element.contains(event.target)) {
      this.hideDropdown()
    }
  }
}