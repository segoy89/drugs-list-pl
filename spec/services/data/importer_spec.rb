# frozen_string_literal: true

RSpec.describe Data::Importer, :service do
  it 'initialize puller as MedsPuller kind' do
    expect(subject.instance_variable_get(:@puller)).to be_a(Data::MedsPuller)
  end

  describe '#call' do
    before do
      allow_any_instance_of(Data::MedsPuller).to receive(:get_overall).and_return(nil)
      allow_any_instance_of(Data::MedsPuller).to receive(:meds).and_return(csv_sample)
    end

    let(:csv_sample) do
      "\"Identyfikator Produktu Leczniczego\";\"Nazwa Produktu Leczniczego\";\"Nazwa powszechnie stosowana\";\"Rodzaj preparatu\";\"Nazwa poprzednia produktu\";\"Gatunki docelowe\";\"Okres karencji\";\"Moc\";\"Posta\xC4\x87 farmaceutyczna\";\"Typ procedury\";\"Numer pozwolenia\";\"Wa\xC5\xBCno\xC5\x9B\xC4\x87 pozwolenia\";\"Kod ATC\";\"Podmiot odpowiedzialny\";\"Opakowanie\";\"Substancja czynna\";\"Nazwa wytw\xC3\xB3rcy\";\"Kraj wytw\xC3\xB3rcy\";\"Nazwa importera\";\"Kraj importera\";\"Podmiot odpowiedzialny w kraju eksportu\";\"Kraj eksportu\";\"Ulotka\";\"Charakterystyka\"\n\"100000014\";\"Zoledronic acid Fresenius Kabi\";\"Acidum zoledronicum\";\"Ludzki\";\"\";\"\";\"\";\"4 mg/5 ml\";\"Koncentrat do sporz\xC4\x85dzania roztworu do infuzji\";\"DCP\";\"20708\";\"Bezterminowe\";\"M05BA08\";\"Fresenius Kabi Polska Sp. z o.o.\";\"05909991023652 \xC2\xA6 Rpz \xC2\xA6 2\n1 fiol. 5 ml\n05909991023676 \xC2\xA6 Rpz \xC2\xA6 4\n10 fiol. 5 ml\n05909991023669 \xC2\xA6 Rpz \xC2\xA6 3\n4 fiol. 5 ml\";\"Acidum zoledronicum 4 mg/5 ml\";\"Fresenius Kabi Austria GmbH\";\"Austria\";\"\";\"\";\"\";\"\";\"https://rejestrymedyczne.ezdrowie.gov.pl/api/rpl/medicinal-products/1/leaflet\";\"https://rejestrymedyczne.ezdrowie.gov.pl/api/rpl/medicinal-products/1/characteristic\""
    end

    it 'creates entity in products table' do
      expect { subject.call }.to change(Product, :count).by(1)
    end
  end
end
