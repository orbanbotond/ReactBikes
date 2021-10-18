 README
--------

[![Coverage Status](https://coveralls.io/repos/github/orbanbotond/ReactBikes/badge.svg?branch=master)](https://coveralls.io/github/orbanbotond/ReactBikes?branch=master)

![Github Build](https://github.com/orbanbotond/ReactBikes/actions/workflows/main.yml/badge.svg)

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7ca05ca537e84d9f8273eeb15ab245c8)](https://www.codacy.com/manual/orbanbotond/ReactBikes?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=orbanbotond/ReactBikes&amp;utm_campaign=Badge_Grade)

This project is a study project for a Hypotheticall Bike Rental Scenario

The background is architected using the Granite architecture (Trailblazer, see tag), where the actions encapsulate the business logic and the input validation.

---
 Use Cases
==========

![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/add-diagrams/diagrams/use_cases.puml)

User Activity
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/add-diagrams/diagrams/user_activity.puml)

Entity Relationship
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/add-diagrams/diagrams/entity_relationship.puml)

Backend Architecture
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/add-diagrams/diagrams/back_end_architecture.puml)

Frontend Architecture
=============
![alt text](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/orbanbotond/ReactBikes/add-diagrams/diagrams/front_end_architecture.puml)


The authorization is done via pundit, and the gateway toward the HTTP API is GRAPE with Swagger.

Everything is covered with Rspecs.
