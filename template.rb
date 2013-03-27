## Before using this generator:
# $ rvm use 2.0.0

# def repo_root; "#{Dir.pwd}/../rails_template"; end
def repo_root
  'https://raw.github.com/paulfioravanti/rails_template/master'
end

apply "#{repo_root}/utilities.rb"

heading "Define gems" ##########################################################
apply recipe("gems")

universal_gems
database_gem
development_only_gems
development_and_test_gems
test_only_gems
assets_gems

heading "Edit Gemfile" #########################################################
apply recipe("gemfile")

change_double_to_single_quotes 'Gemfile'
remove_comments 'Gemfile'
remove_blank_lines 'Gemfile'
modern_hash_syntax 'Gemfile'
add_explicit_ruby_version
change_rubygems_source
insert_line_breaks_before_groups

heading "Configure RVM" ########################################################
apply recipe("rvm")

update_rvm
create_rvm_bundler_integration
set_ruby_version_and_app_gemset_in_rvm_env

heading "Edit Environment files" ###############################################
apply recipe("environment")

sub_heading "Application"

split_out_locale_files
remove_test_unit_from_railties
set_lazy_asset_precompilation
suppress_helper_and_view_spec_generation

sub_heading "Development"

no_asset_debug

heading "Figaro config" ########################################################
apply recipe("figaro")

create_secure_app_config
create_example_app_config

heading "Config/create pg database" ############################################
apply recipe("database")

create_secure_database_config
destroy_any_previous_databases
create_databases

heading "Configure Initializers" ###############################################
apply recipe("initializers")

create_basic_initializers_for_installed_gems
insert_figaro_config_into_secret_token
simple_form_initializer
i18n_js_initializer

heading "Configure locale structure" ###########################################
apply recipe("locales")

create_rails_locales
create_app_locales
create_vendor_locales

heading "Create/overrride Bootstrap JS/CSS" ####################################

apply recipe("javascript")
require_custom_javascript

apply recipe("css")
customize_application_css
create_custom_css
##### Custom user css ???

heading "Create base models" ###################################################
apply recipe("models")

generate_model_migrations
replace_migration_content
migrate_databases
create_model_classes

heading "Customize generated views" ############################################
apply recipe("views")

customize_application_view
create_partials_for_layout

heading "Generate initial routes" ##############################################

apply recipe("app")
route "root to: 'pages#home'"

heading "Generate base controller/action" ######################################

create_resources_for_pages
clean_up_routes

heading "Create basic helper" ##################################################

replace_application_helper

heading "App Clean Up" #########################################################

clean_up_generated_app_content
annotate_app

heading "Setup Testing Frameworks" #############################################
apply recipe("spec")

bootstrap_test_frameworks
configure_rspec
remove_cucumber_env_white_space
customize_guard_file

heading "Create initial basic specs" ###########################################

create_initial_specs
create_initial_factories

heading "Git-related config" ###################################################
apply recipe("git")

create_git_ignore_file
create_git_repo
prevent_whitespaced_commits

heading "Run tests, commit" ####################################################

run_tests
add_and_commit_to_repo