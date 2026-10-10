import fs from 'node:fs';

const url = process.env.SUPABASE_URL || '';
const anonKey = process.env.SUPABASE_ANON_KEY || '';

const config = `window.SUPABASE_CONFIG = ${JSON.stringify({ url, anonKey })};\n`;
fs.writeFileSync('supabase-config.js', config, 'utf8');

if (!url || !anonKey) {
  console.warn('SUPABASE_URL/SUPABASE_ANON_KEY ausentes; o app será servido sem conexão com o Supabase.');
}
