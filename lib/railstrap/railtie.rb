module Railstrap
  class Railtie < Rails::Railtie
    initializer "railstrap.initialize" do
    end
  end
end


module ButtonGroupHelper
  class Railtie < Rails::Railtie
    initializer "railstrap.ButtonGroupHelper.initialize" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end


module NavbarHelper
  class Railtie < Rails::Railtie
    initializer "railstrap.NavbarHelper.initialize" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end


ActiveSupport.on_load(:action_controller) do
  include Railstrap::ActionController
end
