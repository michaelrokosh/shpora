class RobotsController < ApplicationController
  def robots
    subdomain = request.subdomain
    extradot = subdomain ? '.' : ''

    robots = File.read(RAILS_ROOT + "/config/robots#{extradot}#{subdomain}.txt")
    respond_to do |format|
      format.txt { render text: robots, layout: false }
    end
  end
end