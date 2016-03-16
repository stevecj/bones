# Compass is a great cross-platform tool for compiling SASS. 
# This compass config file will allow you to 
# quickly dive right in.
# For more info about compass + SASS: http://net.tutsplus.com/tutorials/html-css-techniques/using-compass-and-sass-for-css-in-your-next-project/

require 'json'

module Bones
  module Sass

    class << self
      def config
        @config ||= load_defaults_config['defaults']
      end

      private

      def load_defaults_config
        scss_dir_path = File.dirname(__FILE__)
        template_path = File.join(scss_dir_path, '..', '..')
        config_defaults_path = File.join(template_path, 'config', 'defaults.json')
        File.open(config_defaults_path) { |io|
          JSON.load(io)
        }
      end
    end

  end
end

module Sass::Script::Functions

  def theme_config_color(section, option)
    assert_type section, :String
    assert_type option, :String

    option_text = Bones::Sass.config.
      fetch(section.value).
      fetch(option.value)

    Sass::Script::Value::Color.from_hex('#' + option_text)
  end

end

#########
# 1. Set this to the root of your project when deployed:
http_path = "/"

# 2. probably don't need to touch these
css_dir = "../css"
sass_dir = "./"
images_dir = "../images"
javascripts_dir = "../js"
environment = :development
relative_assets = true


# 3. You can select your preferred output style here (can be overridden via the command line):
output_style = :expanded

# 4. When you are ready to launch your WP theme comment out (3) and uncomment the line below
# output_style = :compressed

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false

# don't touch this
preferred_syntax = :scss
