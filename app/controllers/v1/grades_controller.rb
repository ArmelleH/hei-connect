module V1
  class GradesController < ::ApplicationController
    version 1..2

    def show
      client = Konosys::Actions::Grades.new(params[:username], params[:password], params[:session_id])

      begin
        grades = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection grades
    end

  end
end