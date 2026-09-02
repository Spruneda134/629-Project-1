### App name
Exercise Tracker

### App description
Exercise Tracker allows the user to track progress in any exercises like weight lifting, running, or basketball.

### Intended user
People interested in going to the gym and being able to keep track of their growth in their favorite exercises and analyze their workouts. 

### Core features (4-5)
1. Add activities to a sessions with relevant metrics (e.g. weight lifted)
2. Add sessions to a tracker.
3. Obtain a personal record in an activity.
4. Set goals.
5. Obtain a summary report (statistics grouped by activities).

### Stretch features
1. Visualize time series graph to track metrics
2. Attach a photo to a session (for aesthetic progress or nostalgia).

### Main classes/modules
- CategoryTracker
    - Tracks list of sessions where each session contains activities which contain metrics you want to track.
    - Example Usage
        - BasketballTracker = CategoryTracker()
        - BasketballTracker.add(Session())
- Sessions
    - Each session includes multiple activities.
- Activity
    - Each activity includes relevant metrics (user defined).

### Test cases
- Create a session to the tracker
    - Start with an empty tracker, create a session for the day, expect the tracker to create an empty session.
- Add activities to a session with relevant metrics (e.g. weight lifted)
    - Start with an empty session, create an activity with user defined metrics, verify that metric is equivalent to the accessed value, and expect the session to create an activity.
- Obtain a personal record in an activity.
    - Look through activities containing a certain keyword, check for that existing activity, and the activity with the highest/best metrics will be returned.
    - If Empty: Look through activities containing a certain keyword, expect a message saying no data is available to pop-up.
- Set goals.
    - Set a goal, retrieve the goal list, expect your goals to be marked as either complete or in progress.
- Check goals
    - Search activities, retrieve the goal list and check status. (Complete or In Progress)
    - If Empty: Search activities, retrieve the goal list and check status, expect a message saying no data is available to pop-up.
- Obtain a summary report (statistics grouped by activities).
    - Verify that each statistic (min, mean, max, count) is correct.
    - If Empty: Request a report when no sessions/activities exist, expect a message saying no data is available to pop-up.


### How the team will collaborate on work (individual vs. pair programming)
- individual
    - Eugene: user story 1 and 3
    - Sal: user story 2 and 4
- Pair programming
    - user story 5
### What “done” means for the project and for individual features/stories
- Project - User is able to create a tracker and add sessions composed of activities.
- User story 1 - User is able to add activities to a session in order to track relevant metrics (e.g. weight lifted)
- User story 2 - User is able to add sessions to a tracker in order to keep track of all workouts.
- User story 3 - User is able to obtain a personal record in order to keep track of record and growth.
- User story 4 - User is able to set goals in order to remind his/her targets.
- User story 5 - User is able to obtain a summary report containing high-level overview of his/her past workouts.