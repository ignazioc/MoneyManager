require 'digest/sha1'
module Moneymanager
  class Entry
    attr_accessor :date, :reason, :amount, :company, :raw, :approved, :tag

    def initialize
      @approved = false
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

    def formatted_amount
      s = amount.to_s + ' €'
      amount < 0 ? s.red : s.green
    end

    def is_expense
      amount < 0
    end
    def is_income
      !is_expense
    end
    
  end
end
