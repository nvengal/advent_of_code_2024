#!/usr/bin/env ruby

# part 1

class Report
  attr_reader :report, :errors

  def initialize(report)
    @report = report
  end

  def valid?
    return true if report.size < 2

    diff = report[1] - report[0]
    diff >= 1 && diff <= 3 && Report.new(report[1..]).valid?
  end
end

reports = File.readlines('input.txt', chomp: true).map do |line|
  [
    Report.new(line.split(/ +/).map(&:to_i)),
    Report.new(line.split(/ +/).map(&:to_i).reverse)
  ]
end.flatten

puts reports.filter(&:valid?).count
