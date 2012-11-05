module ButtonHelper
  
  def navsearchfield(searchstring,options,inputname)
    capture_haml do
      haml_tag :li do
        haml_tag :form, {:class => 'navbar-search', :autocomplete => "off", :method => :get}.merge(options.select{|k,v| [:action].include?(k)}) do
          haml_tag :div, {:class => "input-prepend"} do
            haml_tag :span, {:class => "add-on"} do
              haml_concat railstrap_image "icon-search"
            end
            haml_tag :input, {:type => 'text', :class => 'search-query span2', :placeholder => searchstring, :name => inputname}.merge(options.select{|k,v| ![:action].include?(k)})
          end
        end
      end
    end
  end
  
end