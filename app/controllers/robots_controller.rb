class RobotsController < ApplicationController
  def robots
    subdomain = request.subdomain
    extradot = subdomain.blank? ? '' : '.'
    robots = File.read(Rails.root + "public/config/robots#{extradot}#{subdomain}.txt")
    render text: robots, layout: false, content_type: "text/plain"
  end
end