module Railstrap

  class Railtie < Rails::Railtie
    initializer "railstrap.initialize" do
    end
  end

end

ActiveSupport.on_load(:action_controller) do
  include Railstrap::ActionController
end
