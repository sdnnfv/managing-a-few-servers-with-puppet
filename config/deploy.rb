require 'rubygems'
require 'supply_drop'

set :puppet_lib, 'modules'
set :puppet_destination, '/tmp/puppet_apply'

def librarian_update
  puts 'Running librarian-puppet'
  `librarian-puppet install`
end

Dir.glob('nodes/*.pp') do |node_file|
  node = node_file.sub('nodes/', '').sub('.pp', '')
  user, host = node.split('@')

  task :"#{host}" do
    librarian_update
    server host, :web, :app, :db
    set :user, user
    set :puppet_parameters, node_file
  end

  task :"#{host}-test" do
    librarian_update
    server 'test.local', :web, :app, :db
    set :user, user
    set :puppet_parameters, node_file
  end
end
