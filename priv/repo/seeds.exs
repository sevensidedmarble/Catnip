# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cat.Repo.insert!(%Cat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

user = Cat.Repo.insert!(%Cat.Users.User{
  email: "demo@example.com",
  password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("demo")
})

urls = [
  "http://news.google.com/news?cf=all&hl=en&pz=1&ned=us&topic=h&num=3&output=rss",
  "http://feeds.feedburner.com/foxnews/latest",
  "http://feeds.abcnews.com/abcnews/topstories",
  "http://www.npr.org/rss/rss.php?id=1001",
  "http://www.cnet.com/rss/all/",
  "http://www.salon.com/feed/",
  "https://www.reddit.com/r/news/.rss",
  "http://feeds.nydailynews.com/nydnrss",
  "http://www.msnbc.com/feeds/latest",
  "http://www.mtv.com/news/feed/",
  "http://feeds.abcnews.com/abcnews/internationalheadlines",
  "https://www.reddit.com/r/worldnews/.rss",
  "https://www.theguardian.com/world/rss",
  "http://feeds.reuters.com/reuters/worldNews",
  "http://www.dailymail.co.uk/news/worldnews/index.rss",
  "http://www.express.co.uk/posts/rss/78/foreignnews",
  "http://feeds.huffingtonpost.com/huffingtonpost/raw_feed",
  "http://globalnews.ca/category/world/feed/",
  "http://www.usnews.com/rss/usnews",
  "http://www.usnews.com/rss/education/best-graduate-schools",
  "http://www.usnews.com/rss/us-news-information",
  "http://www.usnews.com/rss/education",
  "http://www.usnews.com/rss/education/best-graduate-schools/top-business-schools",
  "http://www.usnews.com/rss/education/online-education",
  "http://www.usnews.com/rss/education/best-graduate-schools/top-law-schools",
  "http://www.usnews.com/rss/education/best-graduate-schools/top-medical-schools",
  "http://www.usnews.com/rss/money",
  "http://www.usnews.com/rss/education/best-graduate-schools/top-education-schools",
  "http://feeds.reuters.com/reuters/businessNews",
  "http://www.cnbc.com/id/10000664/device/rss",
  "http://www.forbes.com/financing/feed2/",
  "http://www.ft.com/rss/home/us",
  "http://feedproxy.google.com/clusterstock?format=xml",
  "https://www.reddit.com/r/finance/.rss",
  "http://rss.cnn.com/rss/money_topstories.rss",
  "http://rss.cnn.com/rss/money_pf.rss",
  "http://www.oecd.org/finance/index.xml",
  "https://www.entrepreneur.com/topic/finance.rss",
  "http://feeds2.feedburner.com/businessinsider",
  "http://www.forbes.com/business/feed2/",
  "http://business.usa.gov/rss.xml",
  "http://www.nytimes.com/services/xml/rss/nyt/Business.xml",
  "http://time.com/business/feed/",
  "https://www.theguardian.com/us/business/rss",
  "http://www.latimes.com/business/rss2.0.xml",
  "http://rss.cnn.com/rss/money_latest.rss",
  "https://www.sba.gov/taxonomy/term/49/feed",
  "https://www.entrepreneur.com/topic/marketing.rss",
  "http://feeds.marketingland.com/mktingland",
  "http://feeds.feedburner.com/BDTermOfTheDay",
  "http://blog.hubspot.com/marketing/rss.xml",
  "http://contentmarketinginstitute.com/feed/",
  "http://rss.marketingprofs.com/marketingprofs/daily",
  "https://www.marketingweek.com/feed/",
  "http://feeds.mashable.com/Mashable",
  "http://www.marketingdonut.co.uk/rss.xml",
  "http://www.forbes.com/sites/laurashin/feed/",
  "http://www.jumsoft.com/feed/",
  "https://www.theguardian.com/us/money/rss",
  "https://www.usa.gov/taxonomy/term/10863/feed",
  "https://www.usa.gov/taxonomy/term/10854/feed",
  "https://xkcd.com/atom.xml",
  "http://www.thefreedictionary.com/_/WoD/rss.aspx",
  "http://www.mrmoneymustache.com/feed/",
  "http://www.forbes.com/stocks/feed2/",
  "http://articlefeeds.nasdaq.com/nasdaq/categories?category=Stocks",
  "http://www.investors.com/category/market-trend/stock-market-today/feed/",
  "http://www.timothysykes.com/feed/",
  "https://www.reddit.com/r/stocks/.rss",
  "https://foxonstocks.com/feed",
  "https://www.nytimes.com/svc/collections/v1/publish/http://www.nytimes.com/topic/subject/stocks-and-bonds/rss.xml",
  "http://economictimes.indiatimes.com/rssfeeds/2146842.cms",
  "http://economictimes.indiatimes.com/rssfeeds/2146843.cms",
  "http://www.forbes.com/economics-finance/feed2/",
  "http://economics.gmu.edu/feed",
  "https://www.theguardian.com/business/economics/rss",
  "https://economics.uchicago.edu/rss.xml",
  "http://econ.columbia.edu/events/feed",
  "http://rss.sciencedirect.com/publication/science/271682",
  "http://www.cnbc.com/id/20910258/device/rss",
  "https://economics.indiana.edu/",
  "https://www.umass.edu/economics/rss.xml",
  "https://www.reddit.com/r/Economics/.rss",
  "http://feeds2.feedburner.com/slashfilm",
  "https://www.sxsw.com/feed/",
  "https://www.theguardian.com/us/film/rss",
  "http://variety.com/feed/",
  "http://deadline.com/feed/",
  "https://tribecafilm.com/feed.xml",
  "http://www.filmcomment.com/feed/",
  "http://www.independent.co.uk/arts-entertainment/films/rss",
  "http://www.movies.com/rss-feeds/movie-news-rss",
  "https://www.yahoo.com/movies/rss",
  "https://www.yahoo.com/movies/showtimes/rss",
  "https://www.nytimes.com/svc/collections/v1/publish/http://www.nytimes.com/section/movies/rss.xml",
  "https://www.reddit.com/r/movies/.rss",
  "http://www.digitaltrends.com/feed/",
  "https://www.pastemagazine.com/recent.xml",
  "http://feeds.feedburner.com/birthmoviesdeath",
  "http://archive.org/services/collection-rss.php?collection=moviesandfilms",
]

feeds = for url <- urls, reduce: [] do
  acc ->
    time = DateTime.utc_now() |> DateTime.truncate(:second)
    acc |> Enum.concat([
      %{
        url: url,
        inserted_at: time,
        updated_at: time,
      }
    ])
end

Ecto.Multi.new()
|> Ecto.Multi.insert_all(:insert_all, Cat.Feeds.Feed, feeds)
|> Cat.Repo.transaction()

for feed <- Cat.Repo.all(Cat.Feeds.Feed) do
  Cat.Repo.insert!(%Cat.Users.UserFeed{user_id: 1, feed_id: feed.id})
end
