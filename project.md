# Casamigo

The stay, kept by both.

Casamigo is a two-sided tenancy companion for a German rental. Listing sites such as ImmoScout24 stop once a landlord has a tenant. This product starts then, and stays with both people from move-in through the stay to handover.

The local folder is `hearth`. The Flutter package is `hearth`, the organization is `com.innovpk`, and the name on screen is Casamigo.

Speech-to-text in the first conversation turned the German pair Mieter / Vermieter into “meter / thermometer.” The product is about the tenant and the landlord. Other corrections from that recording: ImmoScout24, Handwerker, Rechnung, Rauchmelder, and “spells” meaning prior bills.

## Prompts

These are the requests from the working session on 7 November 2026, in order.

1. Explain the idea: problem, solution, and who it is for. The spoken brief:

   An app for the relationship between tenant and landlord during the whole stay. ImmoScout finds someone for the home. This app looks after the home while they live there, for the landlord and for the tenant. In the first weeks, take care of the contracts. In the last three weeks before leaving, a checklist. During the stay, the duties that come up. Mold: who takes care of it, how it is documented, and what the law says about the obligation. Track the payments. If the tenant drills holes, those holes are filled when the apartment is given back. A newcomer journey for what to keep in mind. Keep the house clean. If something is wrong, who pays, tenant or landlord, and how much the tenant has to pay. The app keeps that limit in mind. Guide the tenant: a DIY fix, or a Handwerker. Each year the tenant checks the smoke alarm. A companion for both sides. Money from ads by inspectors, interiors, and engineers. The user photographs hot-water and cold-water meters, and the app estimates whether heating or water is running high against previous years. Upload a utility bill and see if the company is billing on an estimate, or if electricity or heating looks wrong compared with the meters. Book appointments with Handwerker. Before a maintenance visit, ask for a photo of the sink or the toilet, then give tips.

2. Also add utility-bill check tools, a photo of an issue that suggests DIY or a way to contact Handwerker, who pays, and a way to upload contracts and read the limits of what the tenant pays and what the owner pays.

3. Also translate house documents, for example contracts, and write compact summaries of the electricity bill and other house papers. Energy use: the user uploads pictures of meters, and usage is judged against previous bills.

4. Why would a tenant stay with us? Why would they not do this by hand?

5. Is it sellable?

6. Start building. Keep the UI cozy and warm, interesting, natural, not a generic AI look. Flutter, for iOS, Android, web, iPad, and tablets.

7. Suggest names first, ones that do not exist on iOS and Android, and a domain that can be found.

8. Give English names.

9. The name includes landlord and tenant both. Make it unique.

10. Start building. The name will change. Run separate agents for frontend, backend, and AI.

11. Start multitasking.

12. Meanwhile generate a logo. The project and the app are named Casamigo.

13. Run it.

14. Why is it pink? We need proper roles for tenant and landlord, and a login system.

15. What is the name of the folder you created? Is it local?

16. It is pretty basic. There is no launcher. The logo is stale.

17. Create a repo on GitHub, on the mujahidmasood account.

18. Put all the prompts and what we discussed into `project.md` and push it.

## What we decided

### The product

One guided stay, for both roles, with the lease in the background.

- Journey and checklists: move-in, the stay, the last weeks before move-out, and a newcomer path.
- Who pays: tenant, landlord, or it depends, and how much. The uploaded lease sets the Kleinreparatur caps. Those numbers override a generic legal default. The sample house uses €120 per small repair, €300 a year, with €40 already spent. The tenant fills drilled holes at handover. The yearly smoke-alarm check is the tenant’s. Structural damp, pipes, and the heating system are the landlord’s.
- A photo of an issue becomes DIY steps or a booked Handwerker. The photo stays as proof. The app can ask for a specific photo before a visit.
- House documents are translated and shortened: lease limits, bill period and amount, estimate versus a real reading, notices and what is due by when. The original stays attached.
- A utility bill is checked against meter photos and earlier years. Flag estimates (Abschlag), usage that does not match the meters, and odd lines.
- Meter photos for hot water, cold water, electricity, and heating, compared with previous bills, with a note when use is drifting up.
- Appointment booking with tradespeople.

### Why a tenant stays, and why a folder is not enough

The expensive moments are years apart: a repair, the annual utility statement, a letter, the smoke-alarm check, the handover. Between them the app is quiet. People come back because the next answer is only better if the contract, the photos, and the earlier bills are still there.

Doing each step by hand works once. It falls apart when four things have to stay one bundle: this lease’s caps, proof from the right day, the household’s own baseline, and a date that expires. The cost of a broken bundle is the deposit, a repair the tenant paid when the owner should have, or a bill accepted while it was still an estimate. Translation of a short message and a call to a known tradesperson stay outside the product. The reason to stay is the decision that depends on this contract, this meter history, and a date nobody will rebuild on the day they need it.

### Whether it sells

Someone pays when money or the deposit is at risk. A monthly fee for reminders and translation does not carry it.

- The landlord pays most reliably. A private landlord with a few apartments pays to keep handover photos, repair caps, and the “who pays” answer in one place. The tenant is invited in and uses it free. When the tenant moves, the landlord and the record stay.
- The tradesperson pays for the lead: inspectors, interiors, engineers, Handwerker. That only works once a city has real cases. Ads do not cover the product before that.
- The tenant pays in two narrow cases. New in Germany, first year: once, or because the landlord handed them the app. Or a share of money recovered from a wrong bill or deposit. Not a subscription in a quiet year.

Sell the bundle they cannot rebuild: this contract’s caps, the photos from the right day, and earlier bills next to today’s meter. Sell it first to private landlords, with tenants inside at no charge. Trades booking comes after one city has live repair cases. Sold as a tenant subscription for peace of mind, it is tried at move-in and dropped.

Neighbors, not name collisions: Mineko, Mieterverein, MyHammer, HausAkte, Tenvello, eigenheimverwalter, Herdzeit, Wohnly.

### Names

Registry checks that day (RDAP 404 means the name was unregistered then, not a trademark search):

- German, both `.com` and `.de` free: Wohnheft (the one recommended then), Daheimheft, Bleibeheft, Stubenheft, Leinenheft. Skip Schlüsselheft, which is already an iOS handover app. Daheim, Hausbuch, and Wohnstube were taken.
- English, for both sides, `.com` and `.de` free: Hearthpair (recommended then), Bothlease, Bothhearth, Twainstay, Twainlet. Skip Jointlease, which means two tenants in law, and Ourtenancy, which sits next to OurTenant. Bothsides and Twosides were taken.

The name chosen after that is Casamigo. The folder stayed `hearth`.

### How it should look

A household notebook: cozy, warm, natural. Not a dashboard and not a generic AI surface.

Paper `#F3EBE1`, linen `#FBF6EF`, ink `#2A241C`, clay `#8C4A32`, sand `#E4D2C2`, moss `#5E6B4A`. Headings in Fraunces, body in Nunito. The pink came from `ColorScheme.fromSeed` on the clay color. The theme is now an explicit scheme, and filled buttons are clay.

Phone uses a bottom bar. A wide window uses a side rail. Spacing follows the body type size. No absolute pixel layout.

The mark is two people under a clay roof. Launcher icons were generated for Android, iOS, and web from that icon. The wordmark sits in `brand/` and in the app assets.

Login is a local demo, not a server. Role comes from the account.

- Tenant: `leon@winterfeldt.de` / `stay` (Leon Keller)
- Landlord: `adler@winterfeldt.de` / `stay` (Frau Adler)

The sample house is Winterfeldtplatz 12, Berlin, two rooms, moved in 1 March 2025.

## What exists

- Flutter app in `apps/mobile` for iOS, Android, and web. Shared seed and brand files live in `shared/` and `brand/`.
- Offline house book: journey, papers, issues, meters, trades, and the two demo doors.
- Public repo: https://github.com/mujahidmasood/casamigo on `main`. The first commit is `e5a6386`, “Start Casamigo, the shared tenancy companion.” Push over SSH was refused because that key belongs to `builderbreakerapp-web`. The push that landed used HTTPS as `mujahidmasood`.

## What is not built

- `services/api` and `services/ai` were specified and never written. The app reads `assets/seed.json`. There is no account server, and the demo password is not real authentication.
- Monetization, ads, and live bill or photo analysis are product decisions, not code.
- A phone home-screen icon appears only after the app is installed. The web preview that served `http://127.0.0.1:7357` has stopped.
