ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "open-uri"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Download sample image files if they do not exist
  private
  files = {
    # https://unsplash.com/photos/IuJc2qh2TcA
    'cat.jpg' => 'https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-1.2.1&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;cs=tinysrgb&amp;dl=cedric-vt-IuJc2qh2TcA-unsplash.jpg&amp;w=640',
    # https://unsplash.com/photos/ybHtKz5He9Y
    'dog.jpg' => 'https://images.unsplash.com/photo-1529429617124-95b109e86bb8?ixlib=rb-1.2.1&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;cs=tinysrgb&amp;dl=lui-peng-ybHtKz5He9Y-unsplash.jpg&amp;w=640',
  }

  files = files.map { |f, u| [File.join(Rails.root, 'test', 'fixtures', 'files', f), u] }.to_h

  def self.download_file(path, url)
    URI.open(url) do |image|
      File.open(path, "wb") do |file|
        file.write(image.read)
      end
    end
  end

  files.each do |path, url|
    if not File.exist? path
      p "Downloading #{File.basename(path)}"
      download_file path, url
    end
  end
  public

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_as(user, password = 'password')
    post login_url, params: { session: { username: user.username, password: password } }
  end
end
