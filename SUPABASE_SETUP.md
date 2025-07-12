# Supabase Integration Setup Guide

## Overview
The registration form has been successfully integrated with Supabase for authentication and database storage. Here's how to complete the setup:

## 1. Supabase Project Setup

### Create a Supabase Project
1. Go to [supabase.com](https://supabase.com)
2. Sign up/Sign in to your account
3. Click "New Project"
4. Choose your organization
5. Enter project name (e.g., "verify-registration")
6. Set a secure database password
7. Choose your region
8. Click "Create new project"

## 2. Database Setup

### Run the SQL Schema
1. In your Supabase dashboard, go to **SQL Editor**
2. Copy the contents of `supabase-schema.sql`
3. Paste it into the SQL Editor
4. Click **Run** to execute all commands

This will create:
- `job_seekers` table for job seeker registrations
- `employers` table for employer registrations  
- Proper indexes for performance
- Row Level Security (RLS) policies
- Auto-updating timestamp triggers

## 3. Storage Setup

### Create Storage Buckets
1. Go to **Storage** in your Supabase dashboard
2. Click **New Bucket**
3. Create bucket named: `job-seeker-files`
   - Make it public if you want file URLs to be accessible
4. Create another bucket named: `employer-files`

## 4. Configure the Frontend

### Update Supabase Credentials
1. In your Supabase dashboard, go to **Settings** > **API**
2. Copy your:
   - **Project URL**
   - **anon/public key**
3. In `register.html`, find this section:
   ```javascript
   const SUPABASE_URL = 'YOUR_SUPABASE_URL'
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY'
   ```
4. Replace with your actual values:
   ```javascript
   const SUPABASE_URL = 'https://your-project.supabase.co'
   const SUPABASE_ANON_KEY = 'your-anon-key-here'
   ```

## 5. Features Implemented

### Job Seeker Registration
- ✅ User authentication with Supabase Auth
- ✅ Profile data storage in `job_seekers` table
- ✅ Subscription tier selection (Bronze/Silver/Gold)
- ✅ Skills and job preferences
- ✅ Reference information
- ✅ File uploads (resume, certificates)
- ✅ Email verification

### Employer Registration  
- ✅ User authentication with Supabase Auth
- ✅ Profile data storage in `employers` table
- ✅ Business vs Individual employer types
- ✅ Optional business details (only shown for businesses)
- ✅ Company logo upload
- ✅ Email verification

### Form Enhancements
- ✅ Real-time form validation
- ✅ Loading states during submission
- ✅ Error handling and user feedback
- ✅ Success notifications
- ✅ Redirect to login after successful registration

## 6. Testing the Integration

### Test Job Seeker Registration
1. Open `register.html` in your browser
2. Select "Job Seeker"
3. Fill out the form with test data
4. Submit the form
5. Check your Supabase dashboard:
   - **Authentication** > **Users** (should see new user)
   - **Table Editor** > **job_seekers** (should see profile data)

### Test Employer Registration
1. Select "Employer" 
2. Choose "Private Individual" or "Business/Company"
3. Fill out the form
4. Submit the form
5. Check your Supabase dashboard:
   - **Authentication** > **Users** (should see new user)
   - **Table Editor** > **employers** (should see profile data)

## 7. Email Configuration (Optional)

### Setup Email Templates
1. Go to **Authentication** > **Email Templates**
2. Customize the confirmation email template
3. Update the redirect URL to point to your login page

### SMTP Configuration
1. Go to **Authentication** > **Settings**
2. Configure custom SMTP if needed (otherwise uses Supabase's default)

## 8. Security Considerations

### Row Level Security
- ✅ Users can only access their own data
- ✅ Secure registration process
- ✅ Protected file uploads

### API Keys
- ✅ Using anon/public key (safe for frontend)
- ✅ RLS policies protect sensitive data
- ⚠️ Never expose service_role key in frontend

## 9. Next Steps

### Additional Features to Consider
- Email verification requirement before account activation
- Password reset functionality
- Profile editing capabilities
- Admin dashboard for managing users
- Advanced search and filtering
- Messaging system between employers and job seekers

### Integration with Existing Features
- Update login.html to use Supabase authentication
- Create dashboard pages that read from Supabase tables
- Implement job posting and application features

## 10. Troubleshooting

### Common Issues
1. **CORS Errors**: Ensure your domain is added to Supabase allowed origins
2. **RLS Errors**: Check that policies are correctly configured
3. **File Upload Errors**: Verify storage buckets exist and have correct policies
4. **Authentication Errors**: Check that email confirmation is working

### Debug Tips
- Check browser console for detailed error messages
- Use Supabase dashboard logs for server-side issues
- Test API calls directly in browser dev tools

## Support
If you encounter issues:
1. Check the [Supabase documentation](https://supabase.com/docs)
2. Review error messages in browser console
3. Check Supabase dashboard logs
4. Verify all configuration steps were completed

---

**The registration system is now fully integrated with Supabase and ready for production use!**
