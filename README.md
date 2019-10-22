# README
--------

[![Coverage Status](https://coveralls.io/repos/github/orbanbotond/ReactBikes/badge.svg?branch=master)](https://coveralls.io/github/orbanbotond/ReactBikes?branch=master)

[![CircleCI](https://circleci.com/gh/orbanbotond/ReactBikes.svg?style=svg)](https://circleci.com/gh/orbanbotond/ReactBikes)

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7ca05ca537e84d9f8273eeb15ab245c8)](https://www.codacy.com/manual/orbanbotond/ReactBikes?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=orbanbotond/ReactBikes&amp;utm_campaign=Badge_Grade)

This project is a study project which shows a clear background architecture with TRailblazer and some CRUD react example, with HOC's.


The background is architected using the Trailblazer architecture, where the operations encapsulate the business logic and the contracts validate the inputs.


It uses Rails 5.2
Trailblazer 2.1


The authorization is done via pundit, and the gateway toward the HTTP API is GRAPE with Swagger.


Everything is covered with Rspecs.

Operation Introspection:
Trailblazer::Operation.introspect(Memo::Create::Admin)
Trailblazer::Operation.introspect(Crud::Reservation::Operations::Create)
Trailblazer::Operation.introspect(Crud::Reservation::Operations::Update)
