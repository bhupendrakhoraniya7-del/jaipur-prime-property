/**
 * Khoraniya Prime Properties - Interactive Frontend Script & CMS Data Binding
 */

// Fallback Default Data in case fetch is blocked (e.g. local file:// protocol)
const defaultSiteData = {
  contact: {
    phone: "7689932586",
    rawPhone: "7689932586",
    whatsapp: "7689932586",
    email: "khoraniyaprimeproperties@gmail.com",
    address: "Jaipur, Rajasthan 302001",
    tagline: "Invest. Own. Prosper."
  },
  properties: [
    {
      id: "prop-1",
      title: "Chart Nexara",
      location: "Mahindra world city , Ajmer road , Jaipur",
      tagline: "LOCATED IN MAHINDRA WORLD CITY (INDIA'S LARGEST SEZ)",
      rate: "residential plot rate 34,950rupees , commercial plot rate 47000",
      size: "100 gaj – 200gaj",
      sizes: ["100 gaj", "150gaj", "200gaj"],
      type: "Commercial & Residential Plots",
      frontage: "60 Ft. Wide Sector Road Frontage",
      zoning: "Commercial / Residential / SEZ Zone",
      possession: "Immediate / Registry Ready",
      image: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1577495508048-b635879837f1?auto=format&fit=crop&w=1200&q=80"
      ],
      roadmap: {
        type: "pdf",
        url: "assets/docs/THE-CHART-NEXARA-M-.pdf",
        title: "THE CHART NEXARA-M-.pdf"
      },
      description: "CHART NEXARA Mahindra World City, Jaipur ✨ A Golden Opportunity to Invest in the Future! ✨ 🏡 200+ commercial and residential investment plots with direct highway connectivity.",
      highlights: [
        "📈 High Growth Location | High Appreciation Potential | Smart Investment",
        "Mahindra World City, Ajmer road , Jaipur",
        "Located in Mahindra World City (India's Largest SEZ)",
        "Official Demarcation & Sector Road Layout Plan Attached (PDF)"
      ]
    },
    {
      id: "prop-2",
      title: "Prime Business District",
      location: "JLN Marg / Malviya Nagar, Jaipur",
      tagline: "Excellent connectivity | Investment potential",
      rate: "₹68,000 / sq. yd",
      size: "200 – 750 sq. yd",
      sizes: ["200 sq. yd", "300 sq. yd", "500 sq. yd", "750 sq. yd"],
      type: "Commercial Plot (High-Density)",
      frontage: "80 Ft. Master Plan Arterial",
      zoning: "Corporate & Mixed Commercial Use",
      possession: "Ready for Development",
      image: "https://images.unsplash.com/photo-1577495508048-b635879837f1?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1577495508048-b635879837f1?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=1200&q=80"
      ],
      roadmap: {
        type: "image",
        url: "https://images.unsplash.com/photo-1524813686514-a57563d77d66?auto=format&fit=crop&w=1200&q=80",
        title: "80 Ft. Arterial Layout & Sector Plan"
      },
      description: "A prestigious commercial plot cluster located in Jaipur’s high-density business cluster, offering rapid transit connectivity, robust underground utility provisions, and superior rental yield prospects for commercial developers.",
      highlights: [
        "Proximity to major ring corridors and established corporate nodes",
        "Dual-side accessibility supporting efficient logistics and customer parking",
        "High anticipated appreciation index backed by municipal infrastructure",
        "Zoned for corporate offices, diagnostic centers, or hospitality ventures"
      ]
    },
    {
      id: "prop-3",
      title: "Prime Investment Enclave",
      location: "Tonk Road Growth Axis, Jaipur",
      tagline: "Growth-focused location | Commercial potential",
      rate: "₹52,000 / sq. yd",
      size: "300 – 1,200 sq. yd",
      sizes: ["300 sq. yd", "500 sq. yd", "800 sq. yd", "1,200 sq. yd"],
      type: "Commercial Plot (Flagship Scale)",
      frontage: "100 Ft. Main Growth Corridor",
      zoning: "Anchor Commercial / Showroom / Institution",
      possession: "Strategic Investment Holding",
      image: "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1577495508048-b635879837f1?auto=format&fit=crop&w=1200&q=80"
      ],
      roadmap: {
        type: "image",
        url: "https://images.unsplash.com/photo-1524813686514-a57563d77d66?auto=format&fit=crop&w=1200&q=80",
        title: "100 Ft. Highway Corridor Master Plan"
      },
      description: "An expansive prime plot layout tailored for marquee commercial developments, flagship automotive/retail showrooms, or long-term institutional land-banking in Jaipur’s most promising growth zone.",
      highlights: [
        "Generous 100-foot frontage allowing magnificent architectural elevation",
        "Exceptional transit linkages connecting the airport and regional expressways",
        "Surrounded by premium upcoming residential catchments driving local commerce",
        "Unmatched land asset for legacy investors and high-net-worth portfolios"
      ]
    }
  ]
};

// Global State
window.currentSiteData = defaultSiteData;
let propertyLookup = {};

document.addEventListener('DOMContentLoaded', async () => {
  await loadSiteData();
  renderProperties();
  bindContactInfo();
  initNavigation();
  initPropertyModal();
  initAccordions();
  initLeadForm();
  initMobileActionBar();
});

function openCMSDatabase() {
  return new Promise((resolve) => {
    if (!window.indexedDB) return resolve(null);
    try {
      const req = window.indexedDB.open('KhoraniyaCMS_DB', 1);
      req.onupgradeneeded = (e) => {
        const db = e.target.result;
        if (!db.objectStoreNames.contains('store')) {
          db.createObjectStore('store');
        }
      };
      req.onsuccess = (e) => resolve(e.target.result);
      req.onerror = () => resolve(null);
    } catch (err) {
      resolve(null);
    }
  });
}

async function getFromIndexedDB(key) {
  try {
    const db = await openCMSDatabase();
    if (!db) return null;
    return new Promise((resolve) => {
      const tx = db.transaction('store', 'readonly');
      const req = tx.objectStore('store').get(key);
      req.onsuccess = () => resolve(req.result || null);
      req.onerror = () => resolve(null);
    });
  } catch (e) {
    return null;
  }
}

/**
 * Load Data from IndexedDB, LocalStorage, JSON file, or Default Fallback
 */
async function loadSiteData() {
  try {
    // 1. Fetch official site-data.json from server
    let serverData = null;
    try {
      const response = await fetch('assets/data/site-data.json?t=' + Date.now());
      if (response.ok) {
        serverData = await response.json();
      }
    } catch (e) {
      console.warn('Could not fetch server site-data.json:', e);
    }

    // 2. Check IndexedDB (for local unpublished edits in Admin Panel)
    const idbData = await getFromIndexedDB('site_data');

    // 3. Check localStorage
    let cachedData = null;
    try {
      const raw = localStorage.getItem('khoraniya_site_data');
      if (raw) cachedData = JSON.parse(raw);
    } catch (e) {}

    // Combine & Smart Resolve:
    // If idbData exists and has properties, merge them with serverData!
    // Any project created by the user (in idbData or serverData) will be included immediately!
    if (serverData || idbData || cachedData) {
      const baseContact = idbData?.contact || serverData?.contact || cachedData?.contact || defaultSiteData.contact;
      const propMap = new Map();
      
      // 1. Add server properties
      if (serverData && Array.isArray(serverData.properties)) {
        serverData.properties.forEach(p => {
          if (p && p.id) propMap.set(p.id, p);
        });
      }
      
      // 2. Add cached properties
      if (cachedData && Array.isArray(cachedData.properties)) {
        cachedData.properties.forEach(p => {
          if (p && p.id && !propMap.has(p.id)) propMap.set(p.id, p);
        });
      }

      // 3. Add IDB properties (IDB has user's latest edits on this browser)
      if (idbData && Array.isArray(idbData.properties)) {
        const idbTime = Number(idbData.updatedAt || 0);
        const serverTime = Number(serverData?.updatedAt || 0);
        
        if (idbTime > serverTime && idbData.properties.length < propMap.size) {
          // User explicitly deleted a project in IDB
          propMap.clear();
          idbData.properties.forEach(p => { if (p && p.id) propMap.set(p.id, p); });
        } else {
          // Merge / update properties with IDB versions
          idbData.properties.forEach(p => {
            if (p && p.id) propMap.set(p.id, p);
          });
        }
      }

      const allProps = Array.from(propMap.values());

      if (allProps.length > 0) {
        window.currentSiteData = {
          contact: baseContact,
          properties: allProps,
          updatedAt: Math.max(Number(serverData?.updatedAt || 0), Number(idbData?.updatedAt || 0))
        };
      } else {
        window.currentSiteData = serverData || idbData || cachedData || defaultSiteData;
      }
    } else {
      window.currentSiteData = defaultSiteData;
    }
  } catch (err) {
    console.warn('Loading bundled default fallback data:', err);
    window.currentSiteData = defaultSiteData;
  }

  // Build ID lookup dictionary for fast modal access
  propertyLookup = {};
  if (window.currentSiteData && window.currentSiteData.properties) {
    window.currentSiteData.properties.forEach(p => {
      propertyLookup[p.id] = p;
    });
  }
}

/**
 * Dynamically Render Property Cards into #properties-grid
 */
function renderProperties() {
  const grid = document.getElementById('properties-grid');
  if (!grid || !window.currentSiteData.properties) return;

  const props = window.currentSiteData.properties;
  grid.innerHTML = props.map(prop => {
    const photoCount = (prop.gallery && prop.gallery.length) || 1;
    const sizesList = prop.sizes && prop.sizes.length ? prop.sizes : [prop.size || 'Commercial Plot'];

    return `
    <div class="property-card bg-white rounded-xl overflow-hidden flex flex-col justify-between border border-[#E7E0D5] hover:shadow-lg transition-all duration-300">
      <div>
        <div class="relative h-64 overflow-hidden bg-stone-900 group cursor-pointer" onclick="openPropertyModal('${escapeHtml(prop.id)}')">
          <img 
            src="${escapeHtml(prop.image)}" 
            alt="${escapeHtml(prop.title)} - Commercial Plot in Jaipur" 
            class="property-img w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            loading="lazy"
            onerror="this.src='https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=800&q=80'"
          >
          <div class="absolute top-3 left-3 bg-[#141619]/90 text-[#D5BA8E] text-[11px] font-semibold tracking-wider uppercase px-3 py-1 rounded backdrop-blur-sm">
            ${escapeHtml(prop.type || 'Commercial Plot')}
          </div>
          
          <div class="absolute top-3 right-3 bg-black/80 backdrop-blur-sm text-white text-[11px] font-bold px-2.5 py-1 rounded flex items-center gap-1.5 shadow">
            <svg class="w-3.5 h-3.5 text-[#D5BA8E]" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
            <span>${photoCount} Photos</span>
          </div>

          <div class="absolute bottom-3 right-3 bg-[#141619]/95 text-[#D5BA8E] text-xs font-bold px-3 py-1 rounded shadow-md border border-[#C5A880]/30 backdrop-blur-sm">
            ${escapeHtml(prop.rate || prop.size || '')}
          </div>

          ${prop.roadmap ? `
            <div class="absolute bottom-3 left-3 bg-blue-900/90 text-white text-[10px] font-bold px-2.5 py-1 rounded shadow flex items-center gap-1 backdrop-blur-sm">
              <span>🗺️ Road Map Attached</span>
            </div>
          ` : ''}
        </div>
        
        <div class="p-6">
          <div class="flex items-center gap-1.5 text-xs text-[#555E68] mb-1.5">
            <svg class="w-3.5 h-3.5 text-[#A8885B]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
            </svg>
            <span>${escapeHtml(prop.location || 'Jaipur, Rajasthan')}</span>
          </div>
          <h3 class="font-serif text-2xl font-bold text-[#141619] mb-1.5">${escapeHtml(prop.title)}</h3>
          <p class="text-xs text-[#A8885B] font-semibold uppercase tracking-wider mb-3">
            ${escapeHtml(prop.tagline || 'Strategic Commercial Investment')}
          </p>

          <!-- Plot Sizes Badges -->
          <div class="flex flex-wrap items-center gap-1.5 mb-3">
            <span class="text-[11px] text-[#555E68] font-semibold">Available Sizes:</span>
            ${sizesList.map(s => `<span class="text-[10px] bg-[#FAF8F5] text-[#141619] px-2 py-0.5 rounded border border-[#E7E0D5] font-semibold">${escapeHtml(s)}</span>`).join('')}
          </div>

          <p class="text-xs sm:text-[13px] text-[#555E68] line-clamp-2 leading-relaxed">
            ${escapeHtml(prop.description || '')}
          </p>
        </div>
      </div>

      <div class="p-6 pt-0 border-t border-[#E7E0D5]/60 mt-4 flex items-center justify-between">
        <div>
          <span class="text-[10px] uppercase tracking-wider text-[#88909A] block">Starting Rate</span>
          <span class="text-sm font-bold text-[#141619]">${escapeHtml(prop.rate || 'On Request')}</span>
        </div>
        <button onclick="openPropertyModal('${escapeHtml(prop.id)}')" class="btn-outline-gold px-4 py-2 rounded text-xs uppercase tracking-wider font-semibold">
          View Details & Map
        </button>
      </div>
    </div>
    `;
  }).join('');

  // Also update property options in lead capture dropdown
  const select = document.getElementById('form-property');
  if (select) {
    const defaultOption = '<option value="">Select Category / Plot</option>';
    const options = props.map(p => `<option value="${escapeHtml(p.title)}">${escapeHtml(p.title)} (${escapeHtml(p.rate || p.size)})</option>`).join('');
    const additionalOptions = `
      <option value="Commercial Land Banking">Long-Term Commercial Land Banking</option>
      <option value="Retail Showroom Plot">Retail / Showroom Plot</option>
      <option value="Other Commercial">Other Commercial Requirement</option>
    `;
    select.innerHTML = defaultOption + options + additionalOptions;
  }
}

function formatWhatsAppUrlNumber(num) {
  if (!num) return '917689932586';
  let clean = num.toString().replace(/\D/g, '');
  if (clean.length === 10) {
    clean = '91' + clean;
  } else if (clean.length === 11 && clean.startsWith('0')) {
    clean = '91' + clean.slice(1);
  }
  return clean || '917689932586';
}

function formatDisplayPhoneNumber(num) {
  if (!num) return '+91 7689932586';
  let clean = num.toString().trim();
  if (clean.startsWith('+')) return clean;
  let digits = clean.replace(/\D/g, '');
  if (digits.length === 10) {
    return '+91 ' + digits;
  }
  if (digits.length === 12 && digits.startsWith('91')) {
    return '+91 ' + digits.slice(2);
  }
  return clean;
}

/**
 * Bind Contact Info Dynamically Across Website
 */
function bindContactInfo() {
  const contact = window.currentSiteData.contact || defaultSiteData.contact;

  const displayPhone = formatDisplayPhoneNumber(contact.phone || '7689932586');
  const rawCallNum = (contact.rawPhone || contact.phone || '7689932586').toString().replace(/\D/g, '');
  const displayWa = formatDisplayPhoneNumber(contact.whatsapp || '7689932586');
  const waUrlNum = formatWhatsAppUrlNumber(contact.whatsapp || '7689932586');
  const telHref = `tel:+${rawCallNum.length === 10 ? '91' + rawCallNum : rawCallNum}`;

  // Phone
  document.querySelectorAll('[data-bind="phone"]').forEach(el => {
    el.textContent = displayPhone;
    if (el.tagName === 'A') {
      el.href = telHref;
    }
  });

  // WhatsApp
  document.querySelectorAll('[data-bind="whatsapp"]').forEach(el => {
    el.textContent = displayWa;
    if (el.tagName === 'A') {
      el.href = `https://wa.me/${waUrlNum}`;
    }
  });

  // Raw Phone / Call links
  document.querySelectorAll('a[href^="tel:"]').forEach(el => {
    el.href = telHref;
  });

  // Email
  document.querySelectorAll('[data-bind="email"]').forEach(el => {
    el.textContent = contact.email || 'khoraniyaprimeproperties@gmail.com';
    if (el.tagName === 'A') {
      el.href = `mailto:${contact.email || 'khoraniyaprimeproperties@gmail.com'}`;
    }
  });

  // Address
  document.querySelectorAll('[data-bind="address"]').forEach(el => {
    el.textContent = contact.address || 'Civil Lines / C-Scheme, Jaipur, Rajasthan 302001';
  });

  // Tagline
  document.querySelectorAll('[data-bind="tagline"]').forEach(el => {
    el.textContent = contact.tagline || 'Invest. Own. Prosper.';
  });
}

/**
 * Helper to escape HTML and prevent XSS
 */
function escapeHtml(str) {
  if (!str) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}

/* --------------------------------------------------------------------------
   1. NAVIGATION & SCROLL
   -------------------------------------------------------------------------- */
function initNavigation() {
  const header = document.querySelector('.glass-header');
  const mobileMenuBtn = document.getElementById('mobile-menu-btn');
  const mobileMenuDrawer = document.getElementById('mobile-drawer');
  const mobileMenuClose = document.getElementById('mobile-drawer-close');
  const mobileLinks = document.querySelectorAll('.mobile-nav-link');

  // Scroll Compact & Blur
  window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
      header?.classList.add('scrolled');
    } else {
      header?.classList.remove('scrolled');
    }
  });

  // Mobile Drawer Toggle
  if (mobileMenuBtn && mobileMenuDrawer) {
    mobileMenuBtn.addEventListener('click', () => {
      mobileMenuDrawer.classList.remove('hidden');
      document.body.style.overflow = 'hidden';
    });

    const closeDrawer = () => {
      mobileMenuDrawer.classList.add('hidden');
      document.body.style.overflow = '';
    };

    mobileMenuClose?.addEventListener('click', closeDrawer);
    mobileLinks.forEach(link => link.addEventListener('click', closeDrawer));

    // Close on backdrop tap
    mobileMenuDrawer.addEventListener('click', (e) => {
      if (e.target === mobileMenuDrawer) closeDrawer();
    });
  }

  // Active Link Scroll Spy
  const sections = document.querySelectorAll('section[id]');
  window.addEventListener('scroll', () => {
    const scrollY = window.pageYOffset;
    sections.forEach(current => {
      const sectionHeight = current.offsetHeight;
      const sectionTop = current.offsetTop - 120;
      const sectionId = current.getAttribute('id');
      const navLink = document.querySelector(`.nav-link[href*="${sectionId}"]`);
      if (navLink) {
        if (scrollY > sectionTop && scrollY <= sectionTop + sectionHeight) {
          navLink.classList.add('text-[#A8885B]', 'font-semibold');
        } else {
          navLink.classList.remove('text-[#A8885B]', 'font-semibold');
        }
      }
    });
  });
}

/* --------------------------------------------------------------------------
   2. PROPERTY MODAL HANDLER (WITH MULTI-PHOTO CAROUSEL & ROAD MAP LIGHTBOX)
   -------------------------------------------------------------------------- */
let activeModalGallery = [];
let activeModalGalleryIndex = 0;
let activeSelectedPlotSize = '';
let currentPropId = null;

function updateModalGalleryStage() {
  const imgElem = document.getElementById('modal-img');
  const counterElem = document.getElementById('modal-photo-counter');
  const thumbsContainer = document.getElementById('modal-thumbnails-container');

  if (!activeModalGallery || activeModalGallery.length === 0) return;

  const currentUrl = activeModalGallery[activeModalGalleryIndex];
  if (imgElem) {
    imgElem.src = currentUrl;
  }

  if (counterElem) {
    counterElem.textContent = `Photo ${activeModalGalleryIndex + 1} / ${activeModalGallery.length}`;
  }

  // Update thumbnail active styles
  if (thumbsContainer) {
    const thumbButtons = thumbsContainer.querySelectorAll('.modal-thumb-btn');
    thumbButtons.forEach((btn, idx) => {
      if (idx === activeModalGalleryIndex) {
        btn.classList.add('ring-2', 'ring-[#C5A880]', 'opacity-100');
        btn.classList.remove('opacity-50');
        btn.scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });
      } else {
        btn.classList.remove('ring-2', 'ring-[#C5A880]', 'opacity-100');
        btn.classList.add('opacity-50');
      }
    });
  }
}

window.navigateModalGallery = function(direction) {
  if (!activeModalGallery || activeModalGallery.length <= 1) return;
  activeModalGalleryIndex = (activeModalGalleryIndex + direction + activeModalGallery.length) % activeModalGallery.length;
  updateModalGalleryStage();
};

window.selectModalGallerySlide = function(index) {
  if (!activeModalGallery || index < 0 || index >= activeModalGallery.length) return;
  activeModalGalleryIndex = index;
  updateModalGalleryStage();
};

window.selectModalPlotSize = function(size) {
  activeSelectedPlotSize = size;
  const labelElem = document.getElementById('modal-selected-size-text');
  if (labelElem) labelElem.textContent = size;

  const chips = document.querySelectorAll('.modal-size-chip');
  chips.forEach(chip => {
    if (chip.getAttribute('data-size') === size) {
      chip.className = 'modal-size-chip px-3.5 py-1.5 rounded text-xs font-bold bg-[#C5A880] text-[#141619] border border-[#C5A880] shadow-sm transition-all';
    } else {
      chip.className = 'modal-size-chip px-3.5 py-1.5 rounded text-xs font-semibold bg-white text-[#33383F] border border-[#E7E0D5] hover:border-[#C5A880] transition-all';
    }
  });
};

window.openRoadmapLightbox = function(url, title) {
  const lightbox = document.getElementById('roadmap-lightbox');
  const img = document.getElementById('lightbox-roadmap-img');
  const titleElem = document.getElementById('lightbox-roadmap-title');
  if (!lightbox || !img) return;

  img.src = url;
  if (titleElem) titleElem.textContent = title || 'Road Map / Master Layout Plan';
  lightbox.classList.remove('hidden');
  lightbox.classList.add('flex');
  document.body.style.overflow = 'hidden';
};

window.closeRoadmapLightbox = function() {
  const lightbox = document.getElementById('roadmap-lightbox');
  if (lightbox) {
    lightbox.classList.add('hidden');
    lightbox.classList.remove('flex');
    const modalBackdrop = document.getElementById('property-modal');
    if (!modalBackdrop || !modalBackdrop.classList.contains('active')) {
      document.body.style.overflow = '';
    }
  }
};

function initPropertyModal() {
  const modalBackdrop = document.getElementById('property-modal');
  const modalCloseBtn = document.getElementById('modal-close-btn');
  const modalInquireBtn = document.getElementById('modal-inquire-btn');
  const prevBtn = document.getElementById('modal-gallery-prev');
  const nextBtn = document.getElementById('modal-gallery-next');

  window.openPropertyModal = function(id) {
    try {
      let data = propertyLookup[id];
      if (!data && window.currentSiteData && Array.isArray(window.currentSiteData.properties)) {
        data = window.currentSiteData.properties.find(p => 
          p.id === id || 
          p.title === id || 
          (p.title && id && p.title.toLowerCase() === id.toLowerCase()) ||
          (p.title && id && (p.title.toLowerCase().includes(id.toLowerCase()) || id.toLowerCase().includes(p.title.toLowerCase())))
        );
      }
      if (!data && window.currentSiteData && Array.isArray(window.currentSiteData.properties) && window.currentSiteData.properties.length > 0) {
        data = window.currentSiteData.properties[0];
      }
      if (!data) {
        console.warn('Property not found for ID:', id);
        return;
      }
      currentPropId = data.id || id;

      const safeSetText = (elemId, text) => {
        const el = document.getElementById(elemId);
        if (el) el.textContent = text || '';
      };

      // Rate
      const rateVal = data.rate || 'Price on Request';
      safeSetText('modal-rate', rateVal);
      safeSetText('modal-rate-badge', rateVal);

      // Basic details
      safeSetText('modal-title', data.title);
      safeSetText('modal-location', data.location);
      safeSetText('modal-size', data.size);
      safeSetText('modal-type', data.type || 'Commercial Plot');
      safeSetText('modal-frontage', data.frontage || 'Standard Sector Frontage');
      safeSetText('modal-zoning', data.zoning || 'Commercial / Retail');
      safeSetText('modal-possession', data.possession || 'Immediate / Ready');
      safeSetText('modal-description', data.description);

      // Multi-photo Gallery
      let galleryList = [];
      if (Array.isArray(data.gallery) && data.gallery.length > 0) {
        galleryList = [...data.gallery];
      } else if (data.image) {
        galleryList = [data.image];
      } else {
        galleryList = ['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=1200&q=80'];
      }
      activeModalGallery = galleryList;
      activeModalGalleryIndex = 0;

      // Toggle Prev/Next buttons if only 1 image
      if (prevBtn && nextBtn) {
        if (galleryList.length > 1) {
          prevBtn.classList.remove('hidden');
          nextBtn.classList.remove('hidden');
        } else {
          prevBtn.classList.add('hidden');
          nextBtn.classList.add('hidden');
        }
      }

      // Render Thumbnails Ribbon
      const thumbsContainer = document.getElementById('modal-thumbnails-container');
      if (thumbsContainer) {
        if (galleryList.length > 1) {
          thumbsContainer.classList.remove('hidden');
          thumbsContainer.innerHTML = galleryList.map((imgUrl, idx) => `
            <button type="button" onclick="selectModalGallerySlide(${idx})" data-index="${idx}" class="modal-thumb-btn flex-shrink-0 w-14 h-12 rounded overflow-hidden border border-stone-700 transition-all ${idx === 0 ? 'ring-2 ring-[#C5A880] opacity-100' : 'opacity-50 hover:opacity-100'}">
              <img src="${escapeHtml(imgUrl)}" alt="Thumbnail ${idx + 1}" class="w-full h-full object-cover">
            </button>
          `).join('');
        } else {
          thumbsContainer.classList.add('hidden');
          thumbsContainer.innerHTML = '';
        }
      }

      updateModalGalleryStage();

      // Available Plot Sizes (Chips)
      const chipsContainer = document.getElementById('modal-sizes-chips');
      const selectedSizeText = document.getElementById('modal-selected-size-text');
      
      let sizesArr = [];
      if (Array.isArray(data.sizes) && data.sizes.length > 0) {
        sizesArr = data.sizes;
      } else if (data.size) {
        sizesArr = [data.size];
      } else {
        sizesArr = ['Commercial Plots on Request'];
      }

      activeSelectedPlotSize = sizesArr[0];
      if (selectedSizeText) selectedSizeText.textContent = activeSelectedPlotSize;

      if (chipsContainer) {
        chipsContainer.innerHTML = sizesArr.map((sz, idx) => `
          <button type="button" data-size="${escapeHtml(sz)}" onclick="selectModalPlotSize('${escapeHtml(sz)}')" class="modal-size-chip px-3.5 py-1.5 rounded text-xs font-semibold transition-all ${idx === 0 ? 'bg-[#C5A880] text-[#141619] border border-[#C5A880] font-bold shadow-sm' : 'bg-white text-[#33383F] border border-[#E7E0D5] hover:border-[#C5A880]'}">
            ${escapeHtml(sz)}
          </button>
        `).join('');
      }

      // Road Map Section
      const roadmapTypeBadge = document.getElementById('modal-roadmap-type');
      const roadmapContent = document.getElementById('modal-roadmap-content');
      if (roadmapContent) {
        if (data.roadmap && data.roadmap.url) {
          const isPdf = (data.roadmap.type === 'pdf') || data.roadmap.url.startsWith('data:application/pdf') || data.roadmap.url.toLowerCase().endsWith('.pdf');
          if (isPdf) {
            if (roadmapTypeBadge) {
              roadmapTypeBadge.textContent = 'PDF Master Plan';
              roadmapTypeBadge.className = 'text-[10px] font-bold px-2 py-0.5 rounded bg-red-100 text-red-800 uppercase';
            }
            roadmapContent.innerHTML = `
              <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 p-3 bg-white rounded-lg border border-[#E7E0D5]">
                <div class="flex items-center gap-3">
                  <div class="w-10 h-10 rounded bg-red-50 text-red-600 border border-red-200 flex items-center justify-center flex-shrink-0 font-bold text-xs">
                    PDF
                  </div>
                  <div>
                    <h5 class="text-xs sm:text-sm font-bold text-[#141619]">${escapeHtml(data.roadmap.title || 'Official Master Layout & Sector Road Map')}</h5>
                    <p class="text-[11px] text-[#555E68]">Approved Government / Sector Layout Document</p>
                  </div>
                </div>
                <div class="flex items-center gap-2 w-full sm:w-auto">
                  <a href="${escapeHtml(data.roadmap.url)}" download="${escapeHtml(data.title.replace(/[^a-zA-Z0-9]/g, '_'))}_RoadMap.pdf" target="_blank" class="w-full sm:w-auto text-center px-4 py-2 bg-[#141619] hover:bg-[#A8885B] text-white rounded text-xs font-semibold transition-colors flex items-center justify-center gap-1.5 shadow-sm">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/></svg>
                    <span>Download / View PDF</span>
                  </a>
                </div>
              </div>
            `;
          } else {
            // Image Roadmap
            if (roadmapTypeBadge) {
              roadmapTypeBadge.textContent = 'High-Res Layout Map';
              roadmapTypeBadge.className = 'text-[10px] font-bold px-2 py-0.5 rounded bg-blue-100 text-blue-800 uppercase';
            }
            roadmapContent.innerHTML = `
              <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 p-3 bg-white rounded-lg border border-[#E7E0D5]">
                <div class="flex items-center gap-3 cursor-pointer" onclick="openRoadmapLightbox('${escapeHtml(data.roadmap.url)}', '${escapeHtml(data.title)} - Road Map')">
                  <img src="${escapeHtml(data.roadmap.url)}" alt="Road Map Preview" class="w-14 h-14 object-cover rounded border border-stone-300 flex-shrink-0 shadow-sm">
                  <div>
                    <h5 class="text-xs sm:text-sm font-bold text-[#141619] hover:text-[#A8885B] transition-colors">${escapeHtml(data.roadmap.title || 'Master Sector Road Map & Layout')}</h5>
                    <p class="text-[11px] text-[#555E68]">Click to expand full high-resolution map</p>
                  </div>
                </div>
                <button type="button" onclick="openRoadmapLightbox('${escapeHtml(data.roadmap.url)}', '${escapeHtml(data.title)} - Road Map')" class="w-full sm:w-auto px-4 py-2 bg-[#FAF8F5] hover:bg-[#141619] hover:text-white border border-[#A8885B] text-[#141619] rounded text-xs font-semibold transition-all flex items-center justify-center gap-1.5 shadow-sm">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0zM10 7v3m0 0v3m0-3h3m-3 0H7"/></svg>
                  <span>View Full Map</span>
                </button>
              </div>
            `;
          }
        } else {
          if (roadmapTypeBadge) {
            roadmapTypeBadge.textContent = 'Available on Request';
            roadmapTypeBadge.className = 'text-[10px] font-bold px-2 py-0.5 rounded bg-stone-200 text-stone-700 uppercase';
          }
          roadmapContent.innerHTML = `
            <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 p-3 bg-white rounded-lg border border-[#E7E0D5]">
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded bg-[#FAF8F5] text-[#A8885B] border border-[#E7E0D5] flex items-center justify-center flex-shrink-0 font-bold text-base">
                  🗺️
                </div>
                <div>
                  <h5 class="text-xs sm:text-sm font-bold text-[#141619]">Government-Approved Sector Layout</h5>
                  <p class="text-[11px] text-[#555E68]">Official demarcation & road map available on request</p>
                </div>
              </div>
              <button type="button" onclick="openWhatsApp('Hello Khoraniya Prime Properties, please share the official sector road map and layout for ${escapeHtml(data.title)}')" class="w-full sm:w-auto px-4 py-2 bg-[#25D366] text-white rounded text-xs font-semibold hover:opacity-90 transition-opacity flex items-center justify-center gap-1.5 shadow-sm">
                <span>Request Map on WhatsApp</span>
              </button>
            </div>
          `;
        }
      }

      // Highlights
      const highlightsList = document.getElementById('modal-highlights');
      if (highlightsList) {
        const hList = data.highlights || [];
        highlightsList.innerHTML = hList
          .map(h => `<li class="flex items-start gap-2.5 text-sm text-[#33383F]"><svg class="w-4 h-4 text-[#A8885B] flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg><span>${escapeHtml(h)}</span></li>`)
          .join('');
      }

      if (modalBackdrop) {
        modalBackdrop.classList.add('active');
        document.body.style.overflow = 'hidden';
      }
    } catch (err) {
      console.error('Error opening property modal:', err);
    }
  };

  window.closePropertyModal = function() {
    modalBackdrop.classList.remove('active');
    document.body.style.overflow = '';
  };

  modalCloseBtn?.addEventListener('click', window.closePropertyModal);

  // Close on outside backdrop click
  modalBackdrop?.addEventListener('click', (e) => {
    if (e.target === modalBackdrop) window.closePropertyModal();
  });

  const roadmapLightbox = document.getElementById('roadmap-lightbox');
  roadmapLightbox?.addEventListener('click', (e) => {
    if (e.target === roadmapLightbox) window.closeRoadmapLightbox();
  });

  // ESC key listener
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      window.closeRoadmapLightbox();
      window.closePropertyModal();
      window.closeSuccessModal();
    }
  });

  // Inquire for specific property button
  modalInquireBtn?.addEventListener('click', () => {
    const data = propertyLookup[currentPropId];
    window.closePropertyModal();

    const messageField = document.getElementById('form-message');
    const propertySelect = document.getElementById('form-property');
    const chosenSize = activeSelectedPlotSize || (data ? data.size : '');
    const chosenRate = data ? (data.rate || 'On Request') : '';

    if (data && messageField) {
      messageField.value = `I am interested in "${data.title}". Please send brochure, road map, and site visit schedule. Selected Plot Size: ${chosenSize} | Rate: ${chosenRate}.`;
    }
    if (data && propertySelect) {
      propertySelect.value = data.title;
    }

    // Scroll to contact form smoothly
    const contactSection = document.getElementById('enquiry');
    if (contactSection) {
      contactSection.scrollIntoView({ behavior: 'smooth' });
      setTimeout(() => {
        document.getElementById('form-name')?.focus();
      }, 500);
    }
  });
}

/* --------------------------------------------------------------------------
   3. ACCORDIONS (FAQ)
   -------------------------------------------------------------------------- */
function initAccordions() {
  const items = document.querySelectorAll('.accordion-item');

  items.forEach(item => {
    const header = item.querySelector('.accordion-header');
    header?.addEventListener('click', () => {
      const isActive = item.classList.contains('active');

      // Close all items for clean single-view accordion
      items.forEach(otherItem => {
        otherItem.classList.remove('active');
        otherItem.setAttribute('aria-expanded', 'false');
      });

      // Toggle clicked item
      if (!isActive) {
        item.classList.add('active');
        item.setAttribute('aria-expanded', 'true');
      }
    });
  });
}

/* --------------------------------------------------------------------------
   4. LEAD FORM & VALIDATION
   -------------------------------------------------------------------------- */
function initLeadForm() {
  const form = document.getElementById('lead-generation-form');
  const successModal = document.getElementById('success-modal');

  window.closeSuccessModal = function() {
    successModal?.classList.remove('active');
    document.body.style.overflow = '';
  };

  if (!form) return;

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    const name = document.getElementById('form-name')?.value.trim();
    const phone = document.getElementById('form-phone')?.value.trim();
    const email = document.getElementById('form-email')?.value.trim();
    const property = document.getElementById('form-property')?.value;
    const location = document.getElementById('form-location')?.value;
    const budget = document.getElementById('form-budget')?.value;
    const message = document.getElementById('form-message')?.value.trim();

    if (!name || !phone) {
      alert('Please provide your name and phone number so our team can reach you.');
      return;
    }

    const submitBtn = document.getElementById('form-submit-btn');
    const originalBtnText = submitBtn.innerHTML;
    submitBtn.disabled = true;
    submitBtn.innerHTML = `
      <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
      Processing Request...
    `;

    setTimeout(() => {
      submitBtn.disabled = false;
      submitBtn.innerHTML = originalBtnText;

      document.getElementById('success-client-name').textContent = name;
      document.getElementById('success-client-phone').textContent = phone;
      
      if (successModal) {
        successModal.classList.add('active');
        document.body.style.overflow = 'hidden';
      }

      const successWaBtn = document.getElementById('success-wa-btn');
      if (successWaBtn) {
        const rawWa = window.currentSiteData?.contact?.whatsapp || '7689932586';
        const waNum = formatWhatsAppUrlNumber(rawWa);
        const text = encodeURIComponent(
          `Hello Khoraniya Prime Properties, I just submitted an inquiry on your website.\n\nName: ${name}\nPhone: ${phone}\nInterest: ${property || 'Commercial Opportunity'}\nBudget: ${budget || 'Flexible'}\nLocation: ${location || 'Jaipur'}`
        );
        successWaBtn.href = `https://wa.me/${waNum}?text=${text}`;
      }

      form.reset();
    }, 650);
  });
}

/* --------------------------------------------------------------------------
   5. MOBILE STICKY BOTTOM DOCK
   -------------------------------------------------------------------------- */
function initMobileActionBar() {
  const bar = document.querySelector('.mobile-sticky-bar');
  const enquirySection = document.getElementById('enquiry');
  const footer = document.querySelector('footer');

  if (!bar) return;

  const observer = new IntersectionObserver((entries) => {
    const isOverlapping = entries.some(entry => entry.isIntersecting);
    if (isOverlapping) {
      bar.classList.add('hidden-by-scroll');
    } else {
      bar.classList.remove('hidden-by-scroll');
    }
  }, { threshold: 0.1 });

  if (enquirySection) observer.observe(enquirySection);
  if (footer) observer.observe(footer);
}

// WhatsApp Helper
window.openWhatsApp = function(customMsg) {
  const rawWa = window.currentSiteData?.contact?.whatsapp || '7689932586';
  const waNum = formatWhatsAppUrlNumber(rawWa);
  const defaultMsg = "Hello Khoraniya Prime Properties, I would like to enquire about commercial plots and investment opportunities in Jaipur.";
  const text = encodeURIComponent(customMsg || defaultMsg);
  window.open(`https://wa.me/${waNum}?text=${text}`, '_blank');
};
