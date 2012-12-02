module Konosys
  module Models
    class Week
      attr_accessor :number, :courses

      def initialize(page_source)
        # Fetch date from hidden form input
        date_components = page_source.scan(/name="_DateDebutSemaine_hidden" type="text" value="(\d+)\/(\d+)\/(\d+)"/)
        date = Date.new(*date_components.flatten.reverse.collect { |i| i.to_i })
        @number = date.cweek

        # Fetch courses
        @courses = Array.new
        data = page_source.scan(/AjouterRDV\((\d+),(\d+),(\d+),(\d+),'(.+?)',/i)
        data.each do |line|
          @courses.push(Models::Course.new(date, line))
        end
      end

      class Entity < Grape::Entity
        expose :number
        expose :courses, using: Course::Entity
      end
    end
  end
end