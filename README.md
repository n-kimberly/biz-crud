# Biz CRUD

### Biz CRUD is a Reddit-like application meant to teach CRUD fundamentals

At Biz CRUD, users can sign up and sign in to create, comment, favorite, and vote on posts as well as receive updates on comments on their favorites through email.

[Sample Deployed at Heroku](https://biz-crud.herokuapp.com/)

## Project Objectives

- Users can sign up for a free account by providing a user name, password and email
- Users can sign in and out of Biz CRUD
- Users can view topics and posts
- Users can comment on posts
- Users can create new posts and edit posts they own
- Users can up/down vote any post
- Users can favorite any post and be emailed with updates on that post
- User's profile displays their posts and comments
- Users can add a Gravatar to their profile
- User roles available: admin, moderator, and standard
- Admins can delete and create any topic or post
- Development database is seeded automatically with users, topics, and posts

## Built With

#### Languages and Frameworks:
- Ruby 2.4.0
- Rails 5.1.3
- Bootstrap

#### Databases:
- SQLite (Test, Development)
- PostgreSQL (Production)

#### Tools and Gems:
- BCrypt for secure passwords
- SendGrid for email confirmation
- FactoryGirl for test suite success

## Setup and Configuration

#### Setup:

- Environment variables were set using Figaro and are stored in config/application.yml (ignored by git).
- The config/application.example.yml file illustrates how environment variables should be stored.

#### To run Blocipedia locally:

1. Clone the repository
2. Run `bundle install`
3. Create and migrate the database with `rails db:create` and `rails db:migrate`
4. Start the server using `rails s`
5. Run the app on `localhost:3000`
