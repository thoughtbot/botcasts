# How to contribute to this project

Because this project requires lessons and their `diffs` to be in a certain
order, special care is required to contribute to this repository.

After creating and merging a [pull-request][1], follow these steps.

1. Checkout `main`.

```sh
git fetch
git checkout main
git pull
```

2. Rebase interactively against the `--root`.

```sh
git rebase -i --root
```

3. Identify the commit you introduced.

```text
pick f5f435b [GENERATED]: Initial Commit
pick 54b3655 [GENERATED]: Install and execute `standardrb`
pick 89c976a [GENERATED]: Install Action Text
pick 9cd349e Depend on `factory_bot_rails`
pick 44d7021 [GENERATED]: Install `devise`
pick aa4f999 Install `capybara_accessible_selectors`
pick 25c1376 Depend on `action_dispatch-testing-integration-capybara`
pick fe1fc25 Introduce GitHub Actions for Continuous Integration
pick b36e6c7 Integrate with Devise system test helpers
pick bba8098 [GENERATED]: Install `good_job` Active Job adapter
pick 8445e4b Update README
pick ba0b0b4 Stop serving JavaScript code
pick 95700ab Import Podcasts from Fireside RSS
pick 208bbc9 Implement pages with Tailwind UI Template
pick 7484357 Paginate with `pagy`
pick 66255b3 Extract `PodcastScoped` concern
pick 27e8306 Episode Search
pick 4276531 [BACKPORT]: Promote lazily-loaded Turbo Frame navigation
pick 304a037 Build assets during setup (#16)
pick a3ada0f Getting Started
pick b86afaa Lesson 1: Our first lines of JavaScript
pick 2fc0b6b Lesson 2: The Audio Player
pick cf2942e Lesson 3: Infinite scroll
pick dfaeb73 Lesson 4: Typeahead Search
pick 0d97e49 Update Tutorial Assistant on setup (#18) # <- We need to move this
```

4. Move the commit to **before** the "Getting Started" commit.

```
ck f5f435b [GENERATED]: Initial Commit
pick 54b3655 [GENERATED]: Install and execute `standardrb`
pick 89c976a [GENERATED]: Install Action Text
pick 9cd349e Depend on `factory_bot_rails`
pick 44d7021 [GENERATED]: Install `devise`
pick aa4f999 Install `capybara_accessible_selectors`
pick 25c1376 Depend on `action_dispatch-testing-integration-capybara`
pick fe1fc25 Introduce GitHub Actions for Continuous Integration
pick b36e6c7 Integrate with Devise system test helpers
pick bba8098 [GENERATED]: Install `good_job` Active Job adapter
pick 8445e4b Update README
pick ba0b0b4 Stop serving JavaScript code
pick 95700ab Import Podcasts from Fireside RSS
pick 208bbc9 Implement pages with Tailwind UI Template
pick 7484357 Paginate with `pagy`
pick 66255b3 Extract `PodcastScoped` concern
pick 27e8306 Episode Search
pick 4276531 [BACKPORT]: Promote lazily-loaded Turbo Frame navigation
pick 304a037 Build assets during setup (#16)
pick 0d97e49 Update Tutorial Assistant on setup (#18) # <- Move it before "Getting Started"
pick a3ada0f Getting Started
pick b86afaa Lesson 1: Our first lines of JavaScript
pick 2fc0b6b Lesson 2: The Audio Player
pick cf2942e Lesson 3: Infinite scroll
pick dfaeb73 Lesson 4: Typeahead Search
```

5. Confirm the rebase worked.

```sh
git log --oneline
```

```
f805411 (HEAD -> main) Lesson 4: Typeahead Search
98a2d3d Lesson 3: Infinite scroll
83f2ae3 Lesson 2: The Audio Player
45624d1 Lesson 1: Our first lines of JavaScript
14e6e70 Getting Started
0a4b7a9 Update Tutorial Assistant on setup (#18) # <- The commit is in the correct spot
304a037 Build assets during setup (#16)
4276531 [BACKPORT]: Promote lazily-loaded Turbo Frame navigation
27e8306 Episode Search
66255b3 Extract `PodcastScoped` concern
7484357 Paginate with `pagy`
208bbc9 (edit_player_markup) Implement pages with Tailwind UI Template
95700ab Import Podcasts from Fireside RSS
ba0b0b4 Stop serving JavaScript code
8445e4b Update README
bba8098 [GENERATED]: Install `good_job` Active Job adapter
b36e6c7 Integrate with Devise system test helpers
fe1fc25 Introduce GitHub Actions for Continuous Integration
25c1376 Depend on `action_dispatch-testing-integration-capybara`
aa4f999 Install `capybara_accessible_selectors`
44d7021 [GENERATED]: Install `devise`
9cd349e Depend on `factory_bot_rails`
89c976a [GENERATED]: Install Action Text
54b3655 [GENERATED]: Install and execute `standardrb`
f5f435b [GENERATED]: Initial Commit
```

6. Force push your changes.

```sh
git push --force-with-lease
```

7. [Re-tag][2] the lessons.

```sh
./auto_tag.sh
```

[1]: https://github.com/thoughtbot/botcasts/pulls
[2]: https://github.com/joemasilotti/git-auto-tagger
