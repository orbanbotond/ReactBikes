 README
--------

[![Coverage Status](https://coveralls.io/repos/github/orbanbotond/ReactBikes/badge.svg?branch=master)](https://coveralls.io/github/orbanbotond/ReactBikes?branch=master)

![Github Build](https://github.com/orbanbotond/ReactBikes/actions/workflows/main.yml/badge.svg)

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7ca05ca537e84d9f8273eeb15ab245c8)](https://www.codacy.com/manual/orbanbotond/ReactBikes?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=orbanbotond/ReactBikes&amp;utm_campaign=Badge_Grade)

This project is a study project for a Hypotheticall Bike Rental Scenario. 

---
 Use Cases
==========

![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/master/diagrams/use_cases.puml)

User Activity
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/master/diagrams/user_activity.puml)

Entity Relationship
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/master/diagrams/entity_relationship.puml)

Backend Architecture
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/master/diagrams/back_end_architecture.puml)

Frontend Architecture
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/master/diagrams/front_end_architecture.puml)

There are 2 API's for serving the frontend:
- [Legacy Grape](https://github.com/ruby-grape/grape) with [Swagger](https://github.com/ruby-grape/grape-swagger)
- [GraphQL](https://graphql-ruby.org)

There are 2 backend implementations:
- [Railsway Oriented using Trailbazer](https://github.com/orbanbotond/ReactBikes/tree/V1.15-trailblazer). [See Tag](https://github.com/orbanbotond/ReactBikes/tree/V1.15-trailblazer)
- [More Railish One using Granite](https://github.com/toptal/granite)

The project uses [github actions](https://github.com/features/actions) as CI:
- Unit tests
- API tests
- [Pact tests for testing the graphql Endpoints](https://docs.pact.io)
- rubocop
- eslint

The development was done in [TDD](https://en.wikipedia.org/wiki/Test-driven_development), except the UI, which was manually tested.
