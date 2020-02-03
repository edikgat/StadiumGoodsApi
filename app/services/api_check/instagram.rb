class ApiCheck::Instagram < ApiCheck::Base
  private

  def cache_key
    :instagram
  end

  def url
    "https://takehome.io/instagram"
  end
end
