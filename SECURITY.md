# Security Guidelines

## Firebase Configuration

### ⚠️ CRITICAL: Never Commit Sensitive Files

The following files contain sensitive credentials and should NEVER be committed to version control:

- `.env` and `.env.local` files
- `google-services.json` (Android)
- `GoogleService-Info.plist` (iOS)
- `firebase_config.json`
- Any files containing API keys, tokens, or credentials

### Setup Instructions

1. **For Mobile Development (iOS/Android)**
   - Download `google-services.json` from Firebase Console and place in `android/app/`
   - Download `GoogleService-Info.plist` from Firebase Console and place in `ios/Runner/`
   - These files are automatically loaded by Flutter/Firebase plugins

2. **For Web Development**
   - Configure Firebase in the web/index.html or use environment variables
   - Use `.env.local` for local development (never commit this)
   - Copy `.env.example` to `.env.local` and fill in your actual credentials

3. **Environment Variables**
   - Copy `.env.example` to `.env.local`
   - Update with your actual Firebase project credentials
   - This file is gitignored and won't be committed

### If Credentials Have Been Exposed

**IMMEDIATE ACTIONS:**

1. Go to Firebase Console → Project Settings
2. Regenerate all API keys and credentials
3. Reset authentication tokens
4. Review and revoke any suspicious activity
5. Force push cleaned history (if needed):
   ```bash
   git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch lib/main.dart' --prune-empty -- --all
   git push origin --force --all
   ```

### Best Practices

✅ DO:
- Use `.gitignore` to exclude sensitive files
- Store credentials in environment variables
- Rotate credentials regularly
- Use Firebase Security Rules for database access
- Enable authentication and authorization properly

❌ DON'T:
- Hardcode API keys in source code
- Commit `.env` files or config files with credentials
- Share credentials in chat, email, or documentation
- Use the same credentials across environments
- Commit sensitive files accidentally

## Further Reading
- [Firebase Security Best Practices](https://firebase.google.com/docs/projects/learn-more/best-practices-for-firebase-security)
- [Flutter Security](https://flutter.dev/docs/testing/best-practices#security-testing)