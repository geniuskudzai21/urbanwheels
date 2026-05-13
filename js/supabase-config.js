
// Supabase Configuration
const SUPABASE_URL = 'https://jziljajfmvwiafctjjum.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6aWxqYWpmbXZ3aWFmY3RqanVtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg1MDU5MzksImV4cCI6MjA5NDA4MTkzOX0.a7Yfyu172DXaS_EgfqtezvHEvZ2ppyEp3-FihQgtfl0';

// Initialize Supabase client
const { createClient } = window.supabase;
window.supabaseClient = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Export for use in other scripts
window.SupabaseConfig = {
  url: SUPABASE_URL,
  anonKey: SUPABASE_ANON_KEY,
  client: window.supabaseClient
};
