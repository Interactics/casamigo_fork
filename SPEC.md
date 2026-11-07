# Casamigo — specification and requirements

Source of truth: [mujahidmasood/casamigo](https://github.com/mujahidmasood/casamigo), branch `main`, commit `0f7c09ad` (“Record the Casamigo product discussion.”).

This file is the product spec. `project.md` is the session log that led here. The built app is the Flutter house book in `apps/mobile`. It reads `shared/seed.json`. Nothing in this spec assumes a server.

## 1. Problem

Listing sites end when a landlord has a tenant. The expensive moments come later, and years apart: a repair, a utility bill, a letter, the smoke-alarm check, the handover. By then the lease, the photos, and last year’s meters are in different places, or gone.

A tenant can do each step by hand once. It fails when four things have to stay one bundle: this lease’s caps, proof from the right day, this household’s own baseline, and a date that expires. The cost of a broken bundle is the deposit, a repair the tenant paid when the owner should have, or a bill accepted while it was still an estimate.

## 2. Product

Casamigo is the record both people keep for one rented home, from move-in to the day the keys go back.

- One house, two doors. The tenant and the landlord see the same papers, meters, and cases. The duty line changes with who is signed in.
- The lease sits in the background. Its small-repair cap overrides a generic legal default.
- A problem becomes a short decision: who pays, what to try first, when to tell the landlord, and whether a tradesperson is booked.
- A bill is read next to the meters and last year, and marked when it is still an estimate.

The name on screen is Casamigo. The Flutter package and the local folder stay `hearth`. The organization id is `com.innovpk`.

## 3. Who it is for

| Person | Pays? | Why they open it |
|---|---|---|
| Private landlord with a few apartments | Yes, for the record | Handover photos, repair caps, and “who pays” stay after the tenant leaves |
| Tenant in that home | No, invited in | The next answer is only useful if this contract and these photos are still here |
| Tradesperson (Handwerker, inspector, engineer) | Later, per lead | Only after one city has real cases. Not ads, and not in this version |

A tenant subscription for a quiet year is out of scope. A newcomer may pay once, in the first year in Germany, or because the landlord handed them the app. A share of money recovered from a wrong bill or a deposit is a later option, not this build.

## 4. Sample house

Used by every screen today. Numbers come from the seed, not from a parser.

| | |
|---|---|
| Home | Winterfeldtplatz 12, Berlin, 2 rooms |
| Moved in | 1 March 2025 |
| Tenant | Leon Keller |
| Landlord | Frau Adler |
| Small repair | €120 each |
| Yearly cap | €300, of which €40 is already spent |
| Tenant also | Fill drilled holes before the keys go back. Check the smoke alarm once a year. Air the rooms in winter. |
| Landlord | Building, pipes, heating. Damp from the structure. A fitting worn out in ordinary use. |

Demo sign-in is local. The phrase is shown on the login screen. It is not an account server.

## 5. Functional requirements

Status is against the Flutter app on `0f7c09ad`. “Seeded” means the behavior works on the sample house in memory. It is not saved when the app restarts, and it does not read a photo or a PDF.

### 5.1 Both people, one house

| ID | Requirement | Priority | Status |
|---|---|---|---|
| F1 | A person signs in as the tenant or the landlord. The house does not change. | Must | Seeded. Two doors, no server. |
| F2 | Each journey item says whose job it is: yours, the other person, or both. | Must | Seeded. |
| F3 | Home shows only the open items that belong to the signed-in person, up to three, plus the repair cap in that person’s words. | Must | Seeded. |
| F4 | Either person can sign out and return to the door. | Must | Seeded. |

### 5.2 The stay

| ID | Requirement | Priority | Status |
|---|---|---|---|
| F5 | The stay has three phases: arriving, living here, leaving. | Must | Seeded. |
| F6 | Leaving items can say when they start, such as three weeks before the keys go back. | Must | Seeded as text. No calendar reminder. |
| F7 | Checking an item marks it kept. Unchecking opens it again. | Must | Seeded, memory only. |
| F8 | Home shows the stay as moved in, now, and keys back. | Should | Seeded as a ribbon. No dates on the ribbon. |

### 5.3 Who pays

| ID | Requirement | Priority | Status |
|---|---|---|---|
| F9 | The lease sets a per-repair cap and a yearly cap, and how much of the year is already spent. | Must | Seeded at €120 / €300 / €40. |
| F10 | An uploaded lease replaces those numbers. The original file stays attached. | Must | Not built. Caps are in the seed. |
| F11 | A case says who pays: tenant, landlord, or it depends, and why. | Must | Seeded for damp, holes, a dripping tap, and a chirping alarm. |
| F12 | A case lists a short DIY sequence, and the condition that means the landlord must be told. | Must | Seeded. |
| F13 | Structural damp, pipes, and the heating system are the landlord’s. Drilled holes at handover, and the yearly smoke-alarm check, are the tenant’s. | Must | Written in the seed and on Home. |

### 5.4 Papers and bills

| ID | Requirement | Priority | Status |
|---|---|---|---|
| F14 | A house paper keeps the original, an English rendering, and a short summary. | Must | Seeded for the lease, the October electricity bill, and the house rules. |
| F15 | A bill is flagged when it is an estimate (Abschlag) or when nobody read the meter. | Must | Seeded as text on the October bill. No parser. |
| F16 | The bill is set next to the meter and last year. A mismatch is called out. | Must | Partial. The electricity meter note says the bill still assumes 2,800 kWh. No automatic compare. |
| F17 | A person can add a paper by photograph or file. | Should | Not built. |

### 5.5 Meters

| ID | Requirement | Priority | Status |
|---|---|---|---|
| F18 | Cold water, hot water, electricity, and heating each keep last year, this year, a unit, and a note. | Must | Seeded. |
| F19 | A person can replace this year’s reading. | Must | Seeded, memory only. The number is typed, not read from a photo. |
| F20 | A reading that is clearly above last year is described as running ahead. | Must | Seeded for heating (“about a fifth higher”). Not computed from a threshold. |
| F21 | A meter photo is stored with the date and compared with earlier bills. | Should | Not built. |

### 5.6 A fix, a photo, a visit

| ID | Requirement | Priority | Status |
|---|---|---|---|
| F22 | From a case, the person can keep a photo as proof. | Must | Seeded as a flag. The camera is not opened. |
| F23 | Before a visit, the app asks for a specific photo, such as the sink or the toilet, then offers a tip. | Should | Not built. |
| F24 | A case names a trade and the next open slot. Booking marks the visit as requested. | Must | Seeded for a plumber, a painter, and an electrician. No message is sent. |
| F25 | The tradesperson pays for the introduction. | Later | Not built. |

### 5.7 Shape of the app

| ID | Requirement | Priority | Status |
|---|---|---|---|
| F26 | Phone uses a bottom bar: Home, Stay, Papers, Fix, Meters. A wide window uses a side rail and can show a list and a detail together. | Must | Seeded. Wide means 840px and up. |
| F27 | The surface is a household notebook: paper, linen, ink, clay, moss. Headings Fraunces, body Nunito. Not a dashboard. | Must | Seeded. |
| F28 | Layout spacing follows the body type size. | Should | Seeded via `Em`. |

## 6. What this version is not

- No account server, no `services/api`, no `services/ai`.
- No chat thread, no deposit ledger, no rent payments, no insurance. Those belong to other sketches, not to this repository.
- No persistence. Toggles, typed readings, kept photos, and booked visits die when the process stops.
- No reminder on a date. “Three weeks before the keys go back” is a label.
- No monetization. Landlord subscription, lead fees, and a recovery share are decisions, not code.

## 7. Acceptance for the sample house

A build of `apps/mobile` meets this spec for the demo when all of the following are true.

1. Leon and Frau Adler open the same house through different doors.
2. Leon’s Home names the smoke alarm, the estimate bill, and the heating. Frau Adler’s Home names the building, the pipes, the heating, and Leon’s holes.
3. Stay can be checked off, and each row says whose job it is.
4. The lease paper shows a German original, an English rendering, and the €120 / €300 summary.
5. The October bill says it is an estimate and that the meter was not read.
6. The warm-tap case says Leon pays, gives two DIY steps, and can mark a photo and a visit.
7. The damp case says it depends on the cause.
8. Heating shows 820 against 680 last year. Changing the number on screen updates the reading until the app is closed.
9. Phone shows five destinations. A wide window shows the rail.

## 8. Next build, in order

1. Persist the house book on the device, so a check, a reading, a photo flag, and a booking survive a restart.
2. Let a lease file set the two caps, and keep the file.
3. Let a meter photo and a bill file update the reading and raise the estimate flag, instead of typing the seed.
4. Ask for the photo a visit needs, then store it on the case.
5. Only then: a real door for each person, and a lead that a tradesperson can accept.
