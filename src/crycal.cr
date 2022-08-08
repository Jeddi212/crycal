require "../lib/iu/src/iu"

require "../lib/iu/examples/control_gallery/**"

# :nodoc:
module ControlGallery
  # Define a global component storage
  COMPONENTS = {} of String => Iu::Component

  # :nodoc:
  class Application < Iu::Application
    include Iu::Components

    def initialize_component
      # Menu bar for the application
      file_menu = Menu.new "File"
      open_item = file_menu.append_item "Open"
      save_item = file_menu.append_item "Save"
      file_menu.append_quit_item

      edit_meu = Menu.new "Edit"
      edit_meu.append_check_item "Checkable Item"
      disabled_item = edit_meu.append_item "Disabled Item"
      disabled_item.disable
      edit_meu.append_preferences_item

      help_menu = Menu.new "Help"
      help_menu.append_item "Help"
      help_menu.append_about_item

      window =
        Iu::Components::Window.new(
          title: "Control gallery",
          width: 1200,
          height: 600,
          menu_bar: true
        )

      COMPONENTS["MainWindow"] = window

      window.margined = true

      window
        .adopt(
          VerticalBox
            .new(padded: true)
            .adopt(
              HorizontalBox
                .new(padded: true)
                .adopt(
                  BasicControlsComponent.new,
                  stretchy: true
                )
                .adopt(
                  VerticalBox
                    .new(padded: true)
                    .adopt(
                      NumbersComponent.new,
                    )
                    .adopt(
                      ListsComponent.new
                    ),
                  stretchy: true
                ),
              stretchy: true
            )
        )

      window.closing.on do
        exit(0)
      end

      window.show
    end
  end
end

app = ControlGallery::Application.new

app.should_quit.on do
  exit(0)
end

app.startrequire "iu"

module Example
  include Iu::Components

  # Ability to reuse components extracted to other classes.
  class MyComponent < Iu::ReusableComponent
    def initialize(@id : Int32); end

    def render : Iu::Component
      Group
        .new(title: "MyComponent", margined: true)
        .adopt(
          VerticalBox
            .new(padded: true)
            .adopt(
              Label.new(text: "Hello, World ##{@id}!"),
              stretchy: true
            )
            .adopt(
              Button.new(text: "Click Me!"),
              stretchy: true
            )
        )
    end
  end

  # :nodoc:
  class Application < Iu::Application
    def initialize_component
      window =
        Window.new(
          title: "Example",
          width: 800,
          height: 600,
          menu_bar: false
        )
      
      window.margined = true

      window
        .adopt(
          HorizontalBox
            .new(padded: true)
            .adopt(
              MyComponent.new(1),
              stretchy: true
            )
            .adopt(
              MyComponent.new(2),
              stretchy: true
            )
            .adopt(
              MyComponent.new(3),
              stretchy: true
            )
        )

      window.closing.on do
        exit(0)
      end
      
      window.show
    end
  end
end

app = Example::Application.new

app.should_quit.on do
  exit(0)
end

app.start
