# Litmus Status Demo App

![Status Screenshot](https://www.dropbox.com/s/ryh414fd3ax19zc/litmus-status.png?dl=1)

It's not a whole lot to look at, but that's what's there.

## Tech

Using Rails 5.2, Ruby 2.5.1, PostgreSQL. Testing via RSpec, Capybara, FactoryGirl. Templates with Slim, CSS with Sass. Javascript with nothing added-- no need for big front-end libraries here.

## Calling the API

The API can be called with curl as in the following examples:

```
curl -X PUT -d 'status=DOWN' 'http://localhost:3000/api/v1/status_update/create'
curl -X PUT -d 'message=OH HAI!' 'http://localhost:3000/api/v1/status_update/create'
curl -X PUT -d 'message=WOOT!' -d 'status=UP' 'http://localhost:3000/api/v1/status_update/create'
```

(Note the last example which sets both the status and a message)


## Choices made & discussion

### Data Modeling

The biggest choice was how to model both status updates (up/down) and messages. I chose to use a single model to store both data points. While the spec only required knowing the most recent up/down status, it seemed like a good idea to be able to retain timestamp information for these changes, to enable historical tracking.

Even with storing multiple status updates, I still could have used multiple models/tables to store updates. This seemed a very reasonable way to go, and would have made the queries for displaying slightly less complex, since there is no need to filter out updates that don't contain information for the data type being retrieved. That said, I felt there was also value in clearly being able to associate a status and message that are set at the same time in one API call. (For example, you could add coloring or other info to the messages that had statuses also supplied with them) This would be possible with relations when using multiple models, but that is messy and potentially brittle.

Lastly, the status and the message feel like part of the same conceptual entity, or "Noun", to me. This is certainly debatable, but worth mentioning that consideration.

### Security / CSRF / Auth

The API Controller had CSRF protection removed, since we will be calling from the command-line. Typically this would be replaced with actual Authentication/Authorization controls, but this is out of spec.

## Other things of note

I popped in a little JavaScript to put a timestamp's locally translated time into the `<time>` tag's `title` attribute, giving an easy mouseover effect. This could potentially be used in other ways if this were actually going to get some styling/UX love.

I didn't make page objects for feature specs like I might for a 'real' project, both for time and 'overdoing it for this size project' reasons.
