# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins "*"
    origins ENV["ASTRESONANCE_FRONT_ORIGIN_LOCAL"], ENV["ASTRESONANCE_FRONT_ORIGIN"]

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['access-token', 'client', 'uid', 'expiry']
  end
end
