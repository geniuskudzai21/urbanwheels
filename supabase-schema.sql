
-- 1. Create cars table
CREATE TABLE IF NOT EXISTS cars (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL,
  model         TEXT,
  year          INTEGER,
  mileage       INTEGER,
  price         NUMERIC(12, 2),
  inspection    TEXT DEFAULT 'with inspection',  -- 'with inspection' | 'without inspection'
  description   TEXT,        -- Contains all vehicle details: transmission, fuel_type, body_type, color, engine, etc.
  image_url     TEXT,        -- URL or base64 data URI of the vehicle image
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE cars ENABLE ROW LEVEL SECURITY;

-- 3. Public read policy (anyone can view cars)
DROP POLICY IF EXISTS "Public can read cars" ON cars;
CREATE POLICY "Public can read cars"
  ON cars FOR SELECT
  USING (true);

-- 4. Public write policy (anyone can insert/update/delete)
-- Security is handled by the admin login page on the client side
DROP POLICY IF EXISTS "Authenticated users can insert cars" ON cars;
CREATE POLICY "Public can insert cars"
  ON cars FOR INSERT
  WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated users can update cars" ON cars;
CREATE POLICY "Public can update cars"
  ON cars FOR UPDATE
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated users can delete cars" ON cars;
CREATE POLICY "Public can delete cars"
  ON cars FOR DELETE
  USING (true);

-- 5. Auto-update `updated_at` trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_updated_at ON cars;
CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON cars
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 6. Sample seed data
-- Also add image_url column if upgrading existing table
ALTER TABLE cars ADD COLUMN IF NOT EXISTS image_url TEXT;

-- Create storage bucket for car image uploads
INSERT INTO storage.buckets (id, name, public) VALUES ('car-images', 'car-images', true)
ON CONFLICT (id) DO NOTHING;

-- Allow public read access to car images
DROP POLICY IF EXISTS "Public can view car images" ON storage.objects;
CREATE POLICY "Public can view car images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'car-images');

-- Allow public upload/delete car images (client-side admin gate handles security)
DROP POLICY IF EXISTS "Authenticated users can upload car images" ON storage.objects;
CREATE POLICY "Public can upload car images"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'car-images');

DROP POLICY IF EXISTS "Authenticated users can delete car images" ON storage.objects;
CREATE POLICY "Public can delete car images"
  ON storage.objects FOR DELETE
  USING (bucket_id = 'car-images');

INSERT INTO cars (name, model, year, mileage, price, inspection, description, image_url) VALUES
(
  'BMW 5 Series', '520d', 2021, 32000, 45000.00, 'with inspection',
  'Immaculate BMW 5 Series with full service history. Twin-turbo inline-six engine delivering effortless power. Loaded with executive package including panoramic sunroof, heated seats, and Harman Kardon audio system. Automatic transmission, Petrol engine, Sedan body type, Black color, 3.0L Inline-6 engine.',
  'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800&q=80'
),
(
  'Mercedes GLE 450', 'GLE 450', 2022, 18000, 68000.00, 'with inspection',
  'Commanding presence with the refined luxury only Mercedes-Benz delivers. AMG Line exterior, MBUX infotainment, adaptive suspension, and 4MATIC all-wheel drive for any terrain. Automatic transmission, Petrol engine, SUV body type, Silver color, 3.0L V6 engine.',
  'https://images.unsplash.com/photo-1617788138017-80ad40651399?w=800&q=80'
),
(
  'Porsche Cayenne', 'Cayenne', 2023, 8000, 92000.00, 'without inspection',
  'The benchmark of performance SUVs. PASM air suspension, sport chrono package, Bose surround sound, and panoramic fixed glass roof. Less than 8,000km — practically new. Automatic transmission, Petrol engine, SUV body type, White color, 3.0L V6 engine.',
  'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800&q=80'
),
(
  'Toyota Land Cruiser', 'Land Cruiser 200', 2021, 45000, 78000.00, 'with inspection',
  'The legendary Land Cruiser 200 Series. Multi-terrain select, crawl control, and Kinetic Dynamic Suspension System. Built for Zimbabwe''s diverse terrain, refined enough for the city. Automatic transmission, Diesel engine, SUV body type, Grey color, 4.5L V8 Diesel.',
  'https://images.unsplash.com/photo-1549317661-bd32c8ce0729?w=800&q=80'
),
(
  'Audi Q7', 'Q7', 2020, 52000, 55000.00, 'with inspection',
  'Seven-seat luxury with quattro all-wheel drive. Virtual cockpit, MMI touch response, and matrix LED headlights. A rational decision with an irrational amount of style. Automatic transmission, Petrol engine, SUV body type, Navy Blue color, 3.0L V6 TFSI.',
  'https://images.unsplash.com/photo-1606016159991-dfe4f2746ad5?w=800&q=80'
),
(
  'Ford Ranger Raptor', 'Ranger Raptor', 2022, 28000, 52000.00, 'with inspection',
  'The most capable pickup truck in its class. Fox Racing suspension, terrain management system, and roll-over protection. Performance that rewrites the rulebook. Automatic transmission, Diesel engine, Pickup body type, Orange color, 2.0L Bi-Turbo Diesel.',
  'https://images.unsplash.com/photo-1558981408-db0ecd8a1ee4?w=800&q=80'
);
