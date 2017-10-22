require 'digest/sha1'
module Moneymanager
  class Entry
    attr_accessor :date, :reason, :amount, :company, :raw, :approved, :tag, :bank_transfer

    def initialize
      @approved = false
      @bank_transfer = false
    end

    def digest
      Digest::SHA1.hexdigest(@raw)
    end

    def to_s
      "Date: #{@date}, #{reason}, #{amount}, #{company}"
    end

    def formatted_approved
      if approved
        '✔︎'.green
      else
        '✖︎'.red
      end
    end

    def formatted_is_bank_tranfer
      if bank_transfer
        '♻︎'.yellow
      else
        ''
      end
    end

    def formatted_amount
      s = amount.to_s + ' €'
      amount < 0 ? s.red : s.green
    end

    def expense?
      amount < 0 && !bank_transfer
    end

    def income?
      amount > 0 && !bank_transfer
    end
  end
end
