include_recipe 'role-base'
include_recipe 'balanced-postgres::client'
include_recipe 'balanced-app'

%w(ruby1.9.1 ruby1.9.1-dev).each do |name|
  package name do
    action :install
    end
end

%w(fpm deb-s3).each do |name|
  gem_package name do
    action :install
  end
end
