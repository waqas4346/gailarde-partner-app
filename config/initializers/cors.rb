Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Update this with specific origins if needed
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end