require 'test_helper'

describe Moneymanager::Entry do
  
  describe "when an Entry is created" do
  	entry = Moneymanager::Entry.new
    it "it must not be a bank transfer" do
    	entry.bank_transfer?.must_equal(false)
    end
    it "it must not be approved" do
    	entry.approved.must_equal(false)
    end
    it "it must have a zero amount" do
    	entry.amount.must_equal(0)
    end

  end

  describe "when an Entry is bank transfer" do
  	entry = Moneymanager::Entry.new
  	entry.bank_transfer = true
    it "it must not be an expense" do
    	entry.income?.must_equal(false)
    end
    it "it must not be an income" do
    	entry.expense?.must_equal(false)
    end
  end

  describe "when an entry has a different raw value" do
    entry1 = Moneymanager::Entry.new
    entry2 = Moneymanager::Entry.new
    entry1.raw = "xxxxx"
    entry2.raw = "yyyyy"
    
    it "also has a different digest" do
      entry1.digest.wont_equal(entry2.digest)
    end

  end

end