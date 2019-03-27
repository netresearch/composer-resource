=================================================
Concourse CI composer dependency monitor resource
=================================================


----
Idea
----

- https://content.pivotal.io/blog/developing-a-custom-concourse-resource
- https://concoursetutorial.com/miscellaneous/docker-images/
- https://concourse-ci.org/implementing-resources.html

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

------------------
Setup the pipeline
------------------

login to concourse::

    fly -t box-blugento-support login -n blugento-support --concourse-url=https://ci.netresearch.de


set pipeline for app build::

    fly set-pipeline -t box-blugento-support -p composer-resource:test -c tests/pipeline.yml -n

debug jobs::

    fly -t box-blugento-support hijack -j base-community/test
