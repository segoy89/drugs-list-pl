# frozen_string_literal: true

class DrugsList < Roda
  route do |r|
    response['Content-Type'] = 'application/json'
    r.on 'api' do
      r.on 'v1' do
        r.get 'medicaments' do
          meds = ProductsLookup.new(params: r.params).call
          r.halt if meds.empty?

          Product.to_json(array: meds)
        end
      end
    end
  end
end
