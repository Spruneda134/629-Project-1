# Class Design


## Class CategoryTracker
### Main controller

- self.name 			 
   (string)
- self.sessions 		 
   (int)

- def view_sessions()
   - view sessions under a Category

- def add_session()	
	- add a session to a category

- def view_records()
	- see personal records

- def view_goals()
	- see milestones set out

- def set_goal()
	- set goals/milestones

- def generate_report()
	- generate an analytical report of your sessions/activites
<br><br>


## Class Session
### Workout/Training Session

- self.name 			 
   (string)
- self.activities 		 
   (int)
- self.activities = []		 
   (list of activities)
- self.date 			 
   (date the session was created)

- def view_activities()
	- view activities under a session

- def add_activity()
	- add an activity to a session
<br><br>


## Class Activity			 
### Workout/Training Session

- self.name 			 
   (string)
- self.metrics 			 
   (Dictionary/Key-Value pairs)
<br><br>


## Class Goal			 
### goals set out for activities
- self.name 			 
   (string)
- self.category 		 
   (what category this falls under)
- self.metrics 			 
   (Dictionary/Key-Value pairs)
- self.date 			 
   (target date)
- self.status 			 
   (Boolean)
- self.completed		 
   (the date goal was completed)
<br><br>


## Class Personal Record		 
### records set for activities
- self.name 			 
   (string)
- self.category 		 
   (what category this falls under)
- self.metrics 			 
   (Dictionary/Key-Value pairs)
- self.date 			 
   (date record was set)	
<br><br>

# UI

### Screen 1: Main Dashboard:
```
=========================================
          EXERCISE TRACKER
=========================================
Categories:
1. View All Sessions (36 Sessions)
2. View Sessions by Category (6 Categories)

Options:
3. Create New Session
4. View Goals
5. View Personal Records
0. Exit App
=========================================
Enter your choice (0-5): 1
```


### Screen 2: View All Sessions:
```
=========================================
          EXERCISE TRACKER
=========================================
Sessions (Page 1):
1. Session Name 1 // 09/16/2003
2. Session Name 2 // 09/16/2003
3. Session Name 3 // 09/16/2003
4. Session Name 4 // 09/16/2003
5. Session Name 5 // 09/16/2003

Options:
1-5. View Session
6. Next Page
7. Previous Page
0. Return to Main Dashboard

=========================================
Enter your choice (0-7): 1
```


### Screen 3: View Sessions by Category:
```
=========================================
          EXERCISE TRACKER
=========================================
Sessions (Page 1):
1. Category 1 (6 Sessions)
2. Category 2 (6 Sessions)
3. Category 3 (6 Sessions)
4. Category 4 (6 Sessions)
5. Category 5 (6 Sessions)

Options:
1-5. View Category
6. Next Page
7. Previous Page
0. Return to Main Dashboard

=========================================
Enter your choice (0-7): 1
```


### Screen 4: View Activities in a Session:
```
=========================================
          EXERCISE TRACKER
=========================================
Date: 9/16/2003
Session Name 1 (Page 1)
1. Activity 1:
   - 225 lb
   - 10 reps
1. Activity 2:
   - 225 lb
   - 10 reps
3. Activity 3:
   - 225 lb
   - 10 reps
4. Activity 4:
   - 225 lb
   - 10 reps
5. Activity 5:
   - 225 lb
   - 10 reps

Options:
1-5. Edit Activity
6. Add Activities
0. Return to Session Dashboard

=========================================
Enter your choice (0-6): 1
```


### Screen 5: Add a Session:
```
=========================================
          EXERCISE TRACKER
=========================================
--- New Session Started: Sept 4, 2026 ---

Enter Session Name: Squat
Enter Session Category: Weightlifting

Options:
1. Add Activities to Current Session
0. Return to Main Dashboard

=========================================
Enter your choice (0-1): 1
```


### Screen 6: Add Activities to a Session:
```
=========================================
          EXERCISE TRACKER
=========================================
--- Session Name 1: Sept 4, 2026 ---

Enter Activity Name: Squat
Enter Metric Name (e.g., weight, distance): weight
Enter Metric Value: 225

> Added 'Squat' with weight: 225.

Options:
1. Add Another Activity
0. Return to Session Dashboard

=========================================
Enter your choice (0-1): 1
```


### Screen 7: View Record Categories:
```
=========================================
          EXERCISE TRACKER
=========================================
Categories:
1. Category 1
2. Category 2
3. Category 3
4. Category 4
5. Category 5

Options:
1-5. View Category
0. Return to Main Dashboard
=========================================
Enter your choice (0-5): 1
```


### Screen 8: View Records:
```
=========================================
          EXERCISE TRACKER
=========================================
Category 1:
1. Record 1 (9/16/2003)
   - weight: 225
   - reps: 10
2. Record 2 (9/16/2003)
   - weight: 225
   - reps: 10
3. Record 3 (9/16/2003)
   - weight: 225
   - reps: 10
4. Record 4 (9/16/2003)
   - weight: 225
   - reps: 10
5. Record 5 (9/16/2003)
   - weight: 225
   - reps: 10

Options:
1-5. View Record History
0. Return to Category List
=========================================
Enter your choice (0-5): 1
```


### Screen 9: View Goal Categories:
```
=========================================
          EXERCISE TRACKER
=========================================
Categories:
1. Category 1
2. Category 2
3. Category 3
4. Category 4
5. Category 5

Options:
1-5. View Category
0. Return to Main Dashboard
=========================================
Enter your choice (0-5): 1
```


### Screen 10: View Goals:
```
=========================================
          EXERCISE TRACKER
=========================================
Category 1:
1. Goal 1 (9/16/2003)
   - weight: 225
   - reps: 10
2. Goal 2 (9/16/2003)
   - weight: 225
   - reps: 10
3. Goal 3 (9/16/2003)
   - weight: 225
   - reps: 10
4. Goal 4 (9/16/2003)
   - weight: 225
   - reps: 10
5. Goal 5 (9/16/2003)
   - weight: 225
   - reps: 10

Options:
1-5. View Goal
6. View Completed Goals
0. Return to Category List
=========================================
Enter your choice (0-5): 1
```


### Screen 11: View Report:
```
=========================================
          EXERCISE TRACKER
=========================================
Category 1
8/16/1003 - 9/16/1003

Top Activities:

1. Activity 1
   - 6 sessions 
   - 80 total reps
2. Activity 1
   - 5 sessions 
   - 56 total reps
3. Activity 1
   - 4 sessions 
   - 40 total reps

Activities to Improve:

1. Activity 3
   - 2 sessions 
   - 5 total reps
2. Activity 4
   - 2 sessions 
   - 16 total reps
3. Activity 5
   - 3 sessions 
   - 20 total reps

New Records:

1. Activity 1 (9/16/2003)

Milestones Reached: 

1. Goal 1 (9/16/2003)
1. Goal 1 (9/16/2003)


Options:
0. Return to Main Dashboard
=========================================
Enter your choice (0): 0
```
<br>

## Design Decisions:

Use pagination to prevent "terminal scroll blindness".
Use categories and hierarchical grouping to organize sessions.
Dictionaries for metrics?
