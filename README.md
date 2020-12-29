### Deployed link
[market place app](https://ancient-cliffs-14683.herokuapp.com/)
### Solving a problem 

I'm building this app for an easy and cheap way for developers to get there games to the public. This app will be a central place for new up and coming games from the smaller developer community. Users will be insisted to rate games they own, helping new developers be seen and build rep. 

### why it needs solving 

By creating this app I'm hoping to inspire people into learning programming through creating games. Also making it freely available for younger developers, this will be a great way for start ups to get there name out there. I also belive my app will be able to help small game devs to actually get people to see there game and not be pushed out by the AAA titles. 

### Description of your marketplace app (website), including:
##### Purpose

The pupose of this app is to allow smaller game devs to stand out to employers and the comunity. Making it possible to have there game seen and recive feed back from the users. 

##### Functionality / features

public users can: 
- submit games to be approved
- see/buy all approved games
- leave reviews and ratings on games they own
- create/edit/delete your profile

Admin users can:
- edit/delete game post
- edit/delete accounts
- approve/remove sumbitted games
- remove reviews

##### Sitemap

![site map](doc/sitemap.png)

##### Screenshots

![index page](doc/indexpage.png)
![profile page](doc/profilePage.png)
![show page for game](doc/gameShow.png)
![review on games](doc/reviewGame.png)

##### Target audience

The target audience that would use this app is, Anyone that enjoys playing video games and leaveing feedback or game developers looking for an easy way to make there game accessible to the public. Also allows game testers to leave reviews on new games to help show the game to more people.

##### Tech stack (e.g. html, css, deployment platform, etc)

- rails
- ruby
- html
- scss
- css
- javascript
- heroku(deployment)
- AWS(amazon web services)

### User stories for your app

There are two types of users in this app:

Admin and public

When no one is currently logged in, they should be able to look at available games for purchase, and other user's accounts/libraries. Users will not be able to edit, buy, submit a game or leave a review on any games until they have logged in. 

As a public user, you can purchase any of the games approved by an admin, create and edit your own profile and submit a game to be approved by an admin. After your game has been approved or after you have purchased a game, you will be able to see the game in your library or on your profile page. Owned games are available to be downloaded from your own library page. When a public user's game has been approved, the developer of the game can update and edit the information on the game show page. Public users can only leave reviews on games that they own, and can only update or remove there own review

As an admin user, You should be able to monitor everything that is added to the site by the users. Admins Can edit and remove any game post or review left on an approved game. An Admin should be able to remove any inappropriate accounts or remove profile pictures. For any game that has been submitted to the app, an admin will have the chance to review and approve or remove the game.


### Wireframes for your app
# home page

![home screen wire frames](doc/homeScreenWireFramse.png)

# profile page

![profile screen wire frames](doc/profileWireFrames.png)
### An ERD for your app

![ERD](doc/ERD.png)

### Explain the different high-level components (abstractions) in your app

The main high-level components would be the users aand games controllers and models, the controllers talk to the models to make querys to the database. This allows the model to fetch information attached to a single or multipul users, and display the information in the corrosponding views. The Models, views and controllers architecture that this app is built arround maps each column in a table to create a ORM(Object Relational Mapping). This saves us from having to write any SQL to appened data to the database. Our models can represent inheritance through related models, accessing attributes are done with methods attached the model tables.

### Detail any third party services that your app will use
##### Authentication 
- My app is using the devise and rolify gem for authentication on users and rolify for managing the roles that each user has.

##### Active storage
- My cloud storage is an amazon web service s3 bucket, using the `aws-sdk-s3` gem I have access to methods to upload and attach files to users.

##### Deployment
- My app is deployed on a heroku server.

### Describe your projects models in terms of the relationships (active record associations) they have with each other
For users to own many games my models were configured with: 
In the game model: `has_and_belongs_to_many :users`
In the user model: `has_and_belongs_to_many :games`
This is because a game has 1 creator and many users can own the game, and the same for the user he can create many games and also own many game.

Attaching a file or picture to a user or game:
In the user and game model: `has_one_attached :picture, dependent: :purge`
In the game model: `has_one_attached :game_folder, dependent: :purge`
has one attached is attaching a picture or file to the user or game record.

leaving a review on a game:
In the game model: `has_many :reviews`
In the reviews model: `belongs_to :game`
This is because each game can have lots or reviews but each review is only about 1 game.

### Discuss the database relations to be implemented in your application

The first table I created in the database was Users, this is because all of the other models relate back to this eventually. I generated the users table with devise an authentication gem, default columns in the devise table are email and password, so I created a migration to add columns for Username and Bio. The next table I created was the role and user_role joining table, this allows users to have 1 or more roles, and allows many users can have the same role. 

After the user tables were complete and working I ran `active_storage:install ` to generate the active storage tables, these tables store all the data involved with storing files and images in my AWS bucket. The first table it created was `active_storage_blobs`, this table handles content_type, byte_size, file_name and, the key witch is were it is located in the cloud service. The second table created was the `active_storage_attachments` table witch is a polymorphic join table that stores the model's class name as a `record_type`, and a primary key as `record_id`. By adding `has_one_attached :picture, dependent: :destroy` in the user model, I can limit the user to having only one picture.

When active storage was done I generated a game model and a games_users joining table, the games table will contain title, description, approved, avg_rating, owner, and the price of each game submitted. While the games_users table contains a user_id and game_id, this allows the users to have a many to many relationship with each game. One user can have many games and one game can have many users, this means multiple users can own the same game. Game also have pictures and `zip` files attached through the active storage, inside the game model i have `has_and_belongs_to_many :users`,`has_one_attached :picture, dependent: :destroy`, `has_one_attached :game_folder`, this lets active storage know to save these files to this class instance. 

The last table I created was reviews, this table has a many to one relationship with a game. The reviews table contained a user, title, content, rating, and game_id. Each review is linked to a game and each review rating affects the games avg_rating column. The games model had to be create before the reviews because each review belongs to a game.

### Provide your database schema design

##### Users
- I made the username, email and password a string because they didnt need to be over 255 charecters.

##### Roles
- Rolify also generates the roles table witch contains a name and resouce_type as a string and resouce_id as a bigint

##### User_roles
- This table is generated by rolify and handles the user_id and role_id as data type bigint because they are foreign keys for the user and role.

##### Games
- The games table contained all the informaition the belongs to a game such as title, price, description, ect. The price of the games is stored as a deciaml so I can store the price with cents.

##### Games_users
- Games_users is a joining table for the game and user model, this handles the relation between the users and the games they own by storing the user_id and game_id as a foreign key linked to that user.

![schema1](doc/schema1.png)
![schema2](doc/schema2.png)
![schema3](doc/schema3.png)
![schema4](doc/schema4.png)
### Describe the way tasks are allocated and tracked in your project

Because this app is built with a relational database, some steps had to come before others. When I had an erd with all the relations I wanted to create, I could see that there had to be a games model before you made a games review model. This is because games and reviews have a mandatory 1 to many relations, So there has to be at least 1 game to review. Knowing this I added controllers and models in this order.
- Users
- Roles
- AWS active storage
- Games 
- Reviews

I also planed on trello: [trello board](https://trello.com/b/uDQTGtVg/market-place)

# day planning
*day1* : designing the erd on drawio and planning the models and data structure for how tables are related to each other. wireframes for the home page on 3 different screen sizes. 

*day2* Created user Model with devise for authentication, validates presences of email, password and email added automated role assignment for new accounts using rolify, Deployed on heroku and created and seeded the heroku server. Created wireframes for the profile page on 3 different screen sizes.

*day3* started with static image uploading to set the functions in the controller, then created an amazon web service account and an s3 bucket for handling profile pictures and files. installed the `aws-sdk-s3` gem for making calls to the amazon api. Once you have stored your public and secret key securely in the `.env` or `credentials.yml`, and changed the `active_storage.service` form `:local` to `:amazon` in the `development.rb` and `production.rb` file.  

*day4* generated Game model and configured the relations in the user and game models such as `has_and_belongs_to_many :users` and `has_one_attached :picture`. After this I created a joining table with `rails g migration CreateJoinTableUsersGames Users Games`. I created some dummy games and assigned them to users as a quick test, and started on displaying the games on the index page.

*day5* started off by creating a form with the `form_with` helper to handle uploading a game, witch includes title, description, price, picture and game folder. Created a loop on the index, library and profile pages to show all the games formatted the same way. Then I started on the edit form to update the games information and a delete button to remove to game. Using the `link_to` method i turned all the game titles being displayed in to links to the show page for that game. At the end of the day I installed the `stripe` gem and updated the .ENV file with my api keys for stripe, and added the `buy`, `success` and `cancel`  methods to redirect the user to the correct page

*day6* Spent time in the views cleaning everything up, stripe success and failed flash alerts and Games are added to users after a purchase. In the users library page i added a download link with ` <%= link_to "Download #{game.title}", rails_blob_path(game.game_folder, disposition: 'attachment') %>`. Added validation to check if the user is on there own library page before displaying the download link. Game edit screen is now resricted to the game owner.

*day7* generated a review model with user, title, content, rating, and game_id as attributes. then I generated a reviews controller, I started with a form on the game show page, that allows users that own that game to leave a review and a rating. Built a each loop for all the reviews on the current game, and displayed the title, content, rating, and username in a div container. Validation for the review creator to be the only one who can edit and delete. 

*day8* started the day by creating a method that after each new review is made, it updates the average rating for that game and shows it under the game description. Then i started working on the navbar with bootstrap, I first found a template that I liked and strated changing the links around to mach the correct location, keeping all the same class names. After this I added in the bootstrap `css` file to the header and the JavaScript cdn for `jQuery` and `Popper.js`. After lunch I started on the admin dashboard for approving submitted games, this allows admins to review games before they become avlibale to the public. 

*day9* Spent the day doing documentation and added a div with the class flex container around the yield in the body of the `application.html.erb`, testing validation on the forms manually, and made a PowerPoint for the presentation tomorrow.

*day10* More documentation and checking validation along with adding bootstrap to show the reviews in cards and show all the games the same way across the pages. Wraping each card in 2 divs with a `row` and `col-md-3` class, allows everything to flex around the body.

