module FragmentsHelper
  def highlighted_code(fragment)
    # initializing formatter here to pass options
    formatter = Rouge::Formatters::HTML.new line_numbers: true
    raw Rouge.highlight(fragment.code, fragment.language, formatter)
  end
end
