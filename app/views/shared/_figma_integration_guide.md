# Figma → RainCRM Integration Guide

## Quick Integration Process

### 1. Export from Figma
- Use "Figma to Code" plugin
- Select your design component
- Choose "HTML + Tailwind CSS" output
- Copy the generated code

### 2. Create Rails Partial
```erb
<!-- app/views/shared/_your_component.html.erb -->
<div class="figma-generated-classes">
  <!-- Paste Figma HTML here -->
  <!-- Replace static content with Rails helpers -->
</div>
```

### 3. Integrate with Rails Data
Replace static content with dynamic data:
```erb
<!-- Before (Figma export) -->
<h2 class="text-2xl font-bold text-gray-900">John Doe</h2>

<!-- After (Rails integration) -->
<h2 class="text-2xl font-bold text-gray-900"><%= user.full_name %></h2>
```

### 4. Use in Your Views
```erb
<%= render 'shared/your_component', user: current_user %>
```

## Design System Setup

### 1. Extract Design Tokens from Figma
- Colors → Tailwind config
- Typography → CSS classes
- Spacing → Tailwind utilities
- Components → Rails partials

### 2. Update Tailwind Config
```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        'brand-blue': '#1E40AF',    // From Figma
        'brand-green': '#059669',   // From Figma
        // Add your Figma colors
      }
    }
  }
}
```

## Component Mapping Strategy

### Figma Component → Rails Partial
- Header Design → `_header.html.erb`
- Card Design → `_deal_card.html.erb`
- Form Design → `_deal_form.html.erb`
- Dashboard → `dashboard/index.html.erb`