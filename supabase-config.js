// Supabase Configuration
// This file contains your actual Supabase credentials and database schema

const SUPABASE_CONFIG = {
  url: 'https://dvbbvjlwmkqqyfqdbupg.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2YmJ2amx3bWtxcXlmcWRidXBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAzNjI0OTYsImV4cCI6MjA2NTkzODQ5Nn0.Zpkj5G3mTngZD2lMCo7Yr6PeyEJ3X6jHndHrvDgPylA'
};

// Database setup status:
// ✅ Supabase project created
// ✅ Credentials configured  
// ❓ Database tables - run the SQL below in your Supabase SQL Editor
// 
// Go to: https://supabase.com/dashboard/project/dvbbvjlwmkqqyfqdbupg/sql

/* 
DATABASE SCHEMA - Run this SQL in your Supabase SQL Editor:

-- Job Seekers Table
CREATE TABLE job_seekers (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
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
  subscription_tier TEXT,
  selected_jobs TEXT[], -- Array of job types
  skills TEXT[], -- Array of skills
  reference_1_name TEXT,
  reference_1_phone TEXT,
  reference_2_name TEXT,
  reference_2_phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Employers Table
CREATE TABLE employers (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  email TEXT NOT NULL,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  position_title TEXT,
  phone TEXT,
  employer_type TEXT, -- 'individual' or 'business'
  company_name TEXT,
  company_website TEXT,
  industry TEXT,
  company_size TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE job_seekers ENABLE ROW LEVEL SECURITY;
ALTER TABLE employers ENABLE ROW LEVEL SECURITY;

-- Create policies (basic - adjust as needed)
CREATE POLICY "Users can view own data" ON job_seekers
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can insert own data" ON job_seekers
  FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can view own data" ON employers
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can insert own data" ON employers
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Create storage buckets (run in SQL editor)
INSERT INTO storage.buckets (id, name, public) VALUES ('job-seeker-files', 'job-seeker-files', false);
INSERT INTO storage.buckets (id, name, public) VALUES ('employer-files', 'employer-files', false);
*/

export default SUPABASE_CONFIG;
