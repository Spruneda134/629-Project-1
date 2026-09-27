# Retrospective (2026-09-27)

## What went well

- **Tests caught regressions.** The RSpec suite let us change each other's code, and use AI-assisted edits, without breaking things we didn't notice. Several fixes came straight from failing specs (e.g. `fix: remove dependency on removed class Record`, `freeze clock in activity report spec`).
- **Feature branches and pull requests.** Almost every change went through a PR, so each of us reviewed the other's work and saw how it fit together.
- **Automated checks.** Adding RuboCop and a GitHub Actions workflow for linting and testing kept style issues from piling up. We finished with zero RuboCop offenses.
- **Separating logic from I/O.** `Main`, `Session`, `Activity`, `Report` and so on don't read input, so most features could be tested without driving the menus.
- **Pair programming on the activity report.** Writing the specs first and then swapping roles to implement them worked well, and both of us understand that feature.

## What was difficult

- **UI and user experience came late.** We thought mostly about the class structure and not enough about how someone would actually move through the app. The terminal interface was added near the end, and we then had to go back for things like numbered selection instead of typing names, paging through sessions, and a way back to the sessions list from deep menus.
- **Shared state in tests.** The storage specs save to the real `data/tracker.json`, so running the suite overwrote our own saved data. Tests should have used a temporary file from the start.
- **Keeping the design docs in sync.** `design.md`, the README and the backlog drifted from the code as classes were renamed or merged (e.g. `CategoryTracker` → `Main`, the `Record` class removed).
- **Environment setup.** Pinning Ruby 4.0.6 caused version-mismatch problems on machines where another Ruby came first on the `PATH`.
- **Uneven workload over time.** A lot of work (UI, storage, reports, linting) landed in the last few days instead of being spread out.

## What we would improve next time

- Focus on sketching the menu flows and screen mock-ups during planning, next to the class design, and walk through them as a user before writing code.
- Isolate tests from real data from the start (temp directories, injected save paths).
- Update the backlog, design doc and README as part of each PR instead of large amount at the end.
- Commit smaller pieces more steadily over the project instead of in bursts.
- Treat activity names as case-insensitive.

## Did the final app meet the original goal?

Mostly yes. The five core features from `planning.md` are implemented: sessions, activities with sets (weight, reps, RPE), personal records, goals that complete automatically, and per-activity summary reports. Data also persists between runs. The stretch goals (time-series graphs, photos attached to sessions) were not attempted. The app is weight-lifting focused, which is narrower than the planning doc's "running or basketball" examples.