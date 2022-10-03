# Papermerge Base Docker Image

Builds (and publishes) base docker image which includes Xapian libs.

Papermerge uses [Xapian](https://xapian.org/) as default search engine. The
only way I am aware how to include Xapian binary libs dependencies in
Dockerfile is by downloading and then compiling Xapian source code - however,
the compiling takes lots of time and slows down the CI process. In order to
speed up Papermerge CI - all Xapian libs are build into papermerge/base
(which itself if based on python3.9) in this repository and then -
papermerge/base is used (with Xapian libs included) for all other docker
images.
