require "strscan"

module Jekyll
  module Smartify
    SKIP_TAGS = %w[pre code script style textarea].freeze

    module_function

    def smartify(html)
      scanner = StringScanner.new(html)
      out = +""
      skip_depth = 0

      until scanner.eos?
        if (closing = scanner.scan(/<\/(\w+)[^>]*>/))
          skip_depth -= 1 if SKIP_TAGS.include?(scanner[1].downcase) && skip_depth.positive?
          out << closing
        elsif (opening = scanner.scan(/<(\w+)[^>]*>/))
          skip_depth += 1 if SKIP_TAGS.include?(scanner[1].downcase)
          out << opening
        elsif (other_tag = scanner.scan(/<[^>]+>/))
          out << other_tag
        elsif (text = scanner.scan(/[^<]+/))
          out << (skip_depth.positive? ? text : apply_typography(text))
        else
          out << scanner.getch
        end
      end

      out
    end

    def apply_typography(text)
      text
        .gsub(/(\w)'(\w)/, "\\1’\\2")
        .gsub(/(\A|[\s(\[{>])'/, "\\1‘")
        .gsub(/'/, "’")
        .gsub(/(\A|[\s(\[{>])"/, "\\1“")
        .gsub(/"/, "”")
    end
  end
end

Jekyll::Hooks.register :pages, :post_render do |page|
  next unless page.output_ext == ".html"

  page.output = Jekyll::Smartify.smartify(page.output)
end

Jekyll::Hooks.register :documents, :post_render do |doc|
  next unless doc.output_ext == ".html"

  doc.output = Jekyll::Smartify.smartify(doc.output)
end
