require 'csv'
require 'date'
module Moneymanager
  class Parser
    def keys
      %i[auftragskonto
         buchungstag
         valutadatum
         buchungstext
         verwendungszweck
         glaeubiger_id
         mandatsreferenz
         kundenreferenz_endtoend
         sammlerreferenz
         lastschrift_ursprungsbetrag
         auslagenersatz_ruecklastschrift
         beguenstigterzahlungspflichtiger
         kontonummeriban
         bic_swiftcode
         betrag
         waehrung
         info]
    end

    def initialize(f)
      @local_file = f
    end

    def parse
      options = { headers: true, return_headers: false, header_converters: :symbol, converters: :all, col_sep: ';' }
      entries = []
      invalid = 0
      CSV.foreach(@local_file, options) do |row|
        if row[:info] == 'Umsatz gebucht'
          entry = Entry.new
          entry.date = Date.strptime(row[:buchungstag], '%d.%m.%y')
          entry.reason = row[:verwendungszweck].squeeze(' ')
          entry.amount = row[:betrag].to_s.tr(',', '.').to_f
          entry.company = row[:beguenstigterzahlungspflichtiger].squeeze(' ')
          entry.raw = row.to_csv.gsub(/\s+/, "")
          entries << entry
        else
          invalid += 1
        end
      end
      puts "Invalid: #{invalid}"
      entries
    end
  end
end
