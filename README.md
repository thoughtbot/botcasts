# 🤖 Botcasts

**Hotwire-powered Podcast Player** 🔌

This course works by introducing a series of failing tests that you must get to
pass by introducing Hotwire patterns into the application.

The app starts as a Turbo-less Rails app. The goal is as you complete the lessons,
you'll make it more iteractive using Hotwire.

## ⚙️  Setup

If this is your first time running the application, run `./bin/setup` to
install dependencies and seed the database.

## 🏗 Running the application

Run `./bin/dev` to start the development server and then navigate to
[http://localhost:3000](http://localhost:3000).

Note: Running `./bin/dev` will enqueue background jobs to import the
episodes. It will take a few minutes.
If you run into issues due to a podcast or episode not being
found when accessing the app, check the jobs statuses
on http://localhost:3000/good_job.

## 🚀 Getting Started

Once you've setup the application locally, you are ready to start the [lesson plan][1].

We recommend getting the tests to pass for each lesson before moving on to a new one.

## Contributing

Please see [Contributing](./CONTRIBUTING.md).

[1]: ./lessons/README.md

## Additional resources

For more Hotwire resources, check out our [blog posts].

[blog posts]: https://thoughtbot.com/blog/tags/hotwire
