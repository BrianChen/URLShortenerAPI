# URLShortenerAPI

URLShortenerAPI is a web service used to shorten urls and keep a record of visits to the shorten link.

## Set up

Install gems and start rails server on local machine

```ruby
bundle install
rails s
```

## Using URLShortenerAPI

### Create a shortened url via POST request

Request:
```
url: http://localhost:3000/api/shortened_urls
type: POST
body: {
  "original_url": "http://www.example.com"
}
```

You can specify an optional slug in the body. (ex. slug: "myWebsite")

Response:
```
{
  "original_url": "http://www.example.com",
  "short_url": "http://localhost:3000/431A3Y"
}
```

This can be tested using API tools such as Advanced REST client, Chrome's Postman, etc.

### Clicking on shortened url will bring you to original url

After making the post request above.  "http://localhost:3000/431A3Y" will bring you to http://www.example.com.

It will also record a visit to that page through the shortened link.

## Running Rspec Tests

Navigate to project directory and run:
```Ruby
rspec spec/
```

## Design and Implementation

### Database

#### shortened_urls
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
slug            | string    | not null, indexed, unique
original_url    | string    | not null, indexed
timestamps      | Date      | not null

#### visits
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
shortened_url_id| integer   | not null, indexed
visited_date    | Date      | not null

I made the decision to not split up original url and slug(shortened url) to different tables because when I fetch for a shortened url, the database would need to query the "original_url" table which would hinder performance.

Visits was recorded on a separate table because it is best practice to not change the field of database often (if visits column was added to shortened_urls table).

### Models
URLShortenerAPI contains two models: ShortenedUrl and Visit. A ShortenedUrl has multiple visit(s) and Visit belongs to one ShortenedUrl.

Model level validation was implemented to provided on top of database validation to ensure stability.

Class methods such as generate_slug, count_visit was implemented to help separate code.

### Controllers
API::ShortenedUrlController
GET#index - indexs all shortened urls
GET#show - redirects to the shortened url's original url
POST#create - creates a shortened url

The GET#show fetches the ShortenedUrl model from the database using the slug provided and redirects to the long url if the slug exists.  It will also record a visit and save it to the database.

The POST#create contains checks to make sure the original url is valid. Currently the check is to make sure http or https is provided.  I researched this and there is quite a few more things I can add to this, such as having correct domain name, or correct url syntax. If all checks pass it will create the new shortened url.

Another thing I wanted to point out is that I decided not to include a VisitController because it would only include a show (which shows the amount of visits for a certain shortened url). This would rely on another http request but for the scope of this project it was left out.

### Future Updates

This was definitely a fun project that I look to improve on. Future goals for this would be chrome extension and UI component that uses this API.

Things to keep in mind when scaling:
Database schema (isolating original urls)
User logins to have their own dashboard of their shortened urls (login for extra features)
