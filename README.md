Mahatma
=======

A tiny web app to allow visitors to add email address forwarding to a Gandi
domain.

### Requirements

 * Ruby 2.2.3
 * Rails 4.2
 * Postgres 9.1
 * Gandi API Key
 * Google Auth Key

### Setup

```bash
 $ git clone git@github.com:ollej/mahatma.git
 $ cd mahatma
 $ bundle install
 $ export GOOGLE_CLIENT_ID='XXXXXX.apps.googleusercontent.com'
 $ export GOOGLE_CLIENT_SECRET='<secret>'
 $ export GANDI_API_KEY="<gandi api key>"
 $ export GANDI_HOST="rpc.gandi.net"
 $ export GANDI_MAIL_DOMAIN="example.com"
 $ export GANDI_NAMESERVERS="a.dns.gandi.net b.dns.gandi.net c.dns.gandi.net"
 $ export GANDI_DOMAIN_API_KEY="<gandi api key>"
 $ export GANDI_DOMAIN_HOST="rpc.gandi.net"
 $ export GANDI_CONTACT="XXNNN-GANDI"
 $ export GANDI_CONTACT_OWNER="XXNNN-GANDI"
 $ export SECRET_TOKEN="`rails secret`"
 $ rails s
```
