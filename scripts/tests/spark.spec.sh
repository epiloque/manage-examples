#!/usr/bin/env bash
# shellcheck disable=SC2016,SC1090

source "${MANAGE_DIRECTORY}/bin/manage"

MANAGE_UNDERSCORE \
    spark/spark

MANAGE_BOOTSTRAP

expectSuccess 'it graphs argv data' '
  graph="$(_ spark 1,5,22,13,5)"

  test $graph = '▁▂█▅▂'
'

expectSuccess 'it charts spaced data' '
  data="0 30 55 80 33 150"
  graph="$(_ spark $data)"

  test $graph = '▁▂▃▄▂█'
'

expectSuccess 'it charts way spaced data' '
  data="0 30               55 80 33     150"
  graph="$(_ spark $data)"

  test $graph = '▁▂▃▄▂█'
'

expectSuccess 'it handles decimals' '
  data="5.5,20"
  graph="$(_ spark $data)"

  test $graph = '▁█'
'

expectSuccess 'it charts 100 lt 300' '
  data="1,2,3,4,100,5,10,20,50,300"
  graph="$(_ spark $data)"

  test $graph = '▁▁▁▁▃▁▁▁▂█'
'

expectSuccess 'it charts 50 lt 100' '
  data="1,50,100"
  graph="$(_ spark $data)"

  test $graph = '▁▄█'
'

expectSuccess 'it charts 4 lt 8' '
  data="2,4,8"
  graph="$(_ spark $data)"

  test $graph = '▁▃█'
'

expectSuccess 'it charts no tier 0' '
  data="1,2,3,4,5"
  graph="$(_ spark $data)"

  test $graph = '▁▂▄▆█'
'

expectSuccess 'it equalizes at midtier on same data' '
  data="1,1,1,1"
  graph="$(_ spark $data)"

  test $graph = '▅▅▅▅'
'
finish
