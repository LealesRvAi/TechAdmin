# Shop Work Orders: setup

## 1. Supabase (one time)
1. Open your project at supabase.com, then **SQL Editor > New query**.
2. Paste all of `schema.sql` and click **Run**. This creates the tables, locks them to signed-in users, and creates the private `job-photos` bucket.
3. **Authentication > Users > Add user**: enter your tech's email and a password. Tick "Auto Confirm User".
4. **Authentication > Sign In / Providers (or Settings)**: turn **off** "Allow new users to sign up" so nobody else can create an account.
5. Add your own account the same way.

## 2. GitHub Pages
1. Create a new GitHub repo (public is fine; there are no secrets in the code).
2. Upload `index.html` to the repo root.
3. **Settings > Pages > Build and deployment**: Source = "Deploy from a branch", Branch = `main`, folder `/ (root)`. Save.
4. After a minute your site is at `https://YOUR-USERNAME.github.io/REPO-NAME/`.

## 3. Using it
- Sign in, tap **New work order**, add tasks, then the tech sets status, types notes, and taps **Add photo** (opens the phone camera).
- Photos are shrunk to about 1600px before upload to stay inside the 1 GB free storage.
- "Look around in demo mode" on the sign-in screen shows sample data and saves nothing.

## Notes
- Every signed-in user can see and edit every work order. If you later want a read-only role or per-tech limits, that's a change to the SQL policies.
- Free Supabase projects pause after 7 days with no activity. If the page stops loading, click Restore in the Supabase dashboard.
- Free projects have no automatic backups. Don't treat this as your only copy of real records yet.
