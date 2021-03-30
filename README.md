# CQF Measures

This implementation guide describes an approach to representing electronic Clinical Quality Measures (eCQMs) using the FHIR Clinical Reasoning Module and Clinical Quality Language (CQL) in the U.S. Realm. However, this Implementation Guide can be usable for multiple use cases across domains, and much of the content is likely to be usable outside the U.S. Realm.

Commits to this repository will automatically trigger a new build of the IG, which will then be published to the following location:

[http://build.fhir.org/ig/HL7/cqf-measures](http://build.fhir.org/ig/HL7/cqf-measures)

Build log is available here:
[http://ig-build.fhir.org.s3-website-us-east-1.amazonaws.com/logs/HL7/cqf-measures](http://ig-build.fhir.org.s3-website-us-east-1.amazonaws.com/logs/HL7/cqf-measures)

Full debugging information is available here:
[http://build.fhir.org/ig/HL7/cqf-measures/debug.tgz](http://build.fhir.org/ig/HL7/cqf-measures/debug.tgz)

## Local Build

The HL7 IG Publisher is committed to this repository to make building as easy as possible. To initially build locally, clone the repository and run the following commands the directions below in the root command:

  1. **_updatePublisher[.bat | .sh]** - <i>Process retrieves the current version of the IG publisher and stores it within the input-cache folder. The IG publisher is updated on a regular basis but this process does not have to be executed for every instance of the publication process.</i>

  2. **_genonce[.bat | .sh]** - <i>This initiates the publication process. Launching the .bat file (Windows) or .sh file (Unix/Mac) will launch HL7's IGPublisher program and build/publish the IG one time.</i>


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
