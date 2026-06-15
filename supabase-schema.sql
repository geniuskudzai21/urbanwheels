
-- 1. Create cars table
CREATE TABLE IF NOT EXISTS cars (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL,
  model         TEXT,
  year          INTEGER,
  mileage       INTEGER,
  price         NUMERIC(12, 2),
  inspection    TEXT DEFAULT 'with inspection',  -- 'with inspection' | 'without inspection'
  fuel_type     TEXT DEFAULT 'Petrol',           -- Petrol | Diesel | Electric | Hybrid
  engine        TEXT,                            -- e.g. "3.0L V6", "2.0L Turbo"
  transmission  TEXT,                            -- Automatic | Manual | CVT | Semi-Auto
  description   TEXT,        -- Contains all vehicle details: body_type, color, etc.
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

-- 6. Add columns if upgrading existing table
ALTER TABLE cars ADD COLUMN IF NOT EXISTS image_url TEXT;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS fuel_type TEXT DEFAULT 'Petrol';
ALTER TABLE cars ADD COLUMN IF NOT EXISTS engine TEXT;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS transmission TEXT;

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

