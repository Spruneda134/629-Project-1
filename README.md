# Exercise Tracker

## Description

Exercise Tracker is a command-line Ruby app for logging weight-lifting workouts and tracking progress over time. You record workout sessions, add activities (exercises) to them, and log sets with weight, reps and RPE. The app keeps track of your personal records, lets you set target-weight goals, and prints a per-activity report of your history. Your data is saved to disk between runs.

## Team Members

- Eugene
- Salvador Pruneda

## Requirements

- Ruby **4.0.6** (pinned in `.ruby-version` and the `Gemfile`)
- Bundler

## Installation / Setup

```bash
git clone https://github.com/Spruneda134/629-Project-1.git
cd 629-Project-1

# Install Ruby 4.0.6 if you don't have it (example using rbenv)
rbenv install 4.0.6

bundle install
```

Check that the right Ruby is active with `ruby -v`. If it prints a different version, Bundler will refuse to run with a `RubyVersionMismatch` error.

## Running the App

```bash
bundle exec ruby app.rb
```

From the main menu:

```
1. Add a Session
2. View/Edit Sessions
3. Open Goal Tracker
4. Open Personal Record Tracker
5. View Activity Report
0. Exit
```

- Choose options by typing their number and pressing Enter.
- Typing `exit` at any prompt saves and quits.
- Data is saved to `data/tracker.json` when you exit, and loaded again the next time you start the app.

## Running the Tests and Coverage Report

```bash
bundle exec rspec
```

This runs the unit and acceptance tests in `spec/`. Coverage is measured by SimpleCov automatically on every run. The HTML report is written to `coverage/index.html`; open it in a browser:

```bash
xdg-open coverage/index.html   # Linux
open coverage/index.html       # macOS
```

To check code style:

```bash
bundle exec rubocop
```

Both the test suite and RuboCop run in GitHub Actions on every push and pull request (`.github/workflows/ci.yml`).

## Main Features

- **Workout sessions:** create named, dated sessions. Leave the name blank to use the default "Workout".
- **Activities and sets:** add exercises to a session and log sets with weight (lbs), reps and an optional RPE (1–10).
- **Browse sessions:** a paged table of sessions (name and date, newest first) with numbered selection and previous/next page navigation.
- **Personal records:** your heaviest weight for each activity is updated automatically whenever you log a set.
- **Goals:** set a target weight for an activity. The goal is marked complete automatically when you log a set at or above the target. View completed and in-progress goals separately.
- **Activity report:** pick an activity to see its PR, the date it was set, days since the PR, and a table of every session with the heaviest weight lifted.
- **Persistent storage:** sessions, goals and records are saved as JSON.

## Project Structure

```
app.rb              # entry point
lib/
  interface.rb      # terminal menus and user input
  main.rb           # core tracker: sessions, goals, records, reports, save/load
  session.rb        # a workout session holding activities
  activity.rb       # an exercise holding sets
  workout_set.rb    # one set: weight, reps, RPE
  goal.rb           # target weight for an activity
  report.rb         # activity report formatting
  storage.rb        # JSON serialization
spec/               # RSpec unit and acceptance tests
docs/               # user stories, design, planning, backlog, pairing log, retrospective
```

See [docs/design.md](docs/design.md) for the architecture and design decisions.

## Known Limitations

- **Terminal only.** There is no graphical or web interface.
- **Case-sensitive names.** Personal records and reports use exact activity names, so "Squat" and "squat" are tracked separately.
- **Weights are recorded in lbs.** There is no unit conversion.
- **Only one data file.** Everything is stored in `data/tracker.json`
- **Data saves only on exit.** If the app is killed (e.g. with Ctrl+C) instead of exited normally, changes from that run are lost.
- **Adding only, no editing or deleting.** Sessions, activities and sets can be added but not renamed or removed through the menus.
- **No stretch features.** The planned time-series graphs and session photos were not implemented.

## Documentation

- [User stories](docs/user_stories.md)
- [Design](docs/design.md)
- [Planning](docs/planning.md)
- [Backlog](docs/backlog.md)
- [Pairing log](docs/pairing_log.md)
- [Retrospective](docs/retrospective.md)
