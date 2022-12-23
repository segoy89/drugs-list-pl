# frozen_string_literal: true

module Data
  class MedsPuller
    include HTTParty
    base_uri 'https://rejestrymedyczne.ezdrowie.gov.pl'

    attr_reader :meds

    def get_overall
      @meds = self.class.get('/api/rpl/medicinal-products/public-pl-report/get-csv')&.body
      nil
    end
  end
end
