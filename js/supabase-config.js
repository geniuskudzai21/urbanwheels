
// Supabase Configuration
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';

// Initialize Supabase client
const { createClient } = window.supabase;
window.supabaseClient = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Export for use in other scripts
window.SupabaseConfig = {
  url: SUPABASE_URL,
  anonKey: SUPABASE_ANON_KEY,
  client: window.supabaseClient
};
