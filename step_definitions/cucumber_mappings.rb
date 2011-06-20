module CucumberMappings
  def scenario_with_steps(scenario_name, steps)
      write_file("features/a_feature.feature", <<-EOF)
Feature: A feature
  Scenario: #{scenario_name}
#{steps.gsub(/^/, '    ')}
EOF
  end

  def write_feature(feature)
    write_file("features/a_feature.feature", feature)
  end

  def run_scenario(scenario_name)
    run_simple "#{cucumber_bin} features/a_feature.feature --name '#{scenario_name}'", false
  end

  def run_feature
    run_simple "#{cucumber_bin} features/a_feature.feature", false
  end

  def assert_skipped(pattern)
    if File.exist?(File.join(current_dir, step_file(pattern)))
      raise "#{pattern} was not skipped"
    end
  end

  def step_file(pattern)
    pattern.gsub(/ /, '_') + '.step'
  end
end
