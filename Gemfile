source "https://rubygems.org"

ruby file: ".ruby-version"

gem "jekyll"

# needed for Ruby >=3.0
gem "webrick"

# needed for Ruby >=3.4
gem "base64"
gem "bigdecimal"
gem "csv"

# stops message being printed every startup
gem "faraday-retry"

gem "kramdown-parser-gfm"

group :jekyll_plugins do
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
end

group :development do
  gem "rake"
end

group :test do
  gem "html-proofer"
end
