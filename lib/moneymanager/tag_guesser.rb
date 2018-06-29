module Moneymanager
  class TaggerGuesser
    attr_accessor :entries_list

    def initialize(list)
      @entries_list = list
    end

    def guess(entry)
      candidate = @entries_list.find do |obj|
        obj.company == entry.company
      end
      candidate.tag
    end
  end
end
