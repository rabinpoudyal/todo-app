# frozen_string_literal: true

require 'yaml'

module ToDo
  class Yaml
    def self.load(file)
      YAML.load_file(file)
    end

    def self.dump(file, data)
      File.open(file, 'w') do |f|
        f.write(YAML.dump(data))
      end
    end
  end
end
