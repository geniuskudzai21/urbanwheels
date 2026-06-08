# 🚗 URBAN WHEELS — Setup Guide

A premium car dealership website built with HTML, Tailwind CSS, and Supabase.


## ⚡ Quick Start (5 minutes)

### Step 1 — Create a Supabase Project
1. Go to [supabase.com](https://supabase.com) → **New Project**
2. Choose a name (e.g. `urban-wheels`) and set a strong database password
3. Wait ~2 minutes for it to provision

### Step 2 — Run the Database Schema
1. In Supabase, go to **SQL Editor**
2. Open `supabase-schema.sql` from this folder
3. Paste the contents and click **Run**
4. This creates the `cars` table and RLS policies

### Step 3 — Add Your API Keys
1. In Supabase, go to **Settings → API**
2. Copy your **Project URL** and **anon public** key
3. Open `js/supabase-config.js` and replace:
   ```js
   const SUPABASE_URL = 'YOUR_SUPABASE_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```

### Step 4 — Set Up Admin Login
1. In Supabase, go to **Authentication → Users**
2. Click **Invite User** or **Add User**
3. Enter your admin email and password
4. Use these credentials to log into `admin.html`

### Step 5 — Open the Site
Open `index.html` in your browser — or deploy to any static host (Netlify, Vercel, GitHub Pages, Cloudflare Pages).

---

## 🗃️ Supabase Table: `cars`

| Column         | Type      | Description                                  |
|----------------|-----------|----------------------------------------------|
| `id`           | bigserial | Auto-incrementing primary key                |
| `name`         | text      | Full car name (e.g. "BMW 5 Series")          |
| `make`         | text      | Brand (e.g. "BMW")                           |
| `model`        | text      | Model variant (e.g. "520d")                  |
| `year`         | integer   | Model year                                   |
| `price`        | numeric   | Price in USD                                 |
| `mileage`      | integer   | Odometer reading in km                       |
| `transmission` | text      | Automatic / Manual / CVT / Semi-Auto         |
| `fuel_type`    | text      | Petrol / Diesel / Hybrid / Electric          |
| `body_type`    | text      | SUV / Sedan / Hatchback / Coupe / Pickup ... |
| `color`        | text      | Exterior colour                              |
| `engine`       | text      | Engine spec (e.g. "3.0L V6")                |
| `image_url`    | text      | Full URL to car image                        |
| `description`  | text      | Long-form vehicle description                |
| `status`       | text      | available / sold / reserved                  |
| `featured`     | boolean   | Show in homepage featured section            |
| `created_at`   | timestamptz | Auto-set on insert                         |
| `updated_at`   | timestamptz | Auto-updated on edit                       |

---

## 🎨 Design System

| Token       | Value     | Usage                        |
|-------------|-----------|------------------------------|
| `uw-black`  | `#0a0a0a` | Primary background           |
| `uw-white`  | `#f5f0eb` | Primary text / warm white    |
| `uw-red`    | `#e31515` | Accent, CTAs, highlights     |
| `uw-gray`   | `#1a1a1a` | Card backgrounds             |
| `uw-mid`    | `#2e2e2e` | Borders, dividers            |
| `uw-muted`  | `#7a7a7a` | Secondary text               |

**Fonts:**
- `Bebas Neue` — Display/headings
- `Barlow` — Body text
- `Space Mono` — Labels, tags, mono elements

---

## 🚀 Deployment (Free)

**Netlify (recommended):**
1. Drag the `urban-wheels/` folder to [netlify.com/drop](https://app.netlify.com/drop)
2. Done — live in seconds

**Vercel:**
1. Push to GitHub
2. Import repo at [vercel.com](https://vercel.com)

**GitHub Pages:**
1. Push to a repo
2. Settings → Pages → Deploy from branch `main`

---

## 📱 Pages Summary

| Page              | Features                                                  |
|-------------------|-----------------------------------------------------------|
| `index.html`      | Hero, ticker, featured cars from DB, stats, testimonials  |
| `inventory.html`  | Full grid, search bar, body type filters, sort dropdown   |
| `car-detail.html` | Full specs, enquiry form, WhatsApp/copy share             |
| `about.html`      | Mission, team, timeline, stats                            |
| `contact.html`    | Contact form, WhatsApp CTA, social links, trading hours   |
| `admin.html`      | Supabase login, dashboard stats, full CRUD for cars       |
