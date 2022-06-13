# Infomatic

This is a little proof-of-concept plugin which generates plists that get embedded into the client target as resources.

See https://github.com/elegantchaos/InfomaticTest for an example command line tool which uses the plugin.

## .info Files

The plugin looks at the target's source files, and pulls out an `.info` files, which it uses to build plist files.

Each `.info` file is expected to define a dictionary of keys/values. The format of the `.info` file is flexible. Currently, it can be in JSON or PropertyList format.

If the file is called `Xxx.info`, it will be used to build an output file called `Xxx.plist`. Thus a single project can contain multiple property list files.  

Addionally, if an input file is called `Xxx-yyy.info`, the `-` and anything to the right of it are first stripped, so this file will _also_ be used to build an output file called `Xxx.plist`. In this case, where more than one input file is targetting the same output file, their contents will be merged. This allows large property list files to be split into multiple input files. The files are processed in alphabetical order. If duplicate keys are encountered, later values will overwrite earlier ones.
