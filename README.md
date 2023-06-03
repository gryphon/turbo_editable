# TurboEditable

In-place editor for your app

## Installation

* Add helpers to your application controller: ```helper TurboEditable::ApplicationHelper```
* Add CSS: ```@import "turbo_editable/editable.css";```

## Usage

Gem provides helpers for both show and edit (form) views. 

Show helpers provide wrappers for your field values to allow partial rendering form from your edit action.

Edit/form helpers provide wrappers which will filter your form to output just the required field for your editable.

## Form helpers

Use ```editable_input``` helper around input to allow using it from editable

    = form_for(@airport) do |f|
      = editable_input @airport, :name do
        = f.input :name

Available options are:

* ```always_visible``` - read about it below

## Hiding non-required inputs on form

By default all inputs which are not required by model validation are not shown on the form for easier new object creation forms. After creating object user will be able to customize all editable-enabled fields via editing. This will make new/edit forms less complicated with only required fields.

You can disable this behaviour by explicitly setting ```always_visible = true``` on editable_input helper.

## Show helpers

Use generic ```editable``` helper around displayed value to allow field to be editable

    = editable @airport, :name do
      = @airport.name

This editable will choose editable type automatically

You can use direct editable type instead:

* ```editable_field``` - Full-featured editor of input from your from
* ```editable_boolean``` - Quick switch on/off without rendering form

Options:

* ```if``` - if editable is enabled. True by default. Also uses Cancancan for checking if editing possible for current user. Read about Cancancan integration below.
* ```form_action``` - allows to override form action name. ```edit``` by default
* ```url``` - if you have custom update method URL pass it here
* ```edit_url``` - if you have custom edit url pass it here
* ```nullify``` - set true to include additional one-click "remove" button

## Cancancan integration

By default editable checks if current user can edit the object and automatically disabled editable if not

You can explicitly set ```if``` param to enable or disable editable feature.

## Using with inherited resources and namespaces

Editable will automatically detect if you use namespaced route and will load all the URLs within this namespace. 

If you have inherited resource you have to pass both objects as your model: 

    = editable [@country, @airport], :name do
      = @airport.name

Currently editable supports only one namespace and one inheritance levels.