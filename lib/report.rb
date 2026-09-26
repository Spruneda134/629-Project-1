# frozen_string_literal: true

require 'date'

class Report
  attr_reader :activityName, :pr, :pr_date, :history, :unit

  def initialize(activityName, pr = nil, pr_date = nil, history = [], unit = 'lbs')
    if activityName.nil? || activityName.empty?
      raise ArgumentError, 'Activity name cannot be nil or empty'
    end

    @activityName = activityName
    @pr = pr
    @pr_date = pr_date
    @history = history
    @unit = unit
  end

  # whole days from the PR date to now (nil if the PR has no date)
  def days_since_pr(now = Time.now)
    return nil if @pr_date.nil?

    (now.to_date - @pr_date.to_date).to_i
  end

  def to_s(now = Time.now)
    title = "#{@activityName} Report"
    lines = [title, '-' * title.length]

    if @pr_date.nil?
      lines << "PR: #{@pr} #{@unit} (added manually)"
      lines << 'Time since last PR: N/A'
    else
      days = days_since_pr(now)
      lines << "PR: #{@pr} #{@unit} (set on #{format_date(@pr_date)})"
      lines << "Time since last PR: #{days} #{days == 1 ? 'day' : 'days'}"
    end

    return lines.join("\n") if @history.empty?

    name_width = (['Session'] + @history.map { |row| row[:name] }).map(&:length).max
    weight_header = 'Max Weight'

    lines << ''
    lines << "#{'Date'.ljust(10)}  #{'Session'.ljust(name_width)}  #{weight_header}"
    lines << "#{'-' * 10}  #{'-' * name_width}  #{'-' * weight_header.length}"
    @history.each do |row|
      weight = "#{row[:max_weight]} #{@unit}".ljust(weight_header.length)
      marker = row[:date] == @pr_date && row[:max_weight] == @pr ? '  *PR' : ''
      lines << "#{format_date(row[:date])}  #{row[:name].ljust(name_width)}  #{weight}#{marker}".rstrip
    end

    lines.join("\n")
  end

  private

  def format_date(time)
    time.strftime('%Y-%m-%d')
  end
end
