require "iu"

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
