# terraform-repl

terraform-repl is a terraform console wrapper that aims at providing a better interactive console for evaluating Terraform language expressions.

## Motivation

The standard terraform console has several limitations, including:

- No ability to view all objects
- No ability to define variables
- No ability to view command history
- No ability to clear screen

terraform-repl provides a solution to these problems.

## How it works

By default, terraform-repl starts a hashicorp/terraform docker container running terraform console, and uses this container to evaluate the expressions entered by the user.

## Usage

To start the REPL:

```bash
$ terraform-repl
Starting terraform console docker container...
>
```

Given the following `main.tf` file:

```terraform
locals {
  a = "foo"
  b = {"nums": [
    1,
    2
  ]}
}
```


To inspect the `locals`:

```bash
> local
[
  {
    "a": "foo",
    "b": {
      "nums": [
        1,
        2
      ]
    }
  }
]
```

To inspect one value:

```bash
> local.b.nums[0]
1
```

To create new variables:

```bash
> local.c="example"
> local.c
"example"
> local.d={"nums": \
[ 3, 4 ] \
}
> local.d
{
  "nums" = [
    3,
    4,
  ]
}
```

To view the command history:

```bash
> history
    1  local
    2  local.b.nums[0]
    3  local.c="example"
    4  local.c
    5  local.d={"nums": [ 3, 4 ] }
    6  local.d
    7  history
```

All terraform commands can be run as usual:

```bash
> > element(local.d.nums,0)
3
```

To clear the screen:

```bash
> clear
```

To exit:

```bash
> exit
```

## Prerequisites

- [jq](https://github.com/stedolan/jq)
- [hcl2json](https://github.com/tmccombs/hcl2json)
- [docker*](https://docs.docker.com/desktop/install/linux-install/)
- socat*

* optional, although highly recommended

## Installation

```bash
$ curl -O https://raw.githubusercontent.com/paololazzari/terraform-repl/master/terraform-repl
$ cp terraform-repl /usr/local/bin/
```