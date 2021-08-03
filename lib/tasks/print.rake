namespace :print do
  task show_list: :environment do 
    class CSVFormatter
      def initialize
        @buffer = []
      end

      def result
        @buffer.join("\n")
      end

      def section_title(title)
        @buffer << "\n#{title}:"
      end

      def section(routes)
        routes.map do |r|
          @buffer << "#{r[:verb]} #{r[:path]}"
        end
      end

      def header(routes)
        @buffer << 'user, hexadecimal color, phrase, complete.'
      end

      def no_routes
        @buffer << <<-MESSAGE.strip_heredoc
          No registers
        MESSAGE
      end

    end

    all_routes = Rails.application
    byebug
    require 'action_dispatch/routing/inspector'
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    # puts inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
    puts inspector.format(CSVFormatter.new)
  end
end

