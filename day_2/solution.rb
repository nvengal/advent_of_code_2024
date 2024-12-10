#!/usr/bin/env ruby

# part 1

class Report
  attr_reader :report

  def initialize(report)
    @report = report
  end

  def valid?
    _valid? || Report.new(report.reverse)._valid?
  end

  def _valid?
    valid_pair?(*report[..1]) && rest_is_valid?(report[1..])
  end

  private

  def valid_pair?(a, b)
    diff = b - a
    diff >= 1 && diff <= 3
  end

  def rest_is_valid?(rest)
    return true if rest.count < 2

    valid_pair?(*rest[..1]) && rest_is_valid?(rest[1..])
  end
end

reports = File.readlines('input.txt', chomp: true).map do |line|
  Report.new line.split(/ +/).map(&:to_i)
end

puts reports.filter { _1.valid? }.count
