require 'test_helper'
require 'date'

describe Moneymanager::Archiver do
  # fixture_path = File.join(Dir.pwd, 'test', 'fixtures')


  describe 'when a new archive is created' do
    archiver = Moneymanager::Archiver.new(Dir.mktmpdir)

    it 'doesn\'t have any entry' do
      archiver.all_entries.count.must_equal(0)
    end
  end
end