class Reviewer
  def review(entries)
    archiver = Moneymanager::Archiver.new
    entries.each do |entry|
      Layout.print_single(entry)
      prompt = TTY::Prompt.new
      action = prompt.select('Do you recognize?', %w[yes no skip abort], per_page: 30)

      case action
      when "yes"
        entry.approved = true
      when "no"
        entry.approved = false
      when "abort"
        exit
      end
      archiver.update(entry)
    end
  end
end
