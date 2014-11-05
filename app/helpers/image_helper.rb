module ImageHelper

  def display_thumbnail(object, image_association_name=:photo)

    if object.respond_to?(image_association_name) && object.send(image_association_name)
      return image_tag object.send(image_association_name).image.thumbnail.url, :class=>"img-thumbnail"
    else
      return image_tag "http://placehold.it/100x100", :class=>"img-thumbnail"
    end

  end

  def display_image(object, image_association_name=:photo, width=80)

    if width.is_a?(String)
      if width.include?("px")
        width_val = width.split("px").first
      elsif width.include?("%")
        width_val = width.split("%").first
      else
        width_val = width.to_i
      end
      width_string = width
    else
      width_val = width
      width_string = "#{width.to_i}px"
    end

    if object.respond_to?(image_association_name) && object.send(image_association_name)
      return image_tag object.send(image_association_name).image_url, :style=>"width:#{width_string};"
    else
      return image_tag "http://placehold.it/#{width_val}x#{width_val}", :class=>"img-thumbnail"
    end
  end

  def display_photo(photo, width=100)
    return image_tag photo.image_url, :style=>"width:#{width}px;", :width=>"#{width}", :class=>"img-thumbnail"
  end

  ## Returns new image url or edit existing image url based on object is associated with image or not
  # == Examples
  #   >>> trust_logo_link(object, redirect_url, :image_association_name)
  #   => "/super_admin/images/new" OR
  #   => "/super_admin/images/1/edit"
  def upload_image_link(object, redirect_url, image_association_name = :trust_logo)

    image_object = nil
    image_object =  object.send(image_association_name) if object.respond_to?(image_association_name)

    if image_object && image_object.persisted?
      edit_super_admin_image_path(image_object,
                                 :redirect_url => redirect_url,
                                 :imageable_id => object.id,
                                 :imageable_type => object.class.to_s,
                                 :image_type => image_object.class.name)
    else
      image_object = object.send("build_#{image_association_name}")
      new_super_admin_image_path(:redirect_url => redirect_url,
                                 :imageable_id => object.id,
                                 :imageable_type => object.class.to_s,
                                 :image_type => image_object.class.name)
    end

  end

end
