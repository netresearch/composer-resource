=================================================
Concourse CI composer dependency monitor resource
=================================================


Docker image: https://hub.docker.com/r/netresearch/composer-resource

.. raw:: html

    <img src="https://www.drupal.org/files/styles/grid-3-2x/public/project-images/logo-composer-transparent3.png?itok=3wl5Mi6v" style="max-height:100px; text-align: left" alt="Concourse CI">

.. raw:: html

    <img src="https://concourse-ci.org/images/trademarks/concourse-black.png" style="max-height:100px; text-align: left" alt="Composer">

----
Idea
----

- https://content.pivotal.io/blog/developing-a-custom-concourse-resource
- https://concoursetutorial.com/miscellaneous/docker-images/
- https://concourse-ci.org/implementing-resources.html

Steps
-----

1. Install the project dependencies ``composer install``
2. Check for outdated ``composer outdated -D -m -f json --no-interaction --no-ansi``


Build
=====

.. code-block:: bash

    docker build -t registry.netresearch.de/blugento/support/composer-resource .
    docker push registry.netresearch.de/blugento/support/composer-resource

Debug
=====

.. code-block:: bash

    docker run -it registry.netresearch.de/blugento/support/composer-resource sh



Testing
=======

1. ``composer install -d /tests``
2. ``composer outdated -D -m -f json --no-interaction --no-ansi -d /tests``
2. ``composer update --dry-run -d /tests``


------------------
Setup the pipeline
------------------

login to concourse::

    fly -t box-blugento-support login -n blugento-support --concourse-url=https://ci.netresearch.de


set pipeline for app build::

    fly set-pipeline -t box-blugento-support -p composer-resource:test -c tests/pipeline.yml -n

debug jobs::

    fly -t box-blugento-support hijack -j base-community/test
