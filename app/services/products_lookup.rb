# frozen_string_literal: true

class ProductsLookup
  WHITELISTED_PARAMS = ['name', 'manufacturer']

  def initialize(params:)
    @params = params
  end

  def call
    return [] if whitelisted_params.values.all?(&:blank?)

    collection = Product
    whitelisted_params.each do |param, value|
      next if value.blank?

      case param
      when 'name'
        collection = collection.where(nazwa_produktu_leczniczego: params['name']).or(nazwa_powszechnie_stosowana: params['name'])
      when 'manufacturer'
        collection = collection.where(podmiot_odpowiedzialny: params['manufacturer']).or(nazwa_wytworcy: params['manufacturer'])
      end
    end
    collection.all
  end

  private

  attr_reader :params

  def whitelisted_params
    @whitelisted_params ||= params.select { |key, _v| WHITELISTED_PARAMS.include? key }
  end
end
