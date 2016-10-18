##Voluntr.io

#Technology
We will be using Ruby on Rails (RoR), a web application framework written in Ruby, to build the Voluntr.io site. The framework will greatly simplify the development process, as common tasks can often be boiled down to one Rails command. It also allows for embedded Ruby to be used directly alongside HTML and CSS, which makes including dynamic content in pages simple. 

RoR uses the Model-View-Controller (MVC) architecture pattern. In very simple terms, a Rails router directs browser hits to controllers which determine how to react to the HTTP requests. The controller will interact with a model, an object which communicates with the database and represents an element of the site, to retrieve any necessary information. This information is passed to a relevant view, which will use the data in combination with HTML, CSS, and embedded Ruby to render the page and return it to the controller, which passes it back to the browser. MVC allows sites to be built in a way that is easy and familiar to developers practiced in object-oriented programming.

There are a variety of libraries available for RoR in the form of gems, which we will be managing with the RubyGems package manager. Broadly speaking, these gems will be used to speed up development and add functionality to the site without repeating work that has already been done by other developers and made freely available. Notable gems include rails, sass, pg, bootstrap-sass, and bcrypt. The CSS templates the bootstrap-sass gem includes will be used for site design if resource limits prevent the creation of custom CSS for the site. Short descriptions of all gems used in the site are available in appendix A of this document.

The group will be utilizing the Cloud9 IDE. This will avoid the often difficult task of installing and configuring Ruby on Rails and the software needed to develop with it. Cloud9 allows cloud workspaces to be created which are specifically configured for RoR development. It will also facilitate group work, as the IDE is focused on collaboration to the point that developers can communicate in its group chat while simultaneously writing code in the same file.

Version control will be accomplished with Git using a repository on GitHub. Heroku, a platform designed for Rails applications using Git version control, will be used for deployment. Since it is used by Heroku, the PostgreSQL open source database system will be used to hold user data in the deployed website while SQLite3 is used for production. While the development and deployment environments would ideally be identical, Rails allows for different gems to be used in development and deployment so this should cause no problems in the overall project.


#Appendix

Descriptions adapted from rubygems.org and railstutorial.org

Ruby Gem - Purpose
rails - Full-stack web framework

puma - HTTP server for the application

sass-rails - Sass adapter for the Rails pipeline

uglifier - Compresses JavaScript files

coffee-rails - CoffeeScript adapter for Rails

jquery-rails - jQuery and jQuery-ujs driver

turbolinks - Adds Turbolinks 5 support

jbuilder - Create JSON structures

sqlite3 - Interface between Ruby and the SQLite3 database engine

byebug - Debugger

web-console - Debugging tool

listen - Create notifications for file modifications

spring - Speeds up console, rake, and tests

spring-watcher-listen - Makes spring watch files

rails-controller-testing - Adds testing methods

minitest-reporters - Extend minitest and changes appearance of reporter

guard - Command line tool to handle events on file system changes

guard-minitest - Runs tests with Minitest framework

pg - Interface to PostgreSQL

tzinfo-data - Contains time zone data

bootstrap-sass - Framework with CSS templates

bcrypt - Includes bcrypt() hash algorithm

faker - Assists in creating sample users

will_paginate - Adds pagination capability to sections of site

bootstrap-will_paginate - Configures will_paginate to use Bootstrap styles


