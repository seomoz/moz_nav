# MozNav

This gem provides common navigational elements across all of our apps.

## Technical requirements

1. Compatibility with MRI 1.8.7 and 1.9.2.
2. No dependency on any particular Web Framework.
3. The templates must be usable from PHP for SEOMoz.

## Dev Environment Setup

Use [RVM](http://rvm.beginrescueend.com/) to install MRI 1.8.7 and
1.9.2. Then setup the necessary gems:

    rvm use 1.9.2
    rvm gemset create moz_nav
    rvm gemset use moz_nav
    gem install bundler -v=1.0.7
    bundle install

    rvm use 1.8.7
    rvm gemset create moz_nav
    rvm gemset use moz_nav
    gem install bundler -v=1.0.7
    bundle install

## Testing

Run `infinity_test`.  This will continuously run the specs against
1.8.7 and 1.9.2.

## Example App

There is an example sinatra app in the app folder.  It is used by
the specs.  You can also run it.  Run `rake example_app:serve`.
Visit it in your browser at [http://localhost:3000](http://localhost:3000).
