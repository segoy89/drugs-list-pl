# frozen_string_literal: true

class Product < Sequel::Model
  plugin :json_serializer, except: [:id]
end
