module ButtonGroupHelper
	module ViewHelpers
	  
	  # example: 
    # = button_group "#meinmenu", "Mein Menu", "icon-list icon-white" do
    #       = button_group_drop_down_link "#edit", "Edit",   "icon-pencil"
    #       = button_group_drop_down_link "#delete","Delete", "icon-trash"
    #       = button_group_drop_down_link "#ban", "Ban",   "icon-ban-circle"
    #       = button_group_link_divider
    #       = button_group_drop_down_link "#make", "Make admin", "icon-user"

	  def button_group(primarytarget, primarytitle, primaryicon=nil, &block)
			button_group_div do
				primary_link primarytarget, primarytitle, primaryicon do
				  dropdown_links(&block)
				end
			end
	  end
	  
	  def button_group_link_divider
	    content_tag :li, nil, :class => "divider"
    end
    
    def button_group_drop_down_link(target, title, icon=nil, &block)
      content_tag :li do
        link_to target do
          options = {:class => "i"}
          options.merge!(:class => icon) unless icon.nil?
          content_tag :i, " #{title}", options
        end
      end
    end

    def button_group_div(&block)
      content_tag :div, :class => "btn-group" do
        yield
      end
    end

    def primary_link(primarytarget, primarytitle, primaryicon=nil, &block)
      link_to primarytarget, :class => "btn btn-primary" do
        options = {}
        options.merge!(:class => primaryicon) unless primaryicon.nil?
        res  = content_tag :i, nil, options
        res += " #{primarytitle}"
        res += yield
      end
    end

    def drop_down_list(&block)
      content_tag :ul, :class => "dropdown-menu", &block
    end
    
    def dropdown_caret(title=nil)
      link_to "#", :class => "btn btn-primary dropdown-toggle", :"data-toggle" => "dropdown" do
        content_tag :span, title, :class => "caret"
      end
    end

    def dropdown_links(&block)
      res  = dropdown_caret
      res += drop_down_list(&block)
    end
    
	end
end

