module ButtonHelper
  
  # Example: 
  # = nav_bar :brand => "Filmdatenbank", :responsive => false, :fluid => true do
  #     = menu_group :pull => :right do
  #       = navsearchfield params[:by_plot].nil?  ? "Inhaltsuche" : params[:by_plot],  {:id => "plotsearch"}, "by_plot"
	#
	# or
	#
  # %div{:class=>'navbar'}
  #    %ul{:class=>'nav pull-right'}
  #       = navsearchfield params[:by_name].nil?  ? "Spielersuche" : params[:by_name],  {:id => "playersearch"}, "by_name"
  
  # for autocompletion use the following javascript:
  # $(document).ready(function() {
  #   return $('#playersearch').typeahead({
  #     source: function(typeahead, query) {
  #       var _this = this;
  #       if (query.length >= 2) return $.ajax({
  #         url: "/ajax/autocomplete/playersearch/" + query,
  #         success: function(data) {
  #           return typeahead.process(data);
  #         }
  #       });
  #     },
  #     property: "name"
  #   });
  # });
  
  # or coffeescript:
  # $(document).ready ->
  #   $("#playersearch").typeahead
  #     source: (typeahead, query) ->
  #       _this = this
  #       if query.length >= 2
  #         $.ajax
  #           url: "/ajax/autocomplete/playersearch/" + query
  #           success: (data) ->
  #             typeahead.process data
  #     property: "givenname"
  
	
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