# amulya.os

My portfolio, live at [amulyachidurala.me](https://amulyachidurala.me).

A one-screen desk: an always-open laptop, a CS case file, a record player, 2048 with a hands-free lock, a guestbook with a visitor log, and an archive, all opened from bookmarks along the bottom. Day mode is a spring meadow; night mode is a painted Gotham skyline.

## How it's built

- Plain HTML + [Preact](https://preactjs.com) and [htm](https://github.com/developit/htm), no build step. The library is vendored in `assets/vendor/` (htm 3.1.1 standalone), so the site has no CDN dependency.
- Hosted on GitHub Pages (`CNAME` points the custom domain).
- Backgrounds are in `assets/`. The old terminal-style site is kept at [`/v1/`](v1/).

## Turning on the shared guestbook + visit counter

Without keys, visits are counted in each visitor's own browser. To make them shared:

1. Create a free project at [supabase.com](https://supabase.com).
2. Open **SQL Editor**, paste `supabase-setup.sql`, and run it.
3. In **Project Settings → API**, copy the **Project URL** and the **anon public** key.
4. Paste them into `SUPABASE_URL` and `SUPABASE_ANON_KEY` near the top of the `<script>` in `index.html`.

The anon key is meant to be public; the SQL's row-level security only lets visitors add visits, sign, and read names and dates. Guestbook emails stay private to you (read them in Supabase's Table Editor).
