# 5-10 user stories
1. As a user, I want to add activities to a session so I can track relevant metrics (e.g. weight lifted)
    - User Story
        - As a weight-lifter,
        - I want to add activities to a gym session
        - so that I can plan and track my activities.
    - Acceptance Criteria (Happy)
        - Given I am a weight-lifter
        - And I am on the dashboard for a session
        - When I enter the option to add an activity to a session
        - And I type valid weights and reps
        - Then I should be able to save my activity to my session.
    - Acceptance Criteria (Sad)
        - Given I am a weight-lifter
        - And I am on the dashboard for a session
        - When I enter the option to add an activity to a session
        - And I type invalid weights and reps (e.g. non-numerical values)
        - Then I should get an error message and be unable to save my activity.

2. As a user, I want to add sessions to a tracker so I can keep track of all my workouts.
    - User Story
        - As a weight-lifter,
        - I want to add sessions to my tracker app
        - so that I can plan and track my workout sessions.
    - Acceptance Criteria (Happy)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to add a session
        - And I type a valid name
        - Then I should be able to start a new session.
    - Acceptance Criteria (Sad)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to add a session
        - And I do not assign the session a name
        - Then I should get an error message and be unable to start a new session.

3. Personal Record
    - User Story
        - As a weight-lifter,
        - I want to obtain my personal record 
        - so that I can keep track of my record.
    - Acceptance Criteria (Happy)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option for personal records
        - And I enter an option to view an existing record
        - Then I should see my personal record and its corresponding date.
    - Acceptance Criteria (Sad)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option for personal record
        - And I enter an invalid option (e.g. non-existing record)
        - Then I should get a message saying that it's not a valid option.

4. As a user, I want to set goals so that I can remind myself of my targets.
    - User Story
        - As a weight-lifter,
        - I want to set goals 
        - so that I can stay on track on what targets I want to hit.
    - Acceptance Criteria (Happy)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to add a goal
        - And I type a valid name, activity, metrics, and target date
        - Then I should be able to add a new goal.
    - Acceptance Criteria (Sad)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to add a goal
        - And I type a past date or an invalid name, activity, or metrics to the goal
        - Then I should get an error message and be unable to create a new goal.

5. As a user, I want to obtain a summary report so that I can have a high-level overview of my past workouts.
    - User Story
        - As a weight-lifter,
        - I want to create summary reports of my sessions 
        - so that I can get a high-level overview of my workouts.
    - Acceptance Criteria (Happy)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to create a summary report
        - And I choose a date range with an existing history of sessions and activities
        - Then I should be able to create a summary report.
    - Acceptance Criteria (Sad)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to create a summary report
        - And I choose a date range with no existing history of sessions or activities
        - Then I should get an error message and be unable to create a summary report.