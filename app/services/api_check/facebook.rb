class ApiCheck::Facebook < ApiCheck::Base
  private

  def cache_key
    :facebook
  end

  def url
    "https://takehome.io/facebook"
  end
end
