#!/usr/bin/env ruby

# part 1

class Report
  attr_reader :report, :dampenable, :start

  def initialize(report, dampenable, start = [])
    @report = report
    @dampenable = dampenable
    @start = start
  end

  def valid?
    return true if report.size < 2

    diff = report[1] - report[0]
    if diff >= 1 && diff <= 3
      Report.new(report[1..], dampenable, [*start, report[0]]).valid?
    elsif dampenable
      Report.new([*start, report[0], *report[2..]], false).valid? ||
        Report.new([*start, report[1], *report[2..]], false).valid?
    else
      false
    end
  end
end

reports = File.readlines('input.txt', chomp: true).map do |line|
  [
    Report.new(line.split(/ +/).map(&:to_i), true),
    Report.new(line.split(/ +/).map(&:to_i).reverse, true)
  ]
end

puts reports.map { |a, b| a.valid? || b.valid? }.count { _1 }
