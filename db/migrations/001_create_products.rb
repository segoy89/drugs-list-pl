# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :products do
      primary_key :id
      column :identyfikator_produktu_leczniczego, String, unique: true
      column :nazwa_produktu_leczniczego, String, index: true
      column :nazwa_powszechnie_stosowana, String, index: true
      column :rodzaj_preparatu, String
      column :nazwa_poprzednia_produktu, String, index: true
      column :gatunki_docelowe, String
      column :okres_karencji, String
      column :moc, String
      column :postac_farmaceutyczna, String
      column :typ_procedury, String
      column :numer_pozwolenia, String
      column :waznosc_pozwolenia, String
      column :kod_atc, String
      column :podmiot_odpowiedzialny, String
      column :opakowanie, String
      column :substancja_czynna, String
      column :nazwa_wytworcy, String, index: true
      column :kraj_wytworcy, String
      column :nazwa_importera, String
      column :kraj_importera, String
      column :podmiot_odpowiedzialny_w_kraju_eksportu, String
      column :kraj_eksportu, String
      column :ulotka, String
      column :charakterystyka, String
    end
  end
end
