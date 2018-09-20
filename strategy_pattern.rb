class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'This is the title'
    @text = ['Everything still', 'is going well']
    @formatter = formatter
  end

  def output_report
    # @formatter.output_report(@title, @text)
    # @formatter.output_report(self)
    @formatter.call(self)
  end
end

# class HTMLFormatter
#   def output_report(title, text)
#     puts '<html>'
#     puts '<head>This is the header</head>'
#     puts "<title>#{title}</title>"
#     text.each do |line|
#       puts "<p>#{line}</p>"
#     end
#     puts '<footer>This is the footer</footer>'
#     puts '</html>'
#   end
# end

# class HTMLFormatter
#   def output_report(context)
#     puts '<html>'
#     puts '<head>This is the header</head>'
#     puts "<title>#{context.title}</title>"
#     context.text.each do |line|
#       puts "<p>#{line}</p>"
#     end
#     puts '<footer>This is the footer</footer>'
#     puts '</html>'
#   end
# end

HTMLFormatter = lambda do |context|
  puts '<html>'
  puts '<head>This is the header</head>'
  puts "<title>#{context.title}</title>"
  context.text.each do |line|
    puts "<p>#{line}</p>"
  end
  puts '<footer>This is the footer</footer>'
  puts '</html>'
end

# report = Report.new(HTMLFormatter.new)
report = Report.new(&HTMLFormatter)
report.output_report