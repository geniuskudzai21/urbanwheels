
// Format currency
function formatPrice(price) {
  return '$' + Number(price || 0).toLocaleString();
}

// Format number with commas
function formatNumber(n) {
  return Number(n || 0).toLocaleString();
}

// Get query param
function getParam(name) {
  const url = new URLSearchParams(window.location.search);
  return url.get(name);
}

// Demo/fallback cars data
function getAllDemoCars() {
  return [
    { id: 1, name: 'BMW 5 Series', make: 'BMW', model: '5 Series', price: 45000, year: 2021, mileage: 32000, transmission: 'Automatic', fuel_type: 'Petrol', body_type: 'Sedan', color: 'Black', engine: '3.0L Inline-6', featured: true, status: 'available', inspection: 'with inspection', description: 'Immaculate BMW 5 Series with full service history. Twin-turbo inline-six engine delivering effortless power. Loaded with executive package including panoramic sunroof, heated seats, and Harman Kardon audio system.', image_url: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800&q=80' },
    { id: 2, name: 'Mercedes GLE 450', make: 'Mercedes', model: 'GLE 450', price: 68000, year: 2022, mileage: 18000, transmission: 'Automatic', fuel_type: 'Petrol', body_type: 'SUV', color: 'Silver', engine: '3.0L V6', featured: true, status: 'available', inspection: 'with inspection', description: 'Commanding presence with the refined luxury only Mercedes-Benz delivers. AMG Line exterior, MBUX infotainment, adaptive suspension, and 4MATIC all-wheel drive for any terrain.', image_url: 'https://images.unsplash.com/photo-1617788138017-80ad40651399?w=800&q=80' },
    { id: 3, name: 'Porsche Cayenne', make: 'Porsche', model: 'Cayenne', price: 92000, year: 2023, mileage: 8000, transmission: 'Automatic', fuel_type: 'Petrol', body_type: 'SUV', color: 'White', engine: '3.0L V6', featured: true, status: 'available', inspection: 'without inspection', description: 'The benchmark of performance SUVs. PASM air suspension, sport chrono package, Bose surround sound, and panoramic fixed glass roof. Less than 8,000km — practically new.', image_url: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800&q=80' },
    { id: 4, name: 'Toyota Land Cruiser', make: 'Toyota', model: 'Land Cruiser', price: 78000, year: 2021, mileage: 45000, transmission: 'Automatic', fuel_type: 'Diesel', body_type: 'SUV', color: 'Grey', engine: '4.5L V8 Diesel', featured: false, status: 'available', inspection: 'with inspection', description: 'The legendary Land Cruiser 200 Series. Multi-terrain select, crawl control, and Kinetic Dynamic Suspension System. Built for Zimbabwe\'s diverse terrain, refined enough for the city.', image_url: 'https://images.unsplash.com/photo-1549317661-bd32c8ce0729?w=800&q=80' },
    { id: 5, name: 'Audi Q7', make: 'Audi', model: 'Q7', price: 55000, year: 2020, mileage: 52000, transmission: 'Automatic', fuel_type: 'Petrol', body_type: 'SUV', color: 'Navy Blue', engine: '3.0L V6 TFSI', featured: false, status: 'available', inspection: 'with inspection', description: 'Seven-seat luxury with quattro all-wheel drive. Virtual cockpit, MMI touch response, and matrix LED headlights. A rational decision with an irrational amount of style.', image_url: 'https://images.unsplash.com/photo-1606016159991-dfe4f2746ad5?w=800&q=80' },
    { id: 6, name: 'Ford Ranger Raptor', make: 'Ford', model: 'Ranger Raptor', price: 52000, year: 2022, mileage: 28000, transmission: 'Automatic', fuel_type: 'Diesel', body_type: 'Pickup', color: 'Orange', engine: '2.0L Bi-Turbo Diesel', featured: false, status: 'available', inspection: 'with inspection', description: 'The most capable pickup truck in its class. Fox Racing suspension, terrain management system, and roll-over protection. Performance that rewrites the rulebook.', image_url: 'https://images.unsplash.com/photo-1558981408-db0ecd8a1ee4?w=800&q=80' },
  ];
}
