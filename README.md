# fqlib - Illumina-based FastQ library written for performance.

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fstjude%2Ffqlib.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fstjude%2Ffqlib?ref=badge_shield)

| **Branch**  | **Version** | **Unix CI**                                                              | **Windows CI**                                                             | **Coverage**                                                                  |
| ----------- | ----------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| Master      | v1.0.2      | [![Build Status][travis-master-ci-svg]][travis-master-ci-link]           | N/A                                                                        | N/A                                                                           |
| Development | v1.0.3      | [![Build Status][travis-development-ci-svg]][travis-development-ci-link] | N/A                                                                        | N/A                                                                           |

A package written in Python for manipulating Illumina generated FastQ files. This code
is based on best practices developed and maintained at St. Jude Children's Research
Hospital. We only consider files which meet the following criteria:

* FastQ files (no support for Fasta)
* Illumina generated
* "Lazy" FastQ file structure (4 lines per read)

Anyone is welcome to contribute code or create issues.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

If you are only interested in the command line tools, you can run the following
commands to get access to them:

```bash
pip install fqlib
fqlint
```

### Prerequisites

* Insure that Python 3.6+ is installed on your machine. `fqlib` may work with earlier versions of Python, but that would be coincidental.

### Installing

To get a full install of `fqlib` on your machine, you can run the following commands:

```bash
git clone https://github.com/stjude/fqlib.git
cd fqlib
pip install -r requirements.txt
make install
```

## Development

You can get a development version of the package and link it into your local Python installation like so:

```bash
git clone -b development https://github.com/stjude/fqlib.git
cd fqlib
pip install -r requirements.txt
make develop
```

### Running the tests

You can run the tests by running the following command. We are actively improving the test coverage.

```
make tests
```

## Command Line Tools 

* `fqlint`: Lints FastQ files and reports errors in the fashion you specify in on the command line.
* `fqgen`: Generates a mock Illumina-generated FastQ file. 
  * _Note_: these only meant to emulate the FastQ format! These reads will not align to any genome (at least, on purpose).

## Contributing

All contributions should be submitted to Github in the style of [Github Flow](https://guides.github.com/introduction/flow/index.html). All code must conform to
our [YAPF style configuration](.style.yapf) and must pass with pylint (you can see
our configuration [here](.pylintrc)). We recommend using [Visual Studio Code](https://code.visualstudio.com/) when coding for this project.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/stjude/fqlib/tags).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

[travis-master-ci-link]: https://travis-ci.org/stjude/fqlib
[travis-master-ci-svg]: https://travis-ci.org/stjude/fqlib.svg?branch=master
[maintainability-master-link]: https://codeclimate.com/github/stjude/fqlib/maintainability
[maintainability-master-svg]: https://api.codeclimate.com/v1/badges/ce7eed7d778bf50ac81a/maintainability
[coverage-master-link]: https://coveralls.io/github/stjude/fqlib?branch=master
[coverage-master-svg]: https://coveralls.io/repos/github/stjude/fqlib/badge.svg?branch=master
[travis-development-ci-link]: https://travis-ci.org/stjude/fqlib
[travis-development-ci-svg]: https://travis-ci.org/stjude/fqlib.svg?branch=development
[coverage-development-link]: https://coveralls.io/github/stjude/fqlib?branch=development
[coverage-development-svg]: https://coveralls.io/repos/github/stjude/fqlib/badge.svg?branch=development