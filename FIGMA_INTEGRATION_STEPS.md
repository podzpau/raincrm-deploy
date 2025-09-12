# Figma → RainCRM Integration Steps

## Method 1: Do It Yourself (Immediate)

### Step 1: Export from Figma
1. Install "Figma to Code" plugin in Figma
2. Select your component/screen
3. Choose "HTML + Tailwind CSS" 
4. Copy the generated code

### Step 2: Paste into RainCRM
1. Create new file: `app/views/shared/_your_design.html.erb`
2. Paste the Figma-generated HTML
3. Replace static text with Rails variables:
   ```erb
   <!-- Before (from Figma) -->
   <h2>John Doe</h2>
   
   <!-- After (Rails integration) -->
   <h2><%= user.full_name %></h2>
   ```

### Step 3: Use Your Component
```erb
<%= render 'shared/your_design', user: current_user, deal: @deal %>
```

## Method 2: Share with Claude (For Help)

### Option A: Figma Link
- Share your Figma file link (public view)
- I can see your designs and help convert them

### Option B: Screenshots
- Take screenshots of key screens
- Share design specs (colors, fonts, spacing)
- I'll help recreate the design in Rails

### Option C: Design Tokens
Share your design system:
```
Colors:
- Primary: #1E40AF
- Secondary: #059669
- Accent: #DC2626

Fonts:
- Heading: Inter Bold
- Body: Inter Regular

Spacing:
- Small: 8px
- Medium: 16px
- Large: 24px
```

## Ready-to-Use Examples

Your RainCRM already has example components at:
- http://localhost:3000/figma-demo
- Shows how real Figma designs integrate
- Copy this pattern for your own designs

## Files You Can Customize Right Now

1. `tailwind.config.js` - Add your colors/fonts
2. `app/views/shared/_deal_card_figma.html.erb` - Sample component
3. `app/views/dashboard/index.html.erb` - Main dashboard
4. `app/views/layouts/application.html.erb` - Global layout