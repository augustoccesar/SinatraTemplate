# Sinatra Template
Template application for [Sinatra](http://www.sinatrarb.com/).

## Folder Structure
    .
    ├── lib                                 # Application root folder
    |   ├── config                          # Configuration files
    |   |   ├── _initial                    # Configuration files that will run first
    |   |   |   └── #{config_name}.yml      
    |   |   └── config_loader.rb            # Script that load the configuration files
    |   └── modules                         # Application modules
    |       └── #{module_name}
    |           ├── controllers             # Controllers files
    |           ├── helpers                 # Helpers files
    |           └── models                  # Models files
    ├── config.ru                           
    ├── Gemfile
    └── README.md
    
## Configuration files

Every configuration file should contain the following structure:
```yaml
base: &base
  {key}:{value}

development:
  <<: *base
  {dev_key}:{dev_value}

production:
  <<: *base
  {prod_key}:{prod_value}
```

as the automatic configuration register will look for the environment according with `Sinatra::Base.environment`
to register the right variables to `APP_CONFIG` as explained further.
    
## Dynamic explanation

### Automatic routing

A controller file named as `users_controller.rb` with class name `UsersController` inside
a module `auth` will be registered to the route `/auth/users`.

### Automatic config registering

Every `.yml` file inside `config` folder will be registered inside a variable called `APP_CONFIG`
that can be accessed at any part of the project. For example, a configuration file called
`database.yml` that is inside the `_initial` folder (for it to run before all other configurations)
will be accessible by calling `APP_CONFIG.database.{key}`


## Disclaimer
This is not an official architecture nor a bulletproof way to build a Sinatra application. It's just
a try to organize and facilitate the development.