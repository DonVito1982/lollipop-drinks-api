# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

LOCALHOST_REGEX = %r{\Ahttp:\/\/localhost(:300\d)?\z}.freeze

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # it cannot be '*', not even for testing purposes
    # because credentials won't work with that
    hosts = []
    hosts << LOCALHOST_REGEX if Rails.env.development?
    hosts.concat(ENV["CORS_ORIGINS"].split(",").map(&:strip)) if ENV.key?("CORS_ORIGINS")

    origins hosts

    resource "*",
      headers: :any,
      credentials: true,
      methods: %i[get post put patch delete options head],
      expose: %w[X-Page X-Per-Page X-Total Content-Disposition]
  end
end
