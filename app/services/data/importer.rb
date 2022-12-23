# frozen_string_literal: true

module Data
  class Importer
    def initialize
      @puller = Data::MedsPuller.new
    end

    def call
      puller.get_overall

      return if puller.meds.nil?

      parse_meds
      persist_meds
    end

    private

    attr_reader :csv, :puller

    def parse_meds
      @csv = CSV.parse(
        puller.meds,
        col_sep: ';',
        encoding: 'UTF-8',
        headers: true,
        header_converters: ->(h) { I18n.transliterate(h.downcase.gsub(' ', '_')).to_sym }
      )
      true
    end

    def persist_meds
      csv.each do |row|
        obj = row.to_h
        DB[:products].insert_conflict(target: [:identyfikator_produktu_leczniczego], update: obj).insert(obj)
      end
      true
    end
  end
end
