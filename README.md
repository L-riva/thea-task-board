# Thea Task Board

A shared to-do list with a rolling 7-week Gantt view (1 week back, 6 weeks forward). One static page, hosted on GitHub Pages, with tasks stored in a Supabase database behind an email login.

Files:

1. `index.html` – the whole app (login screen, task list, Gantt, editor).
2. `config.js` – your Supabase project URL and anon key. The only file you edit.
3. `supabase/schema.sql` – creates the `tasks` table and the access rules. Run once.

## Setup (about 45 minutes, once)

### A. Supabase (the database and the logins)

1. Go to supabase.com, sign in with GitHub, click **New project**. Name it `thea-task-board`, pick a strong database password (you won't need it day to day) and a region near you. Wait for it to finish provisioning.
2. **SQL Editor → New query**. Paste the whole of `supabase/schema.sql`, click **Run**. It should say "Success".
3. **Authentication → Providers → Email**: keep Email enabled, turn **off** "Allow new users to sign up". This closes the door to anyone you didn't invite. Leave "Confirm email" on.
4. **Authentication → URL Configuration**: set **Site URL** to your GitHub Pages address (you'll get it in step B4, e.g. `https://<your-github-user>.github.io/thea-task-board/`). Add the same address under **Redirect URLs**. Invite and password-reset emails send people here.
5. **Project Settings → API** (called "Data API" or "API Keys" in newer dashboards): copy the **Project URL** and the **anon public** key (on newer projects it's called the *publishable* key and starts with `sb_publishable_`). Paste both into `config.js`.

### B. GitHub (hosting the page)

1. Create a repository, e.g. `thea-task-board`. Public is fine: the code has no secrets, and the anon key is designed to be public. Private also works if your GitHub plan allows Pages on private repos.
2. Upload `index.html`, `config.js` (with your values filled in), `README.md` and the `supabase/` folder. Commit.
3. **Settings → Pages → Build and deployment**: Source "Deploy from a branch", branch `main`, folder `/ (root)`. Save.
4. After a minute the page shows your address: `https://<your-github-user>.github.io/thea-task-board/`. Put that address in Supabase step A4 if you haven't yet.

### C. Invite the team

1. Supabase → **Authentication → Users → Add user → Invite user**. Enter the teammate's email.
2. They get an email with a link. The link opens the board and asks them to set a password. From then on they sign in with email and password.
3. To remove someone: **Authentication → Users → delete the user**. They can no longer read or write anything.
4. Invite yourself the same way, or use **Add user → Create new user** with a password you choose.

## Day to day

1. Open the page, sign in. Everyone sees the same list; changes from teammates appear within a few seconds.
2. **+ Add task** opens the editor: title, type, owner, status, start, due, notes. Enter saves, Esc cancels. The type list (Sales, Client, Product, …) lives in `config.js`; edit it there.
8. **Group by** (toolbar) switches the board to sections per type or per owner, each with its open count; click a section header to collapse it. Type chips filter the board the same way owner chips do.
3. Click any task (its row or its bar) to edit it. **Delete** asks once to confirm.
4. Tick the checkbox to mark a task done; untick to reopen it.
5. The Gantt always shows 1 week back to 6 weeks ahead from today and moves on its own. Tasks outside the window stay in the list with a "starts 8 Dec →" or "← ended 12 Sep" marker.
6. Filters (owner chips, "Hide done") are per person and remembered on that browser only.
7. **Password** in the toolbar changes your password. **Forgot password** on the sign-in screen emails a reset link.

## Things to know

1. **Confidentiality.** The page URL is public, but it only ever shows a sign-in screen. The database refuses every read and write that doesn't carry a valid login, enforced server-side by row-level security, not by the page.
2. **Free tier.** Supabase pauses free projects after about a week with no activity; the dashboard restores them with one click. GitHub Pages is free.
3. **Invite emails.** Supabase's built-in email sender is rate-limited (a few messages per hour). Fine for a small team; if you ever invite many people at once, spread it out.
4. **Backups.** Table Editor → `tasks` → Export as CSV whenever you want a copy.
5. **Changing the design or the rules.** Everything is in `index.html`; edit, commit, and Pages redeploys in a minute.
