# LibreTextConv
This utility converts OpenDocument Format (ODF) files to a text representation suitable for diffing in tools such as Git.

##Installation

The project builds to a [Chocolatey](https://chocolatey.org/) package which can then be installed the usual Chocolatey way.

###Prerequisites

* [Chocolatey](https://chocolatey.org/)

###Dependencies

* 7zip - declared as a Chocolatey dependency so will be installed automatically upon installation

###Building

1. Clone the repo
2. Run cpack - if successful a LibreTextConv.nupkg file will be built.

###Installing

From the repo directory run:

    choco install LibreTextConv -source '"$((Resolve-Path .).Path);https://chocolatey.org/api/v2/"'

This will install the command LibreTextConv which will then be available from any cmd/PS prompt. It will install 7zip if not already present.

To add the program as a driver for Git diffs do the following:

* Edit your .gitconfig file (stored at your HOMEDIR\.gitconfig to define a new diff method:

```
    [diff "odf"]
        textconv = LibreTextConv.bat
        cachetextconv = true
```

    ...the caching ensures the diff is not re-run if files have not been updated.

* Then add/edit your .gitattributes file, adding the line:

```
    *.ods	diff=odf
```

    ...to define that all files ending in .ods (i.e. spreadsheets) should use diff method "odf" we defined above. 

There are a number of locations where you could put a .gitattributes file depending on the scope at which you wish to apply the change. I would suggest changing your 'global' .gitattributes so it applies to all repos for your user. The location of this file is usually ~/.gitattributes. If you don't know where it is or you've never set one up check you config for the 'core.attributesfile' value:

    git config core.attributesfile

To set it use:

    git config --global core.attributesfile "~/.gitattributes"

For more information see the [gitattributes Manual Page (kernel.org)](https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html)

##Usage

    LibreTextConv [ODF FILENAME]

Given a filename the utility will turn any ODF document into a text representation and output it on STDOUT. Essentially it unzips the document and reads every file to STDOUT - it ignores images (*.PNG) at the moment.
