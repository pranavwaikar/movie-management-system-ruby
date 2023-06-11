# Cinema ticket booking system

This is a movie / show booking system. It is a CLI app. Please refer to `problem_statement` folder for details.

# dependency & requirements

Ruby - 3.2.2

To install dependencies run : 

````
bundle install 
````

# How to run ? 

After a succcessful dependency installation, you can run : 

````
rake start
````

# Linting

It uses rubocop as a linter & can be triggered with rake tasks.

For a simple linting report - 
````
rake lint
````

The below command autofixes certain linting issues by itself - 
````
rake lint_fix
````


# Test

The below command triggers all the ruby commands using rspec. 

````
rake test
````

# Implementation

- The implementation focus is on providing a level of abstraction/interface to hide the complexity & keep the loose coupling.
- The design schema is - model - view - controller. 
- The model is based on repository pattern. 
- The model imitates feature like table, primary and foregin keys, automatic ID assignment.
- The controller uses model to add business logic over models.
- The view uses controllers to facilitate business tranasactions. 
- The logger stores all the statements plus provide features like colorized printing.
- Some of the parameters can be configured using the config file.
- `Rake` is used as a task manager for script management.
- Bundler is used to manage dependencies.

## config file

The config file is present at location - `src/config/config.json`. This file can contain all the configurtaion parameters 
required by our program. This makes it easy for users to control the variable values and remove the code level dependancy. 

The config file has an interface over it called `ConfigLoader` class. This is also a singleton class to reduce memory load. 
This provides and easy to use interface. This can also help if later we want to move our config files to a database or S3 bucket. This interface provides us with data abstraction. 

## log files

The logger here writes everything to a log file. The location of the log file can be configured using the config file - `LogFilePath` variable. 
The logger is a singleton class & has few of the methods which by defult help in pretty formating like coloring using the colorize gem.

## Data model

Here we are using a repository pattern for creating a data model. We have a repository interface which defines a few actions to be implemented by any storage mechanism. 

In this current implementation, we are using in-memory storage. But if we want to use any database, we can just implement a new class with & implement repository interface methods for that database. This means our data model can be used without worrying about underlying architectural complexity. 

On top of repository, we have a `Model` which can hold some application specific operations if needed. The rest of the data model entities can inherit this class & this provides an abstraction layer above the repository.

### Database Interface

Here in-memory storage is implemnted like a database storage. Instead of actual database, it uses list of hashes to store the data. 

To make these list easily accessible, the `Database` class offers some static methods per model entity. This is achieved by using class variables and class methods. 

Plus this allows to have some database specific methods like `seed` which can be implemented to add some pre-defined fake data for usage and testing.
