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

  desc 'Store pages to redis'

  task :redis_store => :environment do
    Page.all.each do |page|
        $redis.hmset("page:#{ page.id }", 'id', page.id, 'name', page.name, 'content', page.content, 'site_id', page.site_id, 'created_at', page.created_at, 'updated_at', page.updated_at)
        $redis.lpush('page_ids', page.id)
        puts "Add to redis page: #{ page.name } with key: page:#{ page.id }"
      end
  end

end