require "cf_completion/version"

module CfCompletion

  CF_COMMAND_POSITION = 1
  APP_COMMANDS= %w{ app push p scale delete d rename start st stop sp restart rs
    restage rg events files f logs env e set-env se unset-env stacks }

  def self.complete(completion_word, completion_word_position, params)
    command_name = command_name(completion_word_position, params)

    if completion_word_position == CF_COMMAND_POSITION
      puts list_commands(completion_word)
    elsif APP_COMMANDS.include?(command_name) && completion_word_position == 2
      puts list_apps(completion_word)
    end
  end

  def self.command_name(completion_word_position, params)
    return '' unless completion_word_position > CF_COMMAND_POSITION
    params[CF_COMMAND_POSITION]
  end

  def self.list_commands(filter)
    help_output = `cf help | sed -n '/^GETTING STARTED:/,/^ENVIRONMENT VARIABLES/p'`

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
