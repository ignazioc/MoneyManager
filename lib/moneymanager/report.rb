class Report
  def print_total_report(entries, only_income)
    total = if only_income
              entries.select(&:income?).map(&:amount).reduce(:+)
            else
              entries.select(&:expense?).map(&:amount).reduce(:+)
            end
    Layout.print_single_value(total)
  end

  def print_group_by_categories_report(entries, only_income)
    entries = entries.select do |entry|
      if only_income
        entry.income?
      else
        entry.expense?
      end
    end.each_with_object(Hash.new(0)) do |current, sum|
      tag = current.tag ||= 'Unknown'
      sum[tag] += current.amount
    end.map do |x, v|
      [x, v]
    end.sort! { |r1, r2| r1.first <=> r2.first }
    Layout.print_generic_rows(entries)
  end

  def print_group_by_month_report(entries, tag)
    entries = entries.select do |entry|
      entry.tag == tag
    end.each_with_object(Hash.new(0)) do |current, sum|
      month = current.date.strftime('%B')
      sum[month] += current.amount
    end
    Layout.print_generic_rows(entries)
  end

  def print_only_matching_tag(entries, tag)
    entries = entries.select do |entry|
      entry.tag == tag
    end
    Layout.print_multiple(entries)
  end
end
