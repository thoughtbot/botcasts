# Lesson 3: Infinite Scroll

In this lesson we'll demonstrate how to progressively enhance our existing
pagination system by seamlessly replacing it with an infinite scroll feature.

Additionally, we'll ensure that the page numbers continue to be appended to the
URL as query parameters, preserving essential functionality.

TODO: Add demo

- Wrap the pagination in a turbo-frame.
  - This is so we can capture each set of paginated results in a frame.
  - Adding and ID makes it so we replace the pagination with the next set of
    paginated links
  - Adding `target="_top"` makes it so clicking on any of the links withing the
    `turbo-frame` replaces the whole page. This is important because there are
links to episodes in there.
- Add a nested `turbo-frame` to load the next set of results.
  - `loading: "lazy"` means it won't fire off an event until it's visible.
  - `data-turbo-action` means it will be replaced with the response.
  - TODO: Why do we also have a controller to replace the children, if we're
    using `replace`?
  - I think this is because we could keep nesting `turbo-frames` within one
    another. Each paginated result would get nested in the previous
`turbo-frame`. By replacing the `turbo-frame`, we end up with one `turbo-frame`
on the bottom of the page that gets replaces with the new paginated results and
a new `turbo-frame` for the next set.

```diff
--- a/app/views/episodes/index.html.erb
+++ b/app/views/episodes/index.html.erb
@@ -9,9 +9,9 @@
     </div>
 
     <div class="divide-y divide-slate-100 sm:mt-4 lg:mt-8 lg:border-t lg:border-slate-100">
-      <div>
+      <turbo-frame id="page_<%= @page.page %>" target="_top">
         <% if @page.prev %>
-          <div class="py-10 sm:py-12">
+          <div class="py-10 sm:py-12 hidden first:block">
             <div class="lg:px-8">
               <div class="lg:max-w-4xl">
                 <div class="flex justify-center mx-auto px-4 sm:px-6 md:max-w-2xl md:px-4 lg:px-0">
@@ -29,8 +29,9 @@
         <%= render @episodes %>
 
         <% if @page.next %>
-          <div>
-            <div class="py-10 sm:py-12">
+          <%= tag.turbo_frame id: "page_#{@page.next}", src: pagy_url_for(@page, @page.next), loading: "lazy",
+                data: {turbo_action: "replace", controller: "element", action: "turbo:frame-load->element#replaceWithChildren"} do %>
+            <div class="py-10 sm:py-12 hidden last:block">
               <div class="lg:px-8">
                 <div class="lg:max-w-4xl">
                   <div class="flex justify-center mx-auto px-4 sm:px-6 md:max-w-2xl md:px-4 lg:px-0">
@@ -43,9 +44,9 @@
                 </div>
               </div>
             </div>
-          </div>
+          <% end %>
         <% end %>
-      </div>
+      </turbo-frame>
     </div>
   </div>
 <% end %>
```


```diff
--- a/app/views/search_results/index.html.erb
+++ b/app/views/search_results/index.html.erb
@@ -51,9 +51,9 @@
     </div>
 
     <div id="search_results_list" class="divide-y divide-slate-100 sm:mt-4 lg:mt-8 lg:border-t lg:border-slate-100">
-      <div>
+      <turbo-frame id="page_<%= @page.page %>" target="_top">
         <% if @page.prev %>
-          <div class="py-10 sm:py-12">
+          <div class="py-10 sm:py-12 hidden first:block">
             <div class="lg:px-8">
               <div class="lg:max-w-4xl">
                 <div class="flex justify-center mx-auto px-4 sm:px-6 md:max-w-2xl md:px-4 lg:px-0">
@@ -73,7 +73,8 @@
         <% end %>
 
         <% if @page.next %>
-          <div>
+          <%= tag.turbo_frame id: "page_#{@page.next}", src: pagy_url_for(@page, @page.next), loading: "lazy",
+                data: {turbo_action: "replace", controller: "element", action: "turbo:frame-load->element#replaceWithChildren"} do %>
             <div class="py-10 sm:py-12">
               <div class="lg:px-8">
                 <div class="lg:max-w-4xl">
@@ -87,9 +88,9 @@
                 </div>
               </div>
             </div>
-          </div>
+          <% end %>
         <% end %>
-      </div>
+      </turbo-frame>
     </div>
   </div>
 <% end %>
```
---

We set `[data-turbo-action]` to `replace` in order to [_replace_][]
visit history while scrolling. In other words, if the user were to click
the back button, the browser would not navigate to the previous page,
but instead would navigate to the previously visited page.

[Turbo Frames]: https://turbo.hotwired.dev/handbook/frames
[Stimulus]: https://stimulus.hotwired.dev
[_replace_]: https://turbo.hotwired.dev/handbook/drive#application-visits


```js
import ApplicationController from "controllers/application_controller"

export default class extends ApplicationController {
  replaceWithChildren() {
    this.element.replaceWith(...this.element.children)
  }
}
```


