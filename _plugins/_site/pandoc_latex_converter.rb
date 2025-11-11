"""
Converter to process .tex posts via Pandoc into HTML with MathJax
Requires: pandoc installed and available in PATH
Falls back to returning escaped source when pandoc is missing, without crashing.
"""
# frozen_string_literal: true

require 'open3'
require 'cgi'

module Jekyll
  class PandocLatexConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext.casecmp('.tex').zero?
    end

    def output_ext(_ext)
      '.html'
    end

    def convert(content)
      # Use pandoc to convert LaTeX to HTML5 with MathJax enabled
      cmd = [
        'pandoc',
        '--from=latex',
        '--to=html5',
        '--mathjax',
        '--metadata=pagetitle:Pandoc-TeX-Post'
      ]
      stdout, stderr, status = Open3.capture3(*cmd, stdin_data: content)
      unless status.success?
        Jekyll.logger.error('Pandoc conversion failed', stderr)
        return fallback_pre(content)
      end
      stdout
    rescue Errno::ENOENT
      # pandoc executable not found
      Jekyll.logger.error('Pandoc not found', 'Please install Pandoc and ensure it is in your PATH.')
      fallback_pre(content)
    end

    private

    def fallback_pre(content)
      # Escape safely without relying on Jekyll::Utils (not available in 3.9)
      "<pre>#{CGI.escapeHTML(content.to_s)}</pre>"
    end
  end
end
