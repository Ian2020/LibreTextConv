# LibreTextConv
This utility converts OpenDocument Format (ODF) files to a text representation suitable for diffing in tools such as Git.

##Installation

The project builds to a [Chocolatey](https://chocolatey.org/) package which can then be installed the usual Chocolatey way.

###Dependencies

* 7zip - declared as a Chocolatey dependency so will be installed automatically

###Building

1. Install [Chocolatey](https://chocolatey.org/)
2. Clone the repo
3. Run cpack inside the repo - if successful a LibreTextConv.nupkg file will be built.

###Installing

From the repo directory run:

    choco install LibreTextConv -source '"$((Resolve-Path .).Path);https://chocolatey.org/api/v2/"'

This will install the command LibreTextConv which will then be available from any cmd/PS prompt. It will install 7zip if not already present.

##Usage

    LibreTextConv [ODF FILENAME]

Given a filename the utility will turn any ODF document into a text representation and output it on STDOUT. Essentially it unzips the document and reads every file to STDOUT - it ignores images (*.PNG) at the moment.
