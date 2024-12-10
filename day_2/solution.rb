#!/usr/bin/env ruby

# part 1

class Report
  attr_reader :report

  def initialize(report)
    @report = report
  end

  def valid?
    return true if report.count < 2

    diff = report[1] - report[0]
    diff >= 1 && diff <= 3 && Report.new(report[1..]).valid?
  end
end

reports = File.readlines('input.txt', chomp: true).map do |line|
  line.split(/ +/).map(&:to_i)
end.map do |report|
  if report.first > report.last
    Report.new report.reverse
  else
    Report.new report
  end
end

puts reports.filter { _1.valid? }.count
