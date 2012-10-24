module Railstrap
  
  module ActionController
     extend ActiveSupport::Concern

     included do
       helper        HelperMethods
     end

     protected
     
     module HelperMethods
      include MenuTabsHelper
      include ButtonHelper
      include ModalHelper
      include CollapsibleGroupHelper
     end
     
  end
      
end
