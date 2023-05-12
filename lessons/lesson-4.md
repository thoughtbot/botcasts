# Lesson 4: Typeahead Search

This commit extends the `element` Stimulus controller with a `requestSubmit`
action. We'll render the `<form>` element with `[data-controller="element"]` and
`[data-action="debounced:input->element#requestSubmit"]` to route every
[input][] event to the `element#requestSubmit` action, which will submit the
`<form>`.

The `debounced:input` portion of the `[data-action]` attribute is refers to an
event that's dispatched by the [debounced][] package, and is named after the
built-in [input][] event.

To preserve the query and its focus state throughout the live-search, we'll
render the `<input>` element with the [data-turbo-permanent][] attribute. When
combined with an `[id]` attribute that's consistent across the requesting
document and the response body, Turbo Drive will carry the element instance
forward through the navigation, and backward through a history restoration.

 We'll provide a `debounced` configuration to the page by rendering an in-line
`<script type="module">` element that invokes `debounced.initialize` with a
`JSON` object generated from values read from a call to
[`config_for(:debounced)`][config_for]. In most environments, the `<form>` will
wait 100 milliseconds between `input` events. In `test`, it'll submit
immediately.

Since the `<form>` will be making rapid submissions and those submissions
will result in a sequence of Turbo Drive visits, we'll want to render the
`<form>` with [data-turbo-action="replace"][] so that we _replace_ the current
History entry, instead of creating a new entry for each and every keystroke.

[input]: https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/input_event
[data-turbo-permanent]: https://turbo.hotwired.dev/handbook/building#persisting-elements-across-page-loads
[debounced]: https://github.com/hopsoft/debounced#why
[config_for]: https://edgeapi.rubyonrails.org/classes/Rails/Application.html#method-i-config_for
[data-turbo-action="replace"]: https://turbo.hotwired.dev/handbook/drive#application-visits


```diff
--- a/app/javascript/controllers/element_controller.js
+++ b/app/javascript/controllers/element_controller.js
@@ -4,4 +4,8 @@ export default class extends ApplicationController {
   replaceWithChildren() {
     this.element.replaceWith(...this.element.children)
   }
+
+  requestSubmit() {
+    this.element.requestSubmit()
+  }
 }
```

```diff
--- a/app/views/layouts/application.html.erb
+++ b/app/views/layouts/application.html.erb
@@ -9,6 +9,11 @@
 
     <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
     <%= javascript_importmap_tags %>
+    <%= javascript_tag type: "module", nonce: true do %>
+      import debounced from "debounced"
+
+      debounced.initialize(<%= raw Rails.configuration.debounced.to_json %>)
+    <% end %>
   </head>
 
   <body data-controller="hotkey">
```

```diff
--- a/app/views/search_results/index.html.erb
+++ b/app/views/search_results/index.html.erb
@@ -20,7 +20,12 @@
       <div class="lg:px-8">
         <div class="lg:max-w-4xl">
           <div class="mx-auto px-4 sm:px-6 md:max-w-2xl md:px-4 lg:px-0">
-            <%= form_with model: @search, scope: "", url: false, method: :get, class: "flex items-center gap-4" do |form| %>
+            <%= form_with model: @search, scope: "", url: false, method: :get, class: "flex items-center gap-4",
+                  data: {
+                    turbo_action: "replace",
+                    controller: "element",
+                    action: "debounced:input->element#requestSubmit",
+                  } do |form| %>
               <div class="relative mt-1 rounded-md shadow-sm">
                 <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                   <%= inline_svg_tag "icons/search.svg", class: "h-2.5 w-2.5" %>
@@ -28,7 +33,8 @@
                 <%= form.label :query, class: "sr-only" %>
                 <%= form.text_field :query, class: "w-full rounded-md border-gray-300 pl-10 text-sm placeholder:font-mono placeholder:text-sm placeholder:leading-7 placeholder:text-slate-500",
                                     placeholder: "Search", autofocus: true,
-                                    aria: {describedby: dom_id(@search, :prompt)} %>
+                                    aria: {describedby: dom_id(@search, :prompt)},
+                                    data: {turbo_permanent: true} %>
               </div>
 
               <button class="text-sm font-bold leading-6 text-pink-500 hover:text-pink-700 active:text-pink-900">
```

```diff
--- a/config/application.rb
+++ b/config/application.rb
@@ -20,5 +20,6 @@ module Botcasts
     # config.eager_load_paths << Rails.root.join("extras")
 
     config.active_job.queue_adapter = :good_job
+    config.debounced = config_for(:debounced)
   end
 end
```

```yml
shared:
  input:
    wait: 100

test:
  input:
    wait: 0
```

```diff
--- a/config/importmap.rb
+++ b/config/importmap.rb
@@ -8,3 +8,4 @@ pin_all_from "app/javascript/controllers", under: "controllers"
 pin "trix"
 pin "@rails/actiontext", to: "actiontext.js"
 pin "@github/hotkey", to: "https://ga.jspm.io/npm:@github/hotkey@2.0.1/dist/index.js"
+pin "debounced", to: "https://ga.jspm.io/npm:debounced@0.0.5/src/index.js"
index af807eb..c8be6eb 100644
```
