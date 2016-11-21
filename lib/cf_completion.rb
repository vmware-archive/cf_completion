require "cf_completion/version"

module CfCompletion

  CF_COMMAND_POSITION = 1
  APP_COMMANDS= %w{ app push p scale delete d rename start st stop sp restart rs
    restage rg events files f logs env e set-env se unset-env stacks }

  def self.complete(completion)

    if completion[:word_position] == CF_COMMAND_POSITION
      list_commands(completion[:word])
    elsif in_app_name_completion_position?(completion)
      list_apps(completion[:word])
    end
  end

  def self.in_app_name_completion_position?(completion)
    is_app_command?(completion) && completion[:word_position] == 2
  end

  def self.is_app_command?(completion)
    command_name = command_name(completion)
    APP_COMMANDS.include?(command_name)
  end

  def self.command_name(completion)
    return '' unless is_command_complete?(completion)
    completion[:params][CF_COMMAND_POSITION]
  end

  def self.is_command_complete?(completion)
    completion[:word_position] > CF_COMMAND_POSITION
  end

  def self.list_commands(filter)
    help_output = `cf help`

    help_output.
        split("\n").
        map { |line| line.match(/^\s+([^, ]*)/) }.
        reject { |match| match.nil? }.
        map { |match| match[1] }.
        reject { |match| match[/^#{filter}/].nil? }
  end

  def self.list_apps(filter)
    app_list = `cf apps`

    found_heading = false

    heading_search = ->(line) do
      if (!found_heading && !line[/^name/].nil?)
        found_heading = true
        false
      else
        found_heading
      end
    end

    app_list.
        split("\n").
        select(&heading_search).
        map { |line| line.split(" ")[0] }.
        select { |name| name[/^#{filter}/] }
  end
end
