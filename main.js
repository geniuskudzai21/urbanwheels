
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

