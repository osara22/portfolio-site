module ApplicationHelper
  require 'redcarpet'
  require 'coderay'

  # マークダウン形式 (redcarpet)
  def markdown(text)
    options = {
      filter_html: true, # htmlを出力しない
      hard_wrap: true, # マークダウン中の空行をhtmlに置き換える
      space_after_headers: true, # #と文字の間にスペースを要求する
    }

    extensions = {
      autolink: true, # <>に囲まれていなくてもリンクを認識する
      no_intra_emphasis: true, # 単語中の強調を認識しない
      fenced_code_blocks: true, # フェンスのあるコードブロックを認識
      strikethrough: true, # ~ が2つで取り消し線
      superscript: true, # ^ の後ろが上付き文字
      tables: true, # テーブルを認識
      underline: true, # 斜線を入れる (* *)
      highlight: true, # ハイライトを入れる (== ==)
      quote: true, # 引用符を入れる (" ")
      footnotes: true, # 脚注を入れる (^[1])

    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.split(':')[0]

      lang = case language.to_s
             when 'rb'         # rb も ruby　と認識させる
               'ruby'
             when 'yml'
               'yaml'
             when 'css'
               'css'
             when 'html'
               'html'
             when ''
               'md'
             else
               language
             end

      CodeRay.scan(code, lang).div
    end
  end
end
