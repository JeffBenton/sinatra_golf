# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - The app is complete
- [x] Use ActiveRecord for storing information in a database - Activerecord is used with a sqlite3 database
- [x] Include more than one model class (e.g. User, Post, Category) - Includes User, Course, and Score models
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - Users have many Scores
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - Scores belong to Users
- [x] Include user accounts with unique login attribute (username or email) - User accounts log in with a unique username
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - Scores have all CRUD operations
- [x] Ensure that users can't modify content created by other users - Users are only able to modify their own Scores
- [x] Include user input validations - All inputs have validations
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - Flash message errors are displayed for failed validations
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message