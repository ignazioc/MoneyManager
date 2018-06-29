class Tagger
  def default_options
    [:'1. Skip', :'2. Abort', :'3. Create'].sort
  end

  def retag(entries)
    
    archiver = Moneymanager::Archiver.new

    prompt = TTY::Prompt.new
    entries.each do |entry|
      
      Layout.clear
      Layout.print_single(entry)
      
      options = default_options.concat(archiver.tags.sort!).map { |x| x.to_s }
      action = prompt.select('Do you want add a tags?', options, per_page: 30)

      if action == options[0]
        # NOP
      elsif action == options[1]
        exit
      elsif action == options[2]
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
