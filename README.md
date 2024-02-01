# TODO App in Ruby

This is a simple todo command line app written in Ruby with performance in mind.

# Engineering

To build this app, I have engineered in the way it would be more extensible and easier to debug in future. I have implemented the Object Oriented principles as well as the standard Software Engineering principles to achieve the goal. Although, this project can be done in few lines of code in a single file, it would make the future development more costly.

# Installation

The installation process is quite simple and straightforward. You need to have the ruby version `3.1.2` and have the gems installed in your `Gemfile`. Follow the commands below to do so:

```sh
rbenv install 3.1.2
bundle install
```

# Docker
This app can be run in docker without the hassle of haivng to setup ruby for development. Run the following command to do so:

```sh
docker build .
```
Once the image is built, use the docker run command to run the app.

```sh
docker run -it <image_id>
```

# Usage

To use this app, you will find the entrypoint script in the `bin` folder. Run this command to fetch the `n` todos with their statuses.

```sh
./bin/todo -c 20
```

# Testing

This app uses `rspec` for testing the app. To run the test cases simply run the following command:
```sh
bundle exec rspec
```

# Limitations:
- This project uses `[jsonplaceholder](https://jsonplaceholder.typicode.com)` as the major source of the data. However, this can be changed to store the data locally which would make the project faster and also won't need internet to fetch them.

# Future Development:
This app can be enhanced furthur by following ways:
- Adding more integrations with other services like `Jira`, `Trello` etc.
- Adding more features like `create`, `update`, `delete` etc.