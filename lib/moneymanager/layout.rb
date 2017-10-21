class Layout
  def self.print_multiple(entries)
    if entries.count == 1
      print_single(entries.first)
    else
      clear
      rows = entries.map { |entry| [entry.formatted_approved, entry.date.strftime('%y/%m/%d'), entry.tag, entry.reason[0...50], entry.formatted_amount, entry.digest[0...6]] }

      table = Terminal::Table.new headings: ['✔/✖︎', 'Date', 'Tag', 'Reason', 'Amount', 'SHA1'], rows: rows
      table.align_column(4, :right)
      table.align_column(0, :center)

      puts table
    end
  end

  def self.print_single(entry)
    clear
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
    s = sprintf('%.2f €', amount)
    amount < 0 ? s.red : s.green
  end

  def self.print_single_value(total)
    table = Terminal::Table.new do |t|
      t << [formatted_amount(total)]
    end
    table.align_column(0, :right)
    puts table
  end

  def self.print_generic_rows(rows)
    return unless rows.count > 0
    sum = rows.reduce(0) { |  tot, row | tot + row.last }
    table = Terminal::Table.new
    rows = rows.each { |row|
      table.add_row [
        { :value => row[0], :alignment => :left},
      { :value => formatted_amount(row.last), :alignment => :right }]
    }
    table.add_separator
    table.add_row [{ :value => formatted_amount(sum), :colspan => 2, :alignment => :right }]

    puts table
  end

  def self.clear
    print "\e[H\e[2J"
  end
end
