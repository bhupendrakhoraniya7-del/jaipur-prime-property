# Jaipur Prime Property — Luxury Commercial Real Estate Website

A high-end, responsive one-page website designed and engineered for **Jaipur Prime Property**, specializing in prime commercial plots and real estate investments across high-growth corridors in Jaipur, Rajasthan.

---

## 🌟 Visual Identity & Design System

- **Palette**: Warm Ivory (`#FAF8F5`), Alabaster (`#F3EFEA`), Deep Obsidian Charcoal (`#141619`), and Muted Champagne Brass (`#C5A880` / `#A8885B`).
- **Typography Pairing**:
  - **Headings & Display**: *Cormorant Garamond* (Editorial, architectural, prestigious serif)
  - **Body, UI & Navigation**: *Plus Jakarta Sans* (Contemporary geometric sans-serif)
- **Aesthetic**: Boutique investment advisory, generous whitespace, refined hairline borders, and zero generic listing clutter.

---

## 📂 Project Architecture

```
khoraniya-prime-properties/
├── index.html               # 13 structured sections, semantic HTML5, Schema.org JSON-LD
├── README.md                # Documentation & customization guide
└── assets/
    ├── css/
    │   └── styles.css       # Custom design tokens, glassmorphism, responsive utilities
    └── js/
        └── main.js          # Interactive modals, accordions, form handling, WhatsApp links
```

---

## 🚀 How to Run and Preview

1. **Direct Browser Preview**:
   - Simply double-click [`index.html`](file:///c:/Users/bhupendra/Desktop/khoraniya-prime-properties/index.html) to open it in Chrome, Edge, Safari, or Firefox.
2. **Via Local Server** (optional):
   - You can run an HTTP server using Python or Node if desired:
     ```bash
     npx serve .
     # or
     python -m http.server 8000
     ```

---

## 🛠️ How to Customize Placeholders

### 1. WhatsApp Number
- Open [`assets/js/main.js`](file:///c:/Users/bhupendra/Desktop/khoraniya-prime-properties/assets/js/main.js)
- Update line 57:
  ```javascript
  const WHATSAPP_PHONE = '919876543210'; // Replace with your real 10-digit number including 91 country code
  ```

### 2. Phone & Office Address in HTML
- In [`index.html`](file:///c:/Users/bhupendra/Desktop/khoraniya-prime-properties/index.html), search for `Placeholder` to replace contact details in the footer and mobile dock:
  - Phone: `+91 76899 32586`
  - WhatsApp: `+91 76899 32586`
  - Office Address: `Civil Lines / C-Scheme, Jaipur, Rajasthan 302001`

### 3. Property Cards & Modal Specs
- Commercial plot specifications, sizes, and highlights can be updated directly in `propertyData` within [`assets/js/main.js`](file:///c:/Users/bhupendra/Desktop/khoraniya-prime-properties/assets/js/main.js) (lines 6–54).

### 4. Client Testimonials
- The 3 testimonial cards in Section 9 of [`index.html`](file:///c:/Users/bhupendra/Desktop/khoraniya-prime-properties/index.html) contain clearly designated placeholder quotes ready to be replaced with genuine reviews.

---

## 📱 Mobile-First Features

- **Responsive Navigation**: Smooth mobile drawer menu with one-tap WhatsApp and enquiry links.
- **Sticky Bottom Action Dock**: Mobile floating bar with direct **Call | WhatsApp | Enquire** buttons that hides automatically when the lead capture form comes into view.
- **Interactive Property Inspection Modal**: Allows users to inspect road frontage, zoning classification, and dimensions, then auto-fills their selected plot into the inquiry form.
- **Accessible Accordions**: ARIA-expanded FAQ accordions with keyboard support.
- **Pre-Delivery Checklist & Contrast Compliance**: WCAG AA compliant text contrast across all surfaces.

---

## 🔐 Visual Admin Portal (CMS)

To add, edit, or delete projects and update company details without touching code:
1. Open [`admin.html`](file:///c:/Users/bhupendra/Desktop/khoraniya-prime-properties/admin.html) or visit `https://khoraniyaprimeproperties.in/admin.html`.
2. Enter security PIN: `1234` (can be changed inside the portal).
3. Manage commercial plots and contact information visually.
4. Click **"Publish Changes to Live Site"** to push updates directly to GitHub!

---
© 2026 Jaipur Prime Property. All rights reserved.
