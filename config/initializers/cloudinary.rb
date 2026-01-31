cloudinary_config = Rails.application.credentials.cloudinary || {}

Cloudinary.config do |config|
  config.cloud_name = cloudinary_config[:cloud_name] || ENV["CLOUDINARY_CLOUD_NAME"]
  config.api_key = cloudinary_config[:api_key] || ENV["CLOUDINARY_API_KEY"]
  config.api_secret = cloudinary_config[:api_secret] || ENV["CLOUDINARY_API_SECRET"]
  config.secure = true
  config.cdn_subdomain = true
end

if Rails.env.production? && Cloudinary.config.cloud_name.blank?
  Rails.logger.warn("Cloudinary is configured as the active storage service but CLOUDINARY credentials are missing.")
end
