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

## SASS

We're using SASS for the CSS.  You __should not__ edit the CSS files
manually.  Instead, edit the SASS files and run `rake sass:watch` to
have it automatically compile your SASS files to CSS as you save changes
to the SASS files.

## Reference

For Mustache (logic-less HTML templates), check:

* [Man Page](http://mustache.github.com/mustache.5.html)
* [Github README](https://github.com/defunkt/mustache)

For SASS (the CSS precompiler), check:

* [SASS Reference](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html)
* [Indented Syntax Guide](http://sass-lang.com/docs/yardoc/file.INDENTED_SYNTAX.html)

For Capybara (the browser simulator used by the acceptance specs),
check the [Github README](https://github.com/jnicklas/capybara).

## Usage from an SEO Moz application

You may want to review [a commit](https://github.com/seomoz/cmoz/commit/25485a1d2935e817f9bcaba4d154299bcc26dc02)
demonstrating these steps for turbo.

1. Add the MozNav gem to the Gemfile, using a `:git` source.  Run `bundle
   install` to install the gem.
2. Symlink in the asset dirs (`rake moz_nav:symlink_assets
   ASSET_ROOT=./public`).  This rake task will be automatically available
   to rails 3 applications.  Otherwise, you can add `load 'moz_nav/tasks/moz_nav.rake'`
   to your Rakefile.  You'll probably want to gitignore the symlinked dirs
   (using a pattern like `public/**/moz_nav`) since the symlinks use
   absolute paths.
3. Configure MozNav.  In rails, you'll probably want to do this in
   `config/initializers/moz_nav.rb`.  Example code:

   <pre>
   MozNav.configure do |c|
     c.seomoz_host = 'www.seomoz.org'
     c.environment = 'development'
   end
   </pre>

   (Note that both of these settings are optional as MozNav uses
   appropriate defaults for both, but this demonstrates configuration).

4. Use the provided RSpec shared example group to test compliance with
   the MozNav gem.  Example:

   <pre>
   require 'spec_helper'
   require 'moz_nav/rspec'

   describe ApplicationController do
     it_behaves_like "the MozNav rendering context" do
       let(:render_context) do
         described_class.new.tap { |c| c.instance_eval { @current_user = Factory.create(:pro_user) } }
       end
     end
   end
   </pre>

   Basically, this tests that the rendering context has access to a
   `current_user` helper method, and that the user object returned by
   the method conforms to the interface MozNav expects.
5. Include the `MozNav::RenderHelper` module in the appropriate
   rendering context.  In rails you'll probably just want to add
   `include MozNav::RenderHelper` to the `ApplicationHelper` module;
   in sinatra you can just use `helpers MozNav::RenderHelper`.
6. Call the appropriate rendering helpers from your application layout.
    * `nav_header_includes` should be called from the `<head>` of the
      page.
    * `render_nav_header` should be called where you want the header
      to be.  It yields an object that allows you to configure the
      header.
    * `render_nav_footer` should be called where you want the footer
      to be.
    * `nav_footer_includes` should be called just before the closing
      `</body>` tag.

