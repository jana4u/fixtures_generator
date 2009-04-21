class FixturesGenerator < ModelGenerator

  def manifest
    begin
      fixtures_name = class_name.constantize.table_name
    rescue
      fixtures_name = table_name
    end

    record do |m|
      # Fixture directory.
      m.directory File.join('test/fixtures', class_path)

      # Fixtures.
      m.template 'model:fixtures.yml',  File.join('test/fixtures', class_path, "#{fixtures_name}.yml")
    end
  end

end
