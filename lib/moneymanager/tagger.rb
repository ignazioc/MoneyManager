class Tagger
  def default_options
    [:'1. Skip', :'2. Abort', :'3. Create'].sort
  end

  def retag(entries)
    
    archiver = Moneymanager::Archiver.new
    tag_guesser = Moneymanager::TaggerGuesser.new(archiver.all_entries)

    prompt = TTY::Prompt.new
    entries.each do |entry|
      
      Layout.clear
      Layout.print_single(entry)
      
      options = default_options.concat(archiver.tags.sort!).map { |x| x.to_s }

      suggested_tag = tag_guesser.guess(entry)
      if suggested_tag.nil? 
        suggested_tag = "Varie"
      end
      options = options.unshift("Suggested: #{suggested_tag}")

      action = prompt.select('Do you want add a tags?', options, per_page: 30)

      if action == options[0]
        entry.tag = suggested_tag
      elsif action == options[1]
        # NOP
      elsif action == options[2]
        exit
      elsif action == options[3]
        tag = prompt.ask('Create a new tag') do |q|
          q.required true
          q.validate(/^\S*$/)
          q.modify :capitalize
        end
        entry.tag = tag
        archiver.store_tag(tag)
      else
        entry.tag = action
      end
      archiver.update(entry)
    end
  end
end
