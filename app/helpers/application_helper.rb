module ApplicationHelper
  def cloudinary_configured?
    Cloudinary.config&.cloud_name.present?
  rescue NameError
    false
  end

  def cloudinary_or_active_storage_image_tag(attachment, default:, **options)
    return image_tag(default, **options) unless attachment

    if cloudinary_configured?
      cl_image_tag attachment.key, **options
    else
      image_tag url_for(attachment), **options
    end
  rescue StandardError => e
    Rails.logger.warn("Image rendering failed: #{e.class}: #{e.message}")
    image_tag(default, **options)
  end
end
