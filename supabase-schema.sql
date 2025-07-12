-- Supabase Database Schema for Verify Registration System
-- Run these commands in your Supabase SQL Editor

-- 1. Job Seekers Table
CREATE TABLE job_seekers (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  username TEXT UNIQUE NOT NULL,
  first_name TEXT,
  surname TEXT,
  location TEXT,
  phone TEXT,
  professional_title TEXT,
  travel_distance TEXT,
  willing_to_relocate TEXT,
  years_experience TEXT,
  industry TEXT,
  subscription_tier TEXT CHECK (subscription_tier IN ('bronze', 'silver', 'gold')),
  selected_jobs TEXT[], -- Array of job types
  skills TEXT[], -- Array of skills
  reference_1_name TEXT,
  reference_1_phone TEXT,
  reference_2_name TEXT,
  reference_2_phone TEXT,
  verification_status TEXT DEFAULT 'pending' CHECK (verification_status IN ('pending', 'verified', 'rejected')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Employers Table
CREATE TABLE employers (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  position_title TEXT,
  phone TEXT,
  employer_type TEXT NOT NULL CHECK (employer_type IN ('business', 'individual')),
  company_name TEXT,
  company_website TEXT,
  industry TEXT,
  company_size TEXT,
  verification_status TEXT DEFAULT 'pending' CHECK (verification_status IN ('pending', 'verified', 'rejected')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Create indexes for better performance
CREATE INDEX idx_job_seekers_email ON job_seekers(email);
CREATE INDEX idx_job_seekers_username ON job_seekers(username);
CREATE INDEX idx_job_seekers_industry ON job_seekers(industry);
CREATE INDEX idx_job_seekers_verification ON job_seekers(verification_status);

CREATE INDEX idx_employers_email ON employers(email);
CREATE INDEX idx_employers_username ON employers(username);
CREATE INDEX idx_employers_type ON employers(employer_type);
CREATE INDEX idx_employers_verification ON employers(verification_status);

-- 4. Row Level Security Policies
ALTER TABLE job_seekers ENABLE ROW LEVEL SECURITY;
ALTER TABLE employers ENABLE ROW LEVEL SECURITY;

-- Job seekers can only read/update their own data
CREATE POLICY "Job seekers can view own data" ON job_seekers
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Job seekers can update own data" ON job_seekers
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Anyone can insert job seeker during registration" ON job_seekers
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Employers can only read/update their own data
CREATE POLICY "Employers can view own data" ON employers
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Employers can update own data" ON employers
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Anyone can insert employer during registration" ON employers
  FOR INSERT WITH CHECK (auth.uid() = id);

-- 5. Functions for updating timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- 6. Triggers for auto-updating timestamps
CREATE TRIGGER update_job_seekers_updated_at 
  BEFORE UPDATE ON job_seekers 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_employers_updated_at 
  BEFORE UPDATE ON employers 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 7. Storage buckets (Run these in the Supabase dashboard or via API)
-- You'll need to create these buckets in your Supabase Storage section:
-- - job-seeker-files (for resumes, certificates, police clearances)
-- - employer-files (for company logos)

-- 8. Storage policies (Optional - adjust based on your security needs)
-- These would be set up in the Storage section of your Supabase dashboard

/*
  SETUP INSTRUCTIONS:
  
  1. Go to your Supabase project dashboard
  2. Navigate to the SQL Editor
  3. Copy and paste this entire file
  4. Execute the SQL commands
  5. Go to Storage > Create Bucket and create:
     - job-seeker-files
     - employer-files
  6. Update the Supabase URL and anon key in register.html
  7. Test the registration forms
  
  ENVIRONMENT VARIABLES NEEDED:
  - SUPABASE_URL: Your project URL (found in Settings > API)
  - SUPABASE_ANON_KEY: Your anon/public key (found in Settings > API)
*/
