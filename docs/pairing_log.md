# Pairing Log

## Session 1 — 2026-09-01

Driver: Eugene  
Navigator: Salvador

Work completed:
- Created the repo for the project
- Started planning out project and what our contributions will be 
- Added the first user stories

Notes:
- Look into more user stories that can be added.

## Session 2 — 2026-09-25 / 2026-09-26 (User Story 5: Activity Report)

Driver (tests): Salvador  
Navigator: Eugene

Then roles swapped:

Driver (implementation): Eugene  
Navigator: Salvador

Work completed:
- Talked through what the report should show: the personal record, when it was set, days since the PR, and one row per session with the heaviest weight lifted for that activity.
- Salvador drove while writing the report specs (`spec/report_spec.rb`), including a sad path for an activity with no record and a case for a PR that was added manually and has no session behind it.
- Swapped roles. Eugene drove and implemented `Report` and `Main#create_activity_report` / `Main#view_activity_report` until the specs passed.