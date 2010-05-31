# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

LogicalForm.delete_all()

lf = LogicalForm.create(:key => 'g_suite#1',
  :data => '<?xml version="1.0" encoding="UTF-8"?>
<alpino_adt version="1.1">
  <node begin="0" cat="top" end="3" id="0" rel="top">
    <node begin="0" cat="np" end="3" id="1" rel="--">
      <node begin="0" end="1" id="2" pos="det" rel="det" root="de" word="de"/>
      <node begin="1" end="2" id="3" pos="adj" rel="mod" root="goed" word="goede"/>
      <node begin="2" end="3" id="4" pos="noun" rel="hd" root="advies" word="adviezen"/>
    </node>
  </node>
  <sentence>de goede adviezen</sentence>
</alpino_adt>',
  :pdf => 'JVBERi0xLjQKJaqrrK0KNCAwIG9iago8PAovUHJvZHVjZXIgKEFwYWNoZSBGT1AgVmVyc2lv
  biAxLjBiZXRhMjogUERGIFRyYW5zY29kZXIgZm9yIEJhdGlrKQovQ3JlYXRpb25EYXRlIChE
  OjIwMTAwNTE4MTEzNjQ2KzAyJzAwJykKPj4KZW5kb2JqCjYgMCBvYmoKPDwgL0xlbmd0aCA3
  IDAgUgovRmlsdGVyIC9GbGF0ZURlY29kZSAKPj4Kc3RyZWFtCnic1V1LriWxbZ33KnoDLpR+
  VdIKAgTIIMggCwjgGMHrABkFb/fhkUTysO69zvTZho3XYlXpR5GH1JFu+n3Kf/+S5P/Kef7+
  jz+/zuNus9D+mIW57sL9hxT+z6901N7P0UqaZfTPfI8jXdfV+1XX039J/T6uU/5z4ek/v0bJ
  RxljXKV0KfiKBSlllIW33pWh4G+//v3Xf/86f//Tr9zzkdsoVx/ShOvI+WpXblIbJP3qdy1j
  Ng6tFMGXCNJxSvmAoJ9HkQIR4JlL/qqx+PtXvu+j9Lqq4OevIyX//nWmWTNeqEeX2tJsUz/6
  jafrUcquVD54jVRPfbwcPaeuXWjnvSvg8nzc6RzlfnmjdRnD+Snp2i1zKM1Lf1/Qjv2pr8en
  PglqP0a18ZMunelOPVWRXEfdPXlIwsd4lj4LQoP5U58EMiof2iXDPUe9H7mMXu4L/2jH1o7v
  +XC98p6PduiQS0evq54yl3Muzt5szMdR77OcV52S3SAoRJUJexR/Ty1L6Gd6PP9eX79Fp3MX
  vZHBbPjWdR+t1Qu68+chOY+r7o/142q78iZauhV2JNf8Vo/9mTxkrtCfOaRW/P2rnOm40svz
  5ZRKZeDa/vpIpuHl7Ecqe0lc6RBlqWW+wuX3kc/dpCCQWTu3jstwylKQluVrrZH7wgzuZsl8
  tbTqlyXTVu3lzEcd0q41R+M4fczHOKQXty7h+XzothauQbKJsGdlQM9y3Wk1Rzrga46nAGtj
  KcanOVvzKSaxin0r42U+SSLDUcr+GhpVdlsxGqn2uusfRSyPWoP7OPcL1DkrXSOBMdWxW+WY
  aOnbVnr5vE9POe4hVe1FVdbcUKE0v5rFihKxTGMrjHxeZvZumBlR05q2ZDfoLGaZdNKiUvYw
  mdTh8AaNESqxBcejLY3aOvlpFjBDJZXjRBunboyj7Tr+RAlbrJKuY+Sy+v5ZIBararnYoJ73
  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
  2cBsdhp4qn6utrXmWjRvOt+PNdxy4xUjT0g/mgNiSjgwro7pKUkMNFg2SeerGs+INfqZdvys
  kB/g9FtgG8JIX7t8PSz6abdvhncqHR9HRWRoMGSOboedjJ4CCmoy7w3KjFkCacr2FGcCB8Nv
  dWu1xaxHpw3Q+ZNFdOZ3LWMcD3OYbqx6jFc4XLmevh75ZE/vQVEvzqqoqePyOVH+y8pPWTFw
  2UBUV6c3zxqYkb9SOA12231baJx9K5z3b7hFx68WAEfFJrl4vlIk1+HMmcaHJpf262+nVkJF
  slhON6h4jfZc5kqiie60xDKp7DKZ/wc/dNuFCmVuZHN0cmVhbQplbmRvYmoKNSAwIG9iago8
  PCAvVHlwZSAvUGFnZQovUGFyZW50IDEgMCBSCi9NZWRpYUJveCBbIDAgMCAzMDAgMzAwIF0K
  L1RyaW1Cb3ggWyAwIDAgMzAwIDMwMCBdCi9CbGVlZEJveCBbIDAgMCAzMDAgMzAwIF0KL1Jl
  c291cmNlcyAzIDAgUgovQ29udGVudHMgNiAwIFIKPj4KZW5kb2JqCjcgMCBvYmoKMTAxNDIK
  ZW5kb2JqCjEgMCBvYmoKPDwgL1R5cGUgL1BhZ2VzCi9Db3VudCAxCi9LaWRzIFs1IDAgUiBd
  ID4+CmVuZG9iagoyIDAgb2JqCjw8IC9UeXBlIC9DYXRhbG9nCiAvUGFnZXMgMSAwIFIKPj4K
  ZW5kb2JqCjMgMCBvYmoKPDwKL1Byb2NTZXQgWyAvUERGIC9JbWFnZUIgL0ltYWdlQyAvVGV4
  dCBdCj4+CmVuZG9iagp4cmVmCjAgOAowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMTA1Mzcg
  MDAwMDAgbiAKMDAwMDAxMDU5NSAwMDAwMCBuIAowMDAwMDEwNjQ1IDAwMDAwIG4gCjAwMDAw
  MDAwMTUgMDAwMDAgbiAKMDAwMDAxMDM1OSAwMDAwMCBuIAowMDAwMDAwMTQyIDAwMDAwIG4g
  CjAwMDAwMTA1MTYgMDAwMDAgbiAKdHJhaWxlcgo8PAovU2l6ZSA4Ci9Sb290IDIgMCBSCi9J
  bmZvIDQgMCBSCi9JRCBbPDRGRjI0MTA2MUNFNURERkI0MUQyNTUxQ0ZCOTdGRTU3PiA8NEZG
  MjQxMDYxQ0U1RERGQjQxRDI1NTFDRkI5N0ZFNTc+XQo+PgpzdGFydHhyZWYKMTA3MDYKJSVF
  T0YK')

Realization.create(:logical_form => lf, :sentence => 'de goede adviezen')