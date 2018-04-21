require 'test_helper'
require 'date'

describe Moneymanager::Parser do
  fixture_path = File.join(Dir.pwd, 'test', 'fixtures')

  describe 'when an empty file is parsed' do
    csv_path = File.join(fixture_path, 'fixture_empty.csv')
    parser = Moneymanager::Parser.new(csv_path)
    entries = parser.parse

    it 'must return an empty list of entries' do
      entries.count.must_equal(0)
      entries.wont_be_nil
    end
  end

  describe 'when the fixture with one line is parsed' do
    csv_path = File.join(fixture_path, 'fixture_one_line.csv')
    parser = Moneymanager::Parser.new(csv_path)
    entries = parser.parse

    it 'must return one array with one entry' do
      entries.count.must_equal(1)
    end

    it 'should create an entry based on the content of the CSV file' do
      entry = entries.first
      entry.date.must_equal(Date.parse('2017-09-20'))
      entry.reason.must_equal('THIS IS THE REASON')
      entry.amount.must_equal(1234.56)
      entry.company.must_equal('This is the name of the customer')
      str = 'xxxxxxx,20.09.17,20.09.17,GUTSCHRIFT AZV,THIS IS THE REASON,"","","","","","",This is the name of the customer,3500070000,BYLADEMM,"1234,56",EUR,Umsatz gebucht'
      entry.raw.must_equal(str)
    end
  end

  describe 'when the fixture contains an Umsatz vorgemerkt' do 
    csv_path = File.join(fixture_path, 'fixture_two_lines.csv')
    parser = Moneymanager::Parser.new(csv_path)
    entries = parser.parse

    it 'must return an array with only one element' do
      entries.count.must_equal(1)
    end

  end
end
