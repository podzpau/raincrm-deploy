module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      // Your Figma design tokens
      colors: {
        // Brand colors from your Rain CRM Figma design
        'brand': {
          'primary': '#4469E4',      // Your primary blue
          'secondary': '#10B981',    // Green for notifications/success
          'accent': '#F59E0B',       // Warning/accent color
          'neutral': '#9CA3AF',      // Neutral gray
        },
        // Sidebar colors
        'sidebar': {
          'bg': '#9CA3AF',           // Neutral-400 from your design
          'text': '#FFFFFF',         // White text
        },
        // Status colors for deals
        'status': {
          'lead': '#F59E0B',         // Orange for leads
          'active': '#10B981',       // Green for active deals
          'pending': '#F59E0B',      // Yellow for pending
          'closed': '#6B7280',       // Gray for closed
          'overdue': '#EF4444',      // Red for overdue
        }
      },
      fontFamily: {
        // Add your Figma fonts
        'display': ['Inter', 'system-ui', 'sans-serif'],  // Replace with your Figma display font
        'body': ['Inter', 'system-ui', 'sans-serif'],     // Replace with your Figma body font
      },
      spacing: {
        // Custom spacing from your Figma design system
        '18': '4.5rem',   // 72px
        '88': '22rem',    // 352px
      },
      borderRadius: {
        // Custom border radius from Figma
        'xl': '1rem',     // 16px
        '2xl': '1.5rem',  // 24px
      },
      boxShadow: {
        // Custom shadows from your Figma design
        'card': '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
        'modal': '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),      // For better form styling
    require('@tailwindcss/typography'), // For rich text content
  ],
}