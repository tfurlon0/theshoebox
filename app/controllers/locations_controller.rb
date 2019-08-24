class LocationsController < ApplicationController
  def list
    @locations = Location.all

    render("location_templates/list.html.erb")
  end

  def details
    @location = Location.where({ :id => params.fetch("id_to_display") }).first

    render("location_templates/details.html.erb")
  end

  def blank_form
    @location = Location.new

    render("location_templates/blank_form.html.erb")
  end

  def save_new_info
    @location = Location.new

    @location.address = params.fetch("address")
    @location.image = params.fetch("image")
    @location.bio = params.fetch("bio")
    @location.name = params.fetch("name")

    if @location.valid?
      @location.save

      redirect_to("/locations", { :notice => "Location created successfully." })
    else
      render("location_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @location = Location.where({ :id => params.fetch("id_to_prefill") }).first

    render("location_templates/prefilled_form.html.erb")
  end

  def save_edits
    @location = Location.where({ :id => params.fetch("id_to_modify") }).first

    @location.address = params.fetch("address")
    @location.image = params.fetch("image")
    @location.bio = params.fetch("bio")
    @location.name = params.fetch("name")

    if @location.valid?
      @location.save

      redirect_to("/locations/" + @location.id.to_s, { :notice => "Location updated successfully." })
    else
      render("location_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @location = Location.where({ :id => params.fetch("id_to_remove") }).first

    @location.destroy

    redirect_to("/locations", { :notice => "Location deleted successfully." })
  end
  
  def map
    render("locations/map.html.erb")
  end
end
