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
      pandoc = resolve_pandoc
      unless pandoc
        Jekyll.logger.error('Pandoc not found', 'Install Pandoc or add it to PATH (e.g. C:/Program Files/Pandoc).')
        return fallback_pre(content)
      end
      cmd = [
        pandoc,
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
    rescue Errno::ENOENT => e
      # pandoc executable not found during execution
      Jekyll.logger.error('Pandoc execution failed', e.message)
      fallback_pre(content)
    end

    private

    def resolve_pandoc
      # 1) Respect explicit PANDOC env var
      env_cmd = ENV['PANDOC']
      return env_cmd if env_cmd && File.exist?(env_cmd)

      # 2) If pandoc is on PATH, use it (Open3 will find it); probe with where/which fast path
      begin
        if Gem.win_platform?
          require 'open3'
          out, _err, status = Open3.capture3('where pandoc')
          return out.lines.first.strip if status.success? && out && !out.strip.empty? && File.exist?(out.lines.first.strip)
        else
          out, _err, status = Open3.capture3('which pandoc')
          return out.strip if status.success? && out && !out.strip.empty?
        end
      rescue StandardError
        # ignore
      end

      # 3) Common Windows install locations
      candidates = [
        'C:/Program Files/Pandoc/pandoc.exe',
        'C:/Program Files (x86)/Pandoc/pandoc.exe'
      ]
      found = candidates.find { |p| File.exist?(p) }
      return found if found

      # 4) Fallback nil -> caller shows helpful message
      nil
    end

    def fallback_pre(content)
      # Escape safely without relying on Jekyll::Utils (not available in 3.9)
      "<pre>#{CGI.escapeHTML(content.to_s)}</pre>"
    end
  end
end
