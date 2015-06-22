# Changelog

## 0.0.2

* Custom component objects auto-loaded from `app/components`.
* Made `component` helper availble in controllers
* Default to rendering templates from `app/views/components`
* Deprecated rendering partials from `app/views/components`

## 0.0.1

* New view helper `component(name, options = {})`
* Defaults to rendering partials from `app/views/components`
* Passes `options` into partial as a local variable
