# Atomic Assets

* Standard system for managing atomic assets in Rails.
* View helper for rendering reusable atomic components.

## What are "atomic assets?"

The idea of "atomic design" is catching on in the UI/UX world. Programs such as Sketch allow designers to build the look and feel of an application in reusable pieces. Naturally, these pieces needed a nickname. Atoms, molecules, and organisms are the lingo of the atomic UI/UX designer. But those modular pieces that make up the design have to find their way to front-end code. That's where atomic_assets comes in.

Atomic assets are the modular components that make up an atomically designed web application. Developers need not worry too much about the semantics of an atom vs an organism. We will just call them "components." The atomic_assets gem provides a lightweight set of tools and conventions to keep your Rails application DRY and your components at your fingertips.

## Installation

Just add `gem 'atomic_assets'` to your Gemfile and run `bundle install`!

## Usage

### Create your components

Dump your component templates into the `app/views/components/` directory of your site. They can be any template language that Rails understands!

Example: "app/views/components/banner.html.slim"

```slim
.banner
  h2
    = options[:title]
  .banner-content
    = options[:content]
```

### Render components in your views

Use the `component(name, options = {})` helper to output component templates in any view.

Example: "app/views/home/index.html.slim"

```slim
= component(:banner, title: 'Hello World')
  p Block content will be passed into :content
  p This makes component wrappers a piece of cake!
```

### Components are useful other places, too

Components can be used in any view context. You can use them in layouts...

```slim
html
  head
    title My Site
  body
    = component :header
    = yield
    = component :footer
```

...inside of other components...

```slim
.catalog
  h2 Catalog
  .items
    - options[:items].each do |item|
      = component(:catalog_item, item: item)
```

...or even render them from your controller.

```ruby
class CatalogController
  def index
    items = CatalogItem.all
    render html: component(:catalog, items: items)
  end
end
```

## But wait, there's more!

These are the building blocks for a robust atomic assets engine. Future features will include: customizable component classes, isolated view helpers, CSS and JavaScript integration, generators, serialization, component-powered content management, and a living style guide to preview your components.
