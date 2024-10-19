Pod::Spec.new do |spec|
  spec.name         = "GithubFramework"
  spec.version      = "1.0.0"
  spec.summary      = "A framework to get GitHub repository information."
  spec.description  = "The GithubFramework provides a simple interface to interact with the GitHub API, allowing you to fetch information about repositories and their tags. It handles network requests, JSON decoding, and caching of data for easy access."
  spec.homepage     = "https://github.com/Ana9Lu7/GitHubFramework"
  spec.license      = "MIT"
  spec.author       = { "Ana Luiza" => "ana9lu7@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/Ana9Lu7/GitHubFramework.git", :tag => spec.version.to_s }
  spec.source_files = "GithubFramework/**/*.{h,m}"

  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'GithubFrameworkTests/**/*.{h,m,swift}'
  end
end

