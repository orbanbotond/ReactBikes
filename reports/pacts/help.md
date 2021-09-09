# For assistance debugging failures

* The pact files have been stored locally in the following temp directory:
    /Users/orbanbotond/profession/ruby/hobby/ReactBikes/tmp/pacts

* The requests and responses are logged in the following log file:
    /Users/orbanbotond/profession/ruby/hobby/ReactBikes/log/pact.log

* Add BACKTRACE=true to the `rake pact:verify` command to see the full backtrace

* If the diff output is confusing, try using another diff formatter.
  The options are :unix, :embedded and :list

    Pact.configure do | config |
      config.diff_formatter = :embedded
    end

  See https://github.com/pact-foundation/pact-ruby/blob/master/documentation/configuration.md#diff_formatter for examples and more information.

* Check out https://github.com/pact-foundation/pact-ruby/wiki/Troubleshooting

* Ask a question on stackoverflow and tag it `pact-ruby`


Tried to retrieve diff with previous pact, but received error Pact::Hal::RelationNotFoundError Could not find relation 'pb:diff-previous-distinct' in resource at /Users/orbanbotond/profession/ruby/hobby/ReactBikes/spec/pacts/bikes_ui-bikes_graphql_query.json.