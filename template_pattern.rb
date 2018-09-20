class Report
  def initialize
    @name = 'the report'
    @text = ['Everything looks', 'like is going fine']
  end

  def output_report
    output_header
    output_body
    output_footer
  end

  def output_header
    raise 'called abstract method: output_header'
  end

  def output_body
    @text.each do |text|
      output_line(text)
    end
  end

  def output_line(line)
    raise 'called abstract method: output_line'    
  end

  def output_footer
    raise 'called abstract method: output_footer'
  end
end

class HTMLReport < Report
  def output_header
    puts '<html>'
    puts '<head>This is the header</head>'
    puts "<title>#{@name}</title>"
  end

  def output_line(line)
    puts "<p>#{line}</p>"
  end

  def output_footer
    puts '<footer>This is the footer</footer>'
    puts '</html>'
  end
end

report = HTMLReport.new
report.output_report
