class Report

  def print_total_report(entries, onlyIncome)
    total = 0
    if (onlyIncome)
      total = entries.reject(&:expense?).map(&:amount).reduce(:+)
    else
      total = entries.reject(&:income?).map(&:amount).reduce(:+)
    end
    Layout.print_single_value(total)
  end

  def print_group_by_categories_report(entries, onlyIncome)

    entries = entries.select { |entry|
      entry.income? == onlyIncome
    }.each_with_object(Hash.new(0)) { |current, sum|
      tag = current.tag ||= 'Unknown'
      sum[tag] += current.amount
    }.map { |x, v|
      [x, v]
    }.sort! { |r1, r2| r1.first <=> r2.first }
    Layout.print_generic_rows(entries)
  end

  def print_group_by_month_report(entries, tag)
    entries = entries.select { |entry|
      entry.tag == tag
    }.each_with_object(Hash.new(0)) { | current, sum |
      month = current.date.strftime("%B")
      sum[month] += current.amount
    }
    Layout.print_generic_rows(entries)
  end
end
