module Remote
  class Movie < Flexirest::Base
    proxy :json_api
    get :find, "/movies/:id"
    ATTRIBUTES = %w[plot rating poster]

    ATTRIBUTES.each do |attr|
      define_method(attr) { data&.attributes&.to_hash&.fetch(attr) }
    end
  end
end
