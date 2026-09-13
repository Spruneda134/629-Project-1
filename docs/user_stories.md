#### 5-10 user stories
1. As a user, I want to add activities to a session so I can track relevant metrics (e.g. weight lifted)
    - User Story
        - As a weight-lifter,
        - I want to add activities to a gym session
        - so that I can plan and track my activities.
    - Acceptance Criteria (Happy)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to add a session
        - And I type valid weights and reps
        - Then I should be able to save my session.
    - Acceptance Criteria (Sad)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option to add a session
        - And I type invalid weights and reps (e.g. non-numerical values)
        - Then I should get an error message and unable to save my session.

2. As a user, I want to add sessions to a tracker so I can keep track of all my workouts.
3. Personal Record
    - User Story
        - As a weight-lifter,
        - I want to obtain my personal record 
        - so that I can keep track of my record.
    - Acceptance Criteria (Happy)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option for personal record
        - And I enter a valid option
        - Then I should see my personal record and its corresponding date.
    - Acceptance Criteria (Sad)
        - Given I am a weight-lifter
        - And I am on the main dashboard
        - When I enter the option for personal record
        - And I enter an invalid option
        - Then I should get a message saying that it's not a valid option.

4. As a user, I want to set goals so that I can remind myself of my targets.
5. As a user, I want to obtain a summary report so that I can have a high-level overview of my past workouts.