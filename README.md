# 🤖 Botcasts

**Hotwire-powered Podcast Player** 🔌

The app starts as a Turbo-less Rails app. The goal is to progressively enhance
it using [Hotwire][].

[Hotwire]: https://hotwired.dev

## ⚙️  Setup

If this is your first time running the application, run `./bin/setup` to
install dependencies and seed the database.

## 🏗 Running the application

Run `./bin/dev` to start the development server and then navigate to
[http://localhost:3000](http://localhost:3000).

> [!NOTE]
> Running `./bin/dev` will enqueue background jobs to import the episodes.
> It will take a few minutes.

If you run into issues due to a podcast or episode not being
found when accessing the app, check the jobs statuses
on [http://localhost:3000/good_job](http://localhost:3000/good_job).

## 🚀 Getting Started

Once you've setup the application locally, you are ready to start the [lesson plan][].

[lesson plan]: ./lessons/README.md

## Contributing

Please see [Contributing](./CONTRIBUTING.md).

## Additional resources

For more Hotwire resources, check out our [Hotwire resources][] and [blog posts][].

[Hotwire resources]: https://thoughtbot.com/services/hotwire-stimulus-turbo-frontend-development
[blog posts]: https://thoughtbot.com/blog/tags/hotwire

## About thoughtbot

![thoughtbot](https://thoughtbot.com/thoughtbot-logo-for-readmes.svg)

This repo is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github
