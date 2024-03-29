# terraform-repl

terraform-repl is a terraform console wrapper that aims at providing a better interactive console for evaluating Terraform language expressions.

## Motivation

The standard terraform console has several limitations, including:

- No tab completion
- No ability to view all objects
- No ability to define variables
- No ability to view command history
- No ability to clear screen
- No ability to run system commands

terraform-repl provides a solution to these problems.

## How it works

By default, terraform-repl evaluates each expression against a new terraform console process.

You can, however, choose to use a hashicorp/terraform docker container as a single background process to evaluate the expressions entered. This can be faster if working with terraform projects of a certain size. You can enable the container backend by using the `-docker-container-backend` option.

## Usage

### Starting the REPL

To start the REPL:

```bash
$ terraform-repl
>
```

or with the container backend:

```bash
$ terraform-repl -docker-container-backend
Starting terraform console docker container...
```

or starting the terraform-repl docker container:

```bash
$ docker run --rm -it -v "$(pwd)":/data plazzari/terraform-repl
>
```

### Using the REPL

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

All terraform functions can be run as usual:

```bash
> element(local.d.nums,0)
3
```

To run an external command, prepend the command with `!`:

```bash
> !grep "locals" main.tf
locals {
```

To clear the screen:

```bash
> clear
```

To exit:

```bash
> exit
```


### Tab completion

You can use the TAB key to get autocompletion for terraform functions:

```bash
> e<TAB>
endswith element
> el<TAB>
> element
```

as well as for `local` variables:

```bash
> local.<TAB>
local.a  local.b.nums[0]  local.b.nums[1]
```

this can be useful when you are working with many `local` variables.

### Transcript

When you start the REPL you may also specify the `-transcript` option. This will generate a transcript of all inputs and outputs of the session.
For the commands demonstrated above, the transcript file would be as follows:

<details>
    <summary>Sample transcript</summary>

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
    > local.b.nums[0]
    1
    > local.c="example"
    > local.c
    "example"
    > local.d={"nums": [ 3, 4 ] }
    > local.d
    {
      "nums" = [
        3,
        4,
      ]
    }
    > element(local.d.nums,0)
    3

</details>


## Prerequisites

- [jq](https://github.com/stedolan/jq)
- [hcl2json](https://github.com/tmccombs/hcl2json)
- [docker*](https://docs.docker.com/desktop/install/linux-install/)
- socat*

\* optional, although highly recommended

## Installation

```bash
$ curl -O https://raw.githubusercontent.com/paololazzari/terraform-repl/master/terraform-repl
$ cp terraform-repl /usr/local/bin/
$ chmod +x /usr/local/bin/terraform-repl
```
