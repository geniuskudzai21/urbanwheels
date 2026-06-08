const fs = require('fs');
const path = require('path');

const templatePath = path.join(__dirname, '..', 'js', 'supabase-config.template.js');
const outputPath = path.join(__dirname, '..', 'js', 'supabase-config.js');

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

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('ERROR: SUPABASE_URL and SUPABASE_ANON_KEY environment variables must be set.');
  process.exit(1);
}

let template = fs.readFileSync(templatePath, 'utf8');
template = template.replace(/__SUPABASE_URL__/g, supabaseUrl);
template = template.replace(/__SUPABASE_ANON_KEY__/g, supabaseAnonKey);
fs.writeFileSync(outputPath, template);

console.log('✓ supabase-config.js generated from template');
