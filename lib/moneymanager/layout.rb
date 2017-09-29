class Layout
  def self.print_multiple(entries)
    clear
    rows = entries.map { |entry| [entry.formatted_approved, entry.date.strftime('%y/%m/%d'), entry.tag, entry.reason[0...50], entry.formatted_amount] }

    table = Terminal::Table.new headings: ['✔/✖︎', 'Date', 'Tag', 'Reason', 'Amount'], rows: rows
    table.align_column(4, :right)
    table.align_column(0, :center)

    puts table
  end

  def self.print_single(entry)
    hash = {
      date: entry.date,
      reason: entry.reason,
      amount: entry.formatted_amount,
      company: entry.company,
      approved: entry.formatted_approved,
      tag: entry.tag
    }
    rows = hash.map { |k, v| [k.to_s.capitalize, v] }
    puts Terminal::Table.new rows: rows
  end

  def self.formatted_amount(amount)
    s = amount.to_s + ' €'
    amount < 0 ? s.red : s.green
  end

  def self.print_summary(income, expenses)
    delta = income + expenses
    table = Terminal::Table.new do |t|
      t << ['Income', formatted_amount(income)]
      t << ['Expense', formatted_amount(expenses)]
      t << ['Delta', formatted_amount(delta)]
    end
    table.align_column(1, :right)
    table.title = 'Summary'
    puts table
  end

  def self.print_summary_per_category(title, rows)
    return unless rows.count > 0
    rows = rows.sort! { |r1, r2| r1.first <=> r2.first }
    rows = rows.map do |row|
      row[-1] = formatted_amount(row.last)
      row
    end
    table = Terminal::Table.new rows: rows
    table.align_column(1, :right)
    table.title = title

    puts table
  end

  def self.clear
    print "\e[H\e[2J"
  end
end
