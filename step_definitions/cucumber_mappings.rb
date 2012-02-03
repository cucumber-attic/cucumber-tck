require 'aruba/cucumber'

module CucumberMappings
  def scenario_with_steps(scenario_name, steps)
    append_to_feature <<-EOF

  Scenario: #{scenario_name}
#{steps.gsub(/^/, '    ')}
EOF
  end

  def feature_file_path
    "#{features_dir}/a_feature.feature"
  end

  def create_empty_feature options = {}
    tags = options[:with_tags] || []

    unless @feature_file_created
      write_file(feature_file_path, <<-EOF)
#{tags.any? ? tags.join(' ') + "\n": ''}Feature: A feature
EOF
      @feature_file_created = true
    end
  end

  def append_to_feature contents
    create_empty_feature
    append_to_file feature_file_path, contents
  end

  def write_feature(feature)
    write_file("#{features_dir}/a_feature.feature", feature)
  end

  def assert_skipped(pattern)
    if pattern_exists?(pattern)
      raise "#{pattern} was not skipped"
    end
  end

  def assert_passed(pattern)
    unless pattern_exists?(pattern)
      raise "#{pattern} did not pass"
    end
  end

  def step_file(pattern)
    pattern.gsub(/ /, '_') + '.step'
  end

  def pattern_exists?(pattern)
    File.exist?(File.join(current_dir, step_file(pattern)))
  end

  protected

  def indent_code(code, levels = 1)
    indented = ''
    code.each_line { |line| indented += "#{'  ' * levels}#{line}" }
    indented
  end
end
