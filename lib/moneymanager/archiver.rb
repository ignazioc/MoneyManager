require 'yaml'
require 'fileutils'

module Moneymanager
  class Archiver
    attr_accessor :home_folder

    def base_path
      File.join(home_folder, '.moneymanager')
    end

    def archive_path
      File.join(base_path, 'archive')
    end

    def backup_path
      date_filename = Time.now.to_i.to_s
      File.join(base_path, date_filename)
    end

    def self.empty_archive
      { entries: [],
        tags: [] }
    end

    def self.reset
      File.write(Archiver.archive_path, Archiver.empty_archive.to_yaml)
    end

    def backup
      File.write(backup_path, @db.to_yaml)
    end

    def initialize(home_folder = Dir.home)
      self.home_folder = home_folder

      FileUtils.mkdir_p(base_path)
      @db = if File.exist? archive_path
              YAML.load_file(archive_path)
            else
              Archiver.empty_archive
            end
    end

    def save
      File.write(archive_path, @db.to_yaml)
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

    def delete(entry)
      puts entry
      @db[:entries].delete_if { |obj| obj.digest == entry.digest }
      save
    end

    def all_entries
      @db[:entries].sort_by(&:date)
    end

    def all_bank_transfers
      @db[:entries].sort_by(&:date).select(&:bank_transfer)
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
