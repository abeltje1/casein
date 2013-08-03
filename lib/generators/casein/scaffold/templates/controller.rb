# Scaffolding generated by Casein <%= casein_get_full_version_string %>

module Casein
  class <%= class_name.pluralize %>Controller < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = '<%= plural_name.humanize.capitalize %>'
  		@<%= plural_name %> = <%= class_name %>.paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View <%= singular_name.humanize.downcase %>'
      @<%= singular_name %> = <%= class_name %>.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new <%= singular_name.humanize.downcase %>'
    	@<%= singular_name %> = <%= class_name %>.new
    end

    def create
      @<%= singular_name %> = <%= class_name %>.new <%= singular_name %>_params
    
      if @<%= singular_name %>.save
        flash[:notice] = '<%= singular_name.humanize.capitalize %> created'
        redirect_to casein_<%= @plural_route %>_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new <%= singular_name.humanize.downcase %>'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update <%= singular_name.humanize.downcase %>'
      
      @<%= singular_name %> = <%= class_name %>.find params[:id]
    
      if @<%= singular_name %>.update_attributes <%= singular_name %>_params
        flash[:notice] = '<%= singular_name.humanize.capitalize %> has been updated'
        redirect_to casein_<%= @plural_route %>_path
      else
        flash.now[:warning] = 'There were problems when trying to update this <%= singular_name.humanize.downcase %>'
        render :action => :show
      end
    end
 
    def destroy
      @<%= singular_name %> = <%= class_name %>.find params[:id]

      @<%= singular_name %>.destroy
      flash[:notice] = '<%= singular_name.humanize.capitalize %> has been deleted'
      redirect_to casein_<%= @plural_route %>_path
    end
  
    private
      <%
          permit_list = ""
          attributes.each_with_index {|attribute|
            permit_list += ", " unless permit_list.empty?
            permit_list += ":#{attribute.name}"
          }
      %>
      def <%= singular_name %>_params
        params.require(:<%= singular_name %>).permit(<%= permit_list %>)
      end

  end
end