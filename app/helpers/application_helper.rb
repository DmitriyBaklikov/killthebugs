module ApplicationHelper
  def languages
    lexers = Rouge::Lexer.all
    names = lexers.map { |i| i.name.split('::').last }
    tags = lexers.map &:tag
    names.zip tags
  end
end
