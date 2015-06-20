# Atomic Assets

* System for organizing atomic assets in Rails.
* View helper for rendering reusable atomic components.
* Classes to encapsulate component logic.

## What are "atomic assets?"

A new methodology known as "Atomic Design" is catching on with UI/UX designers. The latest design software allows designers to build the look and feel of an application in modular pieces. Naturally, these pieces needed a nickname. Atoms, molecules, and organisms are the lingo of the atomic UI/UX designer, named in order of increasing complexity. Eventually, the pieces that make up each design have to find their way to front-end code. That's where atomic assets comes in...

Atomic assets are the files used to build out atomic designs within your application. In Rails these are view partials, helpers, style sheets, and other assets. Developers need not worry too much about the semantics of a molecule versus an organism. We will just call each unique partial a "component." By modularizing your partials and styles, views become lighter and more reusable.

In short, the Atomic Assets gem provides a lightweight set of tools and conventions to keep your Rails views and styles DRY and your components at your fingertips.

For more information on Atomic Design, see http://patternlab.io/about.html

## Installation

Within your Rails application, just add `gem 'atomic_assets'` to your Gemfile and run `bundle install`

## Usage

### Create component templates

Dump your component templates into the `app/views/components` directory of your site. Any options you pass to a component will be made available to its template. Templates can be in any view format that Rails understands!

```slim
/ app/views/components/banner.html.slim
.banner
  h2
    = options[:title]
  .banner-content
    = options[:content]
```

### Render components in your views

Use the `component(name, options = {})` helper to output component templates with the provided options. Passing a block will capture its output in the `:content` option.

```slim
/ app/views/home/index.html.slim
= component(:banner, title: 'Hello World')
  p Block content will be passed into :content
  p This makes wrapper components a piece of cake!
```

### Components are useful other places, too

You can use them in layouts...

```slim
/ app/views/layouts/application.html.slim
html
  head
    title My Site
  body
    = component(:header)
    = yield
    = component(:footer)
```

...inside of other component templates...

```slim
/ app/views/components/catalog.html.slim
.catalog
  h2 Catalog
  .items
    - options[:items].each do |item|
      = component(:catalog_item, item: item)
```

...or even render them from your controller.

```ruby
# app/controllers/catalog_controller.rb
class CatalogController < ApplicationController
  def index
    items = CatalogItem.all
    render html: component(:catalog, items: items), layout: true
  end
end
```

### Component objects

You can also define your own component classes with custom render logic. Component classes extend `AtomicAssets::Component` and are auto-loaded from your `app/components` directory. You can change the rendering behavior of your component by overriding the `render` method in your component class.

```ruby
# app/components/back_button_component.rb
class BackButtonComponent < AtomicAssets::Component
  def render
    h.link_to(button_text, back_url, class: 'button')
  end

  private

  def back_url
    h.url_for(:back)
  end

  def button_text
    options[:text] || 'Back'
  end
end
```

Above the `h` method gives us access to all our view helpers from inside the component object. Component classes render just like their template counterparts using the `component(:back_button)` method call. In fact, component views without classes have their classes inferred at runtime. Since components are objects, they can easily be enhanced through concerns or other object-oriented techniques.

You can choose whether you want to use basic component templates or advanced components objects with custom rendering logic.

## Haven't I seen this before?

You may have seen view-model gems such as Cells. And decorator gems such as Draper. The difference between those gems and Atomic Assets, is that the components built with Atomic Assets are only meant to isolate templates and their presentation logic. They are not dependent on wrapped model instances, but on options that you provide. Components are meant to be nested, reused dozens of times, and fed tons of content. But they still play nicely with Draper, Cells, and most any view helper. So there is no reason why you can't pass in a decorated `Product` instance or render a component from a view-model. Components have one purpose: to keep your views modular and DRY.

## But wait, there's more!

These are the building blocks for a robust atomic assets engine. Future features will include:

* Component attributes
* Component generators
* Component namespaces
* Isolated view helpers
* Template inheritance
* Style sheet organization
* JavaScript integration
* Preset components for common tasks

And some additional gems:

* Component powered CMS
* Living style guide to preview your components
