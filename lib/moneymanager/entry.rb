require 'digest/sha1'
module Moneymanager
  class Entry
    attr_accessor :id, :date, :reason, :amount, :company, :raw, :approved, :custom_category, :tag, :note

    def initialize
      amount = 0
      approved = false
    end

    def digest
      Digest::SHA1.hexdigest(@raw)
    end

    def to_s
      "Date: #{@date}, #{reason}, #{amount}, #{company} #{custom_type}"
    end

    def formatted_approved
      if approved
        '✔︎'.green
      else
        '✖︎'.red
      end
    end

    def formatted_is_bank_tranfer
      if bank_transfer?
        '♻︎'.yellow
      else
        ''
      end
    end

    def money_amount
      cents = amount.to_f * 100
      Money.new(cents, 'EUR')
    end

    def formatted_date
      date.strftime("%d.%m.%y")
    end

    def formatted_reason
      reason[0...80]
    end

    def formatted_amount
      amount.to_s + ' €'
    end

    def expense?
      amount < 0 && custom_category.nil?
    end

    def income?
      amount > 0 && custom_category.nil?
    end

    def bank_transfer?
      return (custom_category == "bank_transfer")
    end

    def bank_transfer=(value)
      self.custom_category = value ? "bank_transfer" : ''
    end
  end
end
