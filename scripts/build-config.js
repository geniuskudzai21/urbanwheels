const fs = require('fs');
const path = require('path');

// Load .env file if present
const envPath = path.join(__dirname, '..', '.env');
if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf8');
  envContent.split('\n').forEach(line => {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith('#')) {
      const eqIdx = trimmed.indexOf('=');
      if (eqIdx > 0) {
        const key = trimmed.slice(0, eqIdx).trim();
        const val = trimmed.slice(eqIdx + 1).trim();
        if (!process.env[key]) process.env[key] = val;
      }
    }
  });
}

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY;
const adminEmail = process.env.ADMIN_EMAIL;
const adminPassword = process.env.ADMIN_PASSWORD;

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('ERROR: SUPABASE_URL and SUPABASE_ANON_KEY must be set.');
  process.exit(1);
}

// Generate supabase-config.js
let supabaseTemplate = fs.readFileSync(
  path.join(__dirname, '..', 'js', 'supabase-config.template.js'), 'utf8'
);
supabaseTemplate = supabaseTemplate
  .replace(/__SUPABASE_URL__/g, supabaseUrl)
  .replace(/__SUPABASE_ANON_KEY__/g, supabaseAnonKey);
fs.writeFileSync(path.join(__dirname, '..', 'js', 'supabase-config.js'), supabaseTemplate);
console.log('✓ supabase-config.js generated');

// Generate admin-config.js (only if ADMIN vars are set)
if (adminEmail && adminPassword) {
  let adminTemplate = fs.readFileSync(
    path.join(__dirname, '..', 'js', 'admin-config.template.js'), 'utf8'
  );
  adminTemplate = adminTemplate
    .replace(/__ADMIN_EMAIL__/g, adminEmail)
    .replace(/__ADMIN_PASSWORD__/g, adminPassword);
  fs.writeFileSync(path.join(__dirname, '..', 'js', 'admin-config.js'), adminTemplate);
  console.log('✓ admin-config.js generated');
} else {
  console.warn('⚠ ADMIN_EMAIL/ADMIN_PASSWORD not set — skipping admin-config.js');
}
