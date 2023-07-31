# Learner Application
This flutter application is for creating courses and enrolling other people's courses

# Authentication
You can sign up if do not have an account or sign in if you already have an account. You can navigate to the sign up or sign in page by pressing the relevant in the welcome view. You can come back to the welcome view if you clicked the worng button. Signing up will automatically sign you in with credentials you used when signing up. You only need to enter your email and password when signing in. But you should additionally create a username when you are signing up.

# Home Page
In the home page you can navigate between three different views by using the bottom navigation bar. The first view is to view courses, second one is to create courses, and the third view is your profile page. You can log out and navigate to the welcome view by clicking the floating action button.

# Courses View
You can view the all the courses created by users. Every course is displayed in the screen as a card and there are two cards in a row. Every card has a title which is the course name and a subtitle which is the course length. You can navigate to view which is special to that course by pressing on the course card. In the course view there is text that contains the data about the creator of that and a button for enrolling in that course. You can not enroll in a course you have created. 

# Create Course View
This is the second view in the home page and it is for creating courses. There are two text fields; one is for the name of the and the other is for the length of the course(it only accepts integers as input). You can press the create button after providing necessary information to create your course.

# Profile View
In the profile view, you can perform multiple actions. First you can change your username by clicking the change username button at the right side of the username row. Then you can see the courses you enrolled in or the courses you have created. If you choose to see the courses you have enrolled in you are going to be navigated to a scaffold which contains the courses you have enrolled as cards, same as the main view. But, when you press on a card you will be a navigated to a page and this time, there will be discard button instead of an enroll button. You can press it to discard the course. If you choose to see the courses you have created, again, you will see a scaffold which contains the courses you have created as cards. If you press on a card you will be a navigated to a page and in this page, you can update and delete the course. When you press on update button, a bottom sheet will appear and you can update the data for the course. Below the update and delete buttons, there is a text button saying, "See the students of this course", if you press on that button, you will navigate to a page where you can all the users who are enrolled in this course. 


