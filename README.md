# 🤖 Botcasts

**Hotwire-powered Podcast Player** 🔌

This course works by introducing a series of failing tests that you must get to
pass by introducing Hotwire patterns into the application.

For more Hotwire resources, check out our [blog posts].

[blog posts]: https://thoughtbot.com/blog/tags/hotwire

## ⚙️  Setup

If this is your first time running the application, run `./bin/setup` to
install dependencies and seed the database.

[issue]: https://stackoverflow.com/a/70720842

## 🏗 Running the application

Run `./bin/dev` to start the development server and then navigate to
[http://localhost:3000](http://localhost:3000).

Note: Running `./bin/dev` will execute the background jobs to import the
episodes scheduled in the setup step above. It will take a few minutes.
If you run into issues due to a podcast or episode not being
found, see the jobs statuses on http://localhost:3000/good_job.
Once they are finished, the episodes should be accessible in the UI.

## 🚀 Getting Started

Once you've setup the application locally, you are ready to start the [lesson plan][1].

Once the tests pass, move on to the next lesson.

## Contributing

Please see [Contributing](./CONTRIBUTING.md).

[1]: ./lessons/README.md
