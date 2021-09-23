# Interview Template Repo

> This repo shows how to use workers to load data in a simple but elegant way.

## This project has these features:
  - You can see users created
  - You can see each user page
  - You can run a worker that will fetch users from an endpoint.
  - You can run tests to check everything is ok.

## Built With

- Ruby and Rails
- HTML, SCSS, Postgresql
- Heroku

## Live Demo
### Worker test

run the
[Live Demo Link](https://men32z-template-repo.herokuapp.com/users)
first, this will load an empty page. after that you can run the worker.

worker will run on the page [https://men32z-template-repo.herokuapp.com/test](https://men32z-template-repo.herokuapp.com/test)
- this will only run once, will implement something to refresh later. see Upcoming Features? section below.



## Local Install

1. Clone the project to your local directory

```
 git clone git@github.com:men32z/template-repo.git
```

2. Get in to the folder app

```
cd learning-tracker-app
```
3. Prepare rails environment

```
bundle install --without production
rails db:migrate
rails db:seed
```
as a requirement for workers you must have a redis server installed.

```
# on mac
brew install redis
# on linux
sudo apt-get install redis-server
```

you must configure an .env file. you can find the example at .env.example

4. run rails server

```
rails s
```

### Usage

Go to Localhost in your favorite browser

```
http://localhost:3000/users
```

### Run tests

```
rspec
```


## updates
- ruby version updated 2.6.0 -> 2.7.4: ruby version was updated to one of the latest stable version due to vulnerabilities and deployment incompatibilities.

## todo
- remove unused branches.
- on UserLoader::Microverse service url and headers could come from db, env or params.
- improve user_loader tests, due to mock json is big.

## Upcoming Features?
- authentication with roles.
- secure workers routes.
- a page for users to handle the worker and future workers.
- push notification once all load process is done.

## Author

👤 **Luis Preza**

- Github: [@men32z](https://github.com/men32z)
- Linkedin: [Luis Preza](https://www.linkedin.com/in/men32z/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/men32z/template-repo/issues).

### Credits

Template and idea by Microverse.