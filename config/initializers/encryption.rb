Rails.application.configure do
  # Generate encryption keys for development (use proper key management in production)
  if Rails.env.development? || Rails.env.test?
    config.x.contact_encryption_key = "a" * 32  # Use a proper 32-byte key in production
    config.x.document_encryption_key = "b" * 32  # Use a proper 32-byte key in production
  end
end