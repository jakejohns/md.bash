# md.bash

Some functions to generate [markdown][md] in bash.

## Why?

Because I often abuse bash and sometimes I want to output HTML. It's
easier to output markdown and pass it to [pandoc][pandoc].

## How?

```sh
$ source src/md.bash
$ { pwd | md_h1 ; for i in *; do printf '%s\n' "$(md_a "$i" <<< "${i%.*}")"; done | md_ul; } | pandoc -t html
```


[md]: https://daringfireball.net/projects/markdown/
[pandoc]: https://pandoc.org/
