#!/usr/bin/env bash


#
# Utility
#

_md_oneline()   { tr -d '\n'; }
_md_attr()      { [[ "$1" ]] && printf '{%s}' "$1"; }
_md_prefix()    { sed "s/^/$1 /"; }
_md_block()     { printf '%s\n' "$1" "$(cat)" "$2"; }
_md_inline()    { printf '%s' "$1" "$(_md_oneline)" "$1"; }

_md_heading() {
    local lvl="$1"
    local attr="$2"
    [[ "$attr" ]] && attr=" $(_md_attr "$attr")"
    printf '%s %s%s\n' "$lvl" "$(_md_oneline)" "$attr"
}

_md_href()  {
    local pre=$1
    local href=$2
    local attr=$3
    printf '%s[%s](%s)%s' "$pre" "$(_md_oneline)" "$href" "$(_md_attr "$attr")";
}


#
# Multi line content
#
# Usage eg:
# $ cmd | md_div ".class"
#

md_bq()  { _md_prefix '>'; }
md_ie()  { _md_prefix '(@)'; }
md_ol()  { _md_prefix '#.'; }
md_pre() { _md_prefix '   '; }
md_ul()  { _md_prefix '-'; }

md_div()       { _md_block ":::{$1}" ":::"; }
md_raw_block() { _md_block "\`\`\`{=${1:-html}}" '```'; }


#
# Tables
#

md_tr() { printf '| ' ; printf '%s | ' "$@" ; printf '\n'; }

md_thead() {
    local i;
    md_tr "$@"
    for ((i=1;i<=$#;i++)); do printf '|---'; done
    printf '|\n'
}

md_tbody() {
    local row;
    while read -ra row; do
        md_tr "${row[@]}";
    done;
}

md_table() {
    [[ $# -eq 0 ]] || md_thead "$@"
    md_tbody
}

#
# Headings
#
# Usage eg:
# $ md_h1 "Title" ".class"
#

md_h1() { _md_heading "#" "$1"; }
md_h2() { _md_heading "##" "$1"; }
md_h3() { _md_heading "###" "$1"; }
md_h4() { _md_heading "####" "$1"; }
md_h5() { _md_heading "#####" "$1"; }
md_h6() { _md_heading "######" "$1"; }


#
# Inline
#

md_a()      { _md_href ""  "$1" "$2"; }
md_img()    { _md_href '!' "$1" "$2"; }
md_span()   { printf '[%s]{%s}' "$(_md_oneline)" "$1"; }


#
# Simple inline
#

md_em()     { _md_inline '*'; }
md_del()    { _md_inline '~~'; }
md_strong() { _md_inline '**'; }
md_sub()    { _md_inline '~'; }
md_sup()    { _md_inline '^'; }


#
# Other
#

md_hr() { printf '\n* * *\n\n'; }

