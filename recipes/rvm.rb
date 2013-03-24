def update_rvm
  comment "# Update and reload rvm"
  run 'rvm get head && rvm reload'
end

def create_rvm_bundler_integration
  comment "# Set up RVM Bundler integration to eliminate"
  comment "# the use of `bundle exec` in commands:"
  chmod "#{ENV['rvm_path']}/hooks/after_cd_bundler", "+x"
end

def set_ruby_version_and_app_gemset_in_rvm_env
  comment "# Set ruby version and create custom gemset for app in RVM env"
  current_ruby = %x{rvm list}.match(/^=[\*|\>]\s+(.*)\s\[/)[1]
  create_file '.ruby-version', "#{current_ruby}"
  create_file ".ruby-gemset", "#{app_name}"

  # Using a newly created gemset can't be done through just callling 'run ...'
  # command, so we need to get the RVM environment, create, use,
  # and install gems in the new gemset from there.
  require 'rvm'
  env = RVM::Environment.new(current_ruby)

  comment "# Create gemset #{current_ruby}@#{app_name}"
  env.gemset_create(app_name)

  comment "# Use gemset #{current_ruby}@#{app_name}"
  env.gemset_use!(app_name)

  comment "# Install bundler in #{current_ruby}@#{app_name}"
  if env.system("gem", "install", "bundler")
    puts green("Successfully installed bundler in #{current_ruby}@#{app_name}")
  end

  comment "# Install rails in #{current_ruby}@#{app_name}"
  if env.system("gem", "install", "rails")
    puts green("Successfully installed rails in #{current_ruby}@#{app_name}")
  end

  comment "# Run bundle install in #{current_ruby}@#{app_name}"
  if env.system("bundle", "install", "--binstubs=./bundler_stubs")
    puts green("Successfully ran bundle install for #{current_ruby}@#{app_name}")
  end
end