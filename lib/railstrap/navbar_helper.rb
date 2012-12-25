module NavbarHelper
  
  module ViewHelpers
    
    # see gem rails_bootstrap_navbar also
    
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
    

	  def nav_bar(options={}, &block)
			nav_bar_div(options[:fixed]) do
				navbar_inner_div do
					container_div(options[:brand], options[:brand_link], options[:responsive], options[:fluid]) do
						yield if block_given?
					end
				end
			end
	  end

	  def menu_group(options={}, &block)
			pull_class = " pull-#{options[:pull].to_s}" if options[:pull].present?
			content_tag(:ul, :class => "nav#{pull_class}", &block)
	  end

	  def menu_item(name, path="#", *args)
			options = args.extract_options!
			content_tag :li, :class => is_active?(path) do
				link_to name, path, options
			end
	  end

	  def drop_down(name,path=nil)
      classes = ["dropdown"]
      classes << is_active?(path)
      content_tag :li, :class => classes do
        drop_down_link(name) + drop_down_list {yield}
      end
	  end

	  def drop_down_divider
			content_tag :li, "", :class => "divider"
	  end

	  def drop_down_header(text)
			content_tag :li, text, :class => "nav-header"
	  end

	  def menu_divider
			content_tag :li, "", :class => "divider-vertical"
	  end

	  def menu_text(text=nil, options={}, &block)
			pull = options.delete(:pull)
			pull_class = pull.present? ? "pull-#{pull.to_s}" : nil
			options.append_merge!(:class, pull_class)
			options.append_merge!(:class, "navbar-text")
			content_tag :p, options do
				text || yield
			end
	  end

	  private

	  def nav_bar_div(fixed, &block)
			content_tag :div, :class => nav_bar_css_class(fixed) do
				yield
			end
	  end

	  def navbar_inner_div(&block)
			content_tag :div, :class => "navbar-inner" do
				yield
			end
	  end

	  def container_div(brand, brand_link, responsive, fluid, &block)
			content_tag :div, :class => "container#{"-fluid" if fluid}" do
				container_div_with_block(brand, brand_link, responsive, &block)
			end
	  end

	  def container_div_with_block(brand, brand_link, responsive, &block)
			output = []
			if responsive == true
				output << responsive_button
				output << brand_link(brand, brand_link)
				output << responsive_div {capture(&block)}
			else
				output << brand_link(brand, brand_link)
				output << capture(&block)
			end
			output.join("\n").html_safe
	  end

	  def nav_bar_css_class(fixed_pos)
			css_class = ["navbar"]
			css_class << "navbar-fixed-#{fixed_pos.to_s}" if fixed_pos.present?
			css_class.join(" ")
	  end

	  def brand_link(name, url)
			return "" if name.blank?
			url ||= root_url
			link_to(name, url, :class => "brand")
	  end

	  def responsive_button
			%{<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </a>}
	  end

	  def responsive_div(&block)
			content_tag(:div, :class => "nav-collapse", &block)
	  end

	  def is_active?(path)
			"active" if current_page?(path)
	  end

	  def name_and_caret(name)
			"#{name} #{content_tag(:b, :class => "caret"){}}".html_safe
	  end

	  def drop_down_link(name)
			link_to(name_and_caret(name), "#", :class => "dropdown-toggle", "data-toggle" => "dropdown")
	  end

	  def drop_down_list(&block)
			content_tag :ul, :class => "dropdown-menu", &block
	  end
	  
	  
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
	
  
end


class Hash
	# appends a string to a hash key's value after a space character (Good for merging CSS classes in options hashes)
	def append_merge!(key, value)
		# just return self if value is blank
		return self if value.blank?

		current_value = self[key]
		# just merge if it doesn't already have that key
		self[key] = value and return if current_value.blank?
		# raise error if we're trying to merge into something that isn't a string
		raise ArgumentError, "Can only merge strings" unless current_value.is_a?(String)
		self[key] = [current_value, value].compact.join(" ")
	end
end