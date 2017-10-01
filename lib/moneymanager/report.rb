class Report
	
  def print_global_report(entries)
    expenses = entries.reject(&:income?).map(&:amount).reduce(:+)
    incomes = entries.reject(&:expense?).map(&:amount).reduce(:+)
    Layout.print_summary(incomes, expenses)
  end

  def print_all_categories_report(entries)
    expenses = entries.reject(&:income?).each_with_object(Hash.new(0)) do |current, sum|
      tag = current.tag ||= 'Unknown'
      sum[tag] += current.amount
    end
    incomes = entries.reject(&:expense?).each_with_object(Hash.new(0)) do |current, sum|
      tag = current.tag ||= 'Unknown'
      sum[tag] += current.amount
    end

    incomes = incomes.map { |x, v| [x, v] }
    Layout.print_summary_per_category('Incomes', incomes)

    expenses = expenses.map { |x, v| [x, v] }
    Layout.print_summary_per_category('Expenses', expenses)
  end

  def print_one_category_report(entries, tag)
    entries = entries.select do |entry|
      entry.tag == tag
    end
    print_all_categories_report(entries)
  end
end
