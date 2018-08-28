# CQF Measures

This implementation guide provides measure content in support of the [Clinical Reasoning FHIR Connectathon track](http://wiki.hl7.org/index.php?title=201809_Clinical_Reasoning) for the Baltimore HL7 Work Group Meeting.

Commits to this repository will automatically trigger a new build of the IG, which will then be published to the following location:

[http://build.fhir.org/ig/cqframework/cqf-measures](http://build.fhir.org/ig/cqframework/cqf-measures)

Build log is available here:
[http://ig-build.fhir.org.s3-website-us-east-1.amazonaws.com/logs/cqframework/cqf-measures](http://ig-build.fhir.org.s3-website-us-east-1.amazonaws.com/logs/cqframework/cqf-measures)

Full debugging information is available here:
[http://build.fhir.org/ig/cqframework/cqf-measures/debug.tgz](http://build.fhir.org/ig/cqframework/cqf-measures/debug.tgz)

## Local Build

The HL7 IG Publisher is committed to this repository to make building as easy as possible. To build locally, clone the repository and issue the following command in the root:

    java -jar "org.hl7.fhir.igpublisher.jar" -ig ig.json

## Dependencies

Before the instructions in the above "Local Build" section will work, you
need to install several primary dependencies.

### Java

Go to [http://www.oracle.com/technetwork/java/javase/downloads/](
http://www.oracle.com/technetwork/java/javase/downloads/) and download the
latest (version 8 or higher) JDK for your platform, and install it.

### Ruby

Jekyll requires Ruby version 2.1 or greater.  Depending on your operating
system, you may already have Ruby bundled with it.  Otherwise, or if you
need a newer version, go to [https://www.ruby-lang.org/en/downloads/](
https://www.ruby-lang.org/en/downloads/) for directions.

### Jekyll

Go to [https://jekyllrb.com](https://jekyllrb.com) and follow the
instructions there, for example `gem install jekyll bundler`.  The end
result of this should be that the binary "jekyll" is now in your path.
