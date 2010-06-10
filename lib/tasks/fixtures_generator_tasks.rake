namespace :db do
  namespace :fixtures do

    # command line usage: rake db:fixtures:create
    desc "Creates fixtures for all existing ActiveRecord models."
    task :create => :environment do
      require 'rails_generator'
      require 'rails_generator/scripts/generate'

      Dir.chdir("app/models") do
        Dir.foreach(".") do |filename|
          if filename.match(/.*\.rb$/)
            name = filename.gsub(".rb", "")

            begin
              model_class = name.camelize.constantize
              model_class = nil if model_class.superclass != ActiveRecord::Base
            rescue
              model_class = nil
            end

            if model_class
              columns = []

              model_class.columns.each do |column|
                columns << "#{column.name}:#{column.type}" unless column.name == model_class.primary_key
              end

              Rails::Generator::Scripts::Generate.new.run(["fixtures", "#{model_class}"] + columns)
              puts "Created fixtures for model #{model_class}"
            end

          end
        end
      end

    end

  end
end

