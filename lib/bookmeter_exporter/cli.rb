# frozen_string_literal: true

require "thor"
require "csv"
require_relative "crawler"

module BookmeterExporter
  class CLI < Thor
    class << self
      def exit_on_failure?
        true
      end
    end

    desc "export EMAIL", "Main export task"
    def export(email)
      puts "Start"
      password = ask("Password for #{email}:", echo: false)
      puts ""
      crawler = BookmeterExporter::Crawler.new(email, password)
      books = crawler.crawl
      puts books.to_csv
      puts "End"
    end

    default_task :export
  end
end
