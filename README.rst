

Build
=====

docker build -t registry.netresearch.de/blugento/support/composer-resource .
docker push registry.netresearch.de/blugento/support/composer-resource

Debug
=====

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
