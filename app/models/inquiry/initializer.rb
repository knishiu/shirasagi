module Inquiry
  class Initializer
    Cms::Node.plugin "inquiry/form"
    Cms::Node.plugin "inquiry/node"
    Cms::Part.plugin "inquiry/mini"
  end
end
