-- ═══════════════════════════════════════════════════
-- URBAN WHEELS — SUPABASE DATABASE SETUP
-- Run this in your Supabase SQL Editor
-- ═══════════════════════════════════════════════════

-- 1. Create the cars table
CREATE TABLE IF NOT EXISTS cars (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL,
  make          TEXT,
  model         TEXT,
  year          INTEGER,
  price         NUMERIC(12, 2),
  mileage       INTEGER,
  transmission  TEXT,        -- 'Automatic' | 'Manual' | 'CVT' | 'Semi-Auto'
  fuel_type     TEXT,        -- 'Petrol' | 'Diesel' | 'Hybrid' | 'Electric'
  body_type     TEXT,        -- 'SUV' | 'Sedan' | 'Hatchback' | 'Coupe' | 'Pickup' | 'Wagon' | 'Convertible' | 'Van'
  color         TEXT,
  engine        TEXT,
  image_url     TEXT,
  description   TEXT,
  status        TEXT DEFAULT 'available',  -- 'available' | 'sold' | 'reserved'
  featured      BOOLEAN DEFAULT FALSE,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE cars ENABLE ROW LEVEL SECURITY;

-- 3. Public read policy (anyone can view cars)
CREATE POLICY "Public can read cars"
  ON cars FOR SELECT
  USING (true);

-- 4. Authenticated write policy (only logged-in admin can insert/update/delete)
CREATE POLICY "Authenticated users can insert cars"
  ON cars FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update cars"
  ON cars FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete cars"
  ON cars FOR DELETE
  TO authenticated
  USING (true);

-- 5. Auto-update `updated_at` trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON cars
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 6. Sample seed data
INSERT INTO cars (name, make, model, year, price, mileage, transmission, fuel_type, body_type, color, engine, image_url, description, status, featured) VALUES
(
  'BMW 5 Series', 'BMW', '520d', 2021, 45000, 32000, 'Automatic', 'Petrol', 'Sedan', 'Black', '3.0L Inline-6',
  'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800&q=80',
  'Immaculate BMW 5 Series with full service history. Twin-turbo inline-six engine delivering effortless power. Loaded with executive package including panoramic sunroof, heated seats, and Harman Kardon audio system.',
  'available', TRUE
),
(
  'Mercedes GLE 450', 'Mercedes', 'GLE 450', 2022, 68000, 18000, 'Automatic', 'Petrol', 'SUV', 'Silver', '3.0L V6',
  'https://images.unsplash.com/photo-1617788138017-80ad40651399?w=800&q=80',
  'Commanding presence with the refined luxury only Mercedes-Benz delivers. AMG Line exterior, MBUX infotainment, adaptive suspension, and 4MATIC all-wheel drive for any terrain.',
  'available', TRUE
),
(
  'Porsche Cayenne', 'Porsche', 'Cayenne', 2023, 92000, 8000, 'Automatic', 'Petrol', 'SUV', 'White', '3.0L V6',
  'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800&q=80',
  'The benchmark of performance SUVs. PASM air suspension, sport chrono package, Bose surround sound, and panoramic fixed glass roof. Less than 8,000km — practically new.',
  'available', TRUE
),
(
  'Toyota Land Cruiser', 'Toyota', 'Land Cruiser 200', 2021, 78000, 45000, 'Automatic', 'Diesel', 'SUV', 'Grey', '4.5L V8 Diesel',
  'https://images.unsplash.com/photo-1549317661-bd32c8ce0729?w=800&q=80',
  'The legendary Land Cruiser 200 Series. Multi-terrain select, crawl control, and Kinetic Dynamic Suspension System. Built for Zimbabwe''s diverse terrain, refined enough for the city.',
  'available', FALSE
),
(
  'Audi Q7', 'Audi', 'Q7', 2020, 55000, 52000, 'Automatic', 'Petrol', 'SUV', 'Navy Blue', '3.0L V6 TFSI',
  'https://images.unsplash.com/photo-1606016159991-dfe4f2746ad5?w=800&q=80',
  'Seven-seat luxury with quattro all-wheel drive. Virtual cockpit, MMI touch response, and matrix LED headlights. A rational decision with an irrational amount of style.',
  'available', FALSE
),
(
  'Ford Ranger Raptor', 'Ford', 'Ranger Raptor', 2022, 52000, 28000, 'Automatic', 'Diesel', 'Pickup', 'Orange', '2.0L Bi-Turbo Diesel',
  'https://images.unsplash.com/photo-1558981408-db0ecd8a1ee4?w=800&q=80',
  'The most capable pickup truck in its class. Fox Racing suspension, terrain management system, and roll-over protection. Performance that rewrites the rulebook.',
  'available', FALSE
);
