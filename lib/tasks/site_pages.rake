namespace :site_pages do
  desc 'Seed test themes into db'

  task :seed => :environment do

    themes = %w(chipotle)
    themes.each do |theme_name|
      site = Site.new(name: theme_name, domain: "http://www.#{theme_name}.com")
      site.valid? && site.save
      pages = Dir.open(File.join(Rails.root, 'public', 'themes', theme_name)).entries.grep(/.html$/)
      pages.each do |page_name|
        page_content = File.read(File.join(Rails.root, 'public', 'themes', theme_name, page_name))
        site.pages.create(name: page_name, content: page_content)
      end
    end
  end

end