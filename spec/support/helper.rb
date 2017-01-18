module Helper
  def nobrainer_conf
    proc do |c|
      c.reset!
      c.rethinkdb_url = "rethinkdb://localhost/#{"#{ENV['ORM']}_#{ENV['RAILS_ENV']}"}"
      c.environment = ENV['RAILS_ENV']
    end
  end
end
