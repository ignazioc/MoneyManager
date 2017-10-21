require 'yaml'

module Moneymanager
  class Archiver
    def self.archive_path
      File.join(Dir.home, '.moneymanager')
    end

    def self.empty_archive
      { entries: [],
        tags: [] }
    end

    def self.reset
      File.write(Archiver.archive_path, Archiver.empty_archive.to_yaml)
    end

    def initialize
      if File.exist? Archiver.archive_path
        @db = YAML.load_file(Archiver.archive_path)
      else
        @db = Archiver.empty_archive
      end
    end

    def save
      File.write(Archiver.archive_path, @db.to_yaml)
    end

    def store(entries)
      previous_digest = all_entries.map(&:digest)

      to_insert = entries.reject do |entry|
        previous_digest.include?(entry.digest)
      end
      @db[:entries].concat(to_insert)
      save
      puts "Parsed: #{entries.count}"
      puts "Skipped: #{entries.count - to_insert.count}"
      puts "Inserted: #{to_insert.count}"
    end

    def update(entry)
      @db[:entries].delete_if { |obj| obj.digest == entry.digest }
      @db[:entries] << entry
      save
    end

    def all_entries
      @db[:entries].sort_by(&:date)
    end

    def tags
      @db[:tags]
    end

    def store_tag(tag)
      @db[:tags] << tag
      save
    end
  end
end
