
def restrict(html, starting_regexp, stopping_regexp)
  start = html.index(starting_regexp)
  stop = html.index(stopping_regexp, start)
  html[start..stop]
end

def scrape_title(html)
  %r{<b.*?>(.*?)</b\s*>}m =~ html # The m is to match on multiple lines
  clean_title($1)
end

def scrape_authors(html)
  author_anchor = %r{<a.*?href=".*?field-author-exact.*?".*?>(.+?)</a\s*>}m
  html.scan(author_anchor).flatten.collect do |author|
    clean_author(author)
  end
end

def scrape_book_info(html)
  retval = {}
  html = restrict(html,
                  /<div.+class\s*=\s*"buying".*?>\s*<b/,
                  %r{</div\s*})
  retval[:title] = scrape_title(html)
  retval[:authors] = scrape_authors(html)
  retval
end

def trip(url, steps=10)
  so_far = []

  steps.times do
    page = fetch(url)
    book_info = scrape_book_info(page)
    so_far << book_info[:title]
    puts format_output(book_info)

    next_book = scrape_affinity_list(page).find do |possible|
      not so_far.include?(possible[:title])
    end

    url = next_book[:url]
  end
end

def csv_string(book_info)
  title = book_info[:title]
  authors = book_info[:authors].join(', ')
  CSV.generate_line([title, authors])
end

if $0 == __FILE__

  if ARGV[0] == '-csv'
    FORMAT_STYLE = :csv_string
    ARGV.shift
  else
    FORMAT_STYLE = :normal_string
  end

  starting_isbn = ARGV[0] || '0974514055'
  trip(url_for(starting_isbn))
end

def format_output(book_info)
  self.send(FORMAT_STYLE, book_info)
end
