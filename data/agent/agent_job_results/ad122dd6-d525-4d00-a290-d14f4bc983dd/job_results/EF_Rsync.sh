#!/bin/bash

CWD=$(pwd)
read -e -p "Enter the folder where to save the Extracted Features files: [$CWD] " DEST
DEST=${DEST:-$CWD}

if [ ! -d "$DEST" ]; then
   read -e -p "Folder [$DEST] does not exist - create? [Y/n] " YN
   YN=${YN:-Y}
   case $YN in
      [yY][eE][sS]|[yY])
         mkdir -p "$DEST" || exit $?
         ;;
      *)
         echo "Aborting."
         exit 2
         ;;
   esac
fi

cat << 'EOF' | rsync -avh --no-perms --no-owner --stats --files-from=- data.analytics.hathitrust.org::features "$DEST"
uc1/pairtree_root/b4/10/24/90/b4102490/uc1.b4102490.json.bz2
njp/pairtree_root/32/10/10/64/28/34/74/32101064283474/njp.32101064283474.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/1f/j3/pn/6f/ark+=13960=t1fj3pn6f/nc01.ark+=13960=t1fj3pn6f.json.bz2
dul1/pairtree_root/ar/k+/=1/39/60/=t/6m/04/w7/3w/ark+=13960=t6m04w73w/dul1.ark+=13960=t6m04w73w.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/5w/67/jz/42/ark+=13960=t5w67jz42/nc01.ark+=13960=t5w67jz42.json.bz2
njp/pairtree_root/32/10/10/66/12/25/97/32101066122597/njp.32101066122597.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/75/t4/qt/9v/ark+=13960=t75t4qt9v/nc01.ark+=13960=t75t4qt9v.json.bz2
loc/pairtree_root/ar/k+/=1/39/60/=t/1z/c8/1g/1r/ark+=13960=t1zc81g1r/loc.ark+=13960=t1zc81g1r.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/7g/q6/rn/7k/ark+=13960=t7gq6rn7k/uc2.ark+=13960=t7gq6rn7k.json.bz2
loc/pairtree_root/ar/k+/=1/39/60/=t/2x/35/cw/4s/ark+=13960=t2x35cw4s/loc.ark+=13960=t2x35cw4s.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/86/h4/dt/08/ark+=13960=t86h4dt08/uc2.ark+=13960=t86h4dt08.json.bz2
wu/pairtree_root/89/08/82/97/71/8/89088297718/wu.89088297718.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/34/18/36/9h/ark+=13960=t3418369h/nc01.ark+=13960=t3418369h.json.bz2
mdp/pairtree_root/39/01/50/51/12/50/89/39015051125089/mdp.39015051125089.json.bz2
uc1/pairtree_root/b4/71/94/25/b4719425/uc1.b4719425.json.bz2
uva/pairtree_root/x0/00/13/47/49/x000134749/uva.x000134749.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/5x/63/bg/3m/ark+=13960=t5x63bg3m/uc2.ark+=13960=t5x63bg3m.json.bz2
uc1/pairtree_root/$b/80/72/93/$b807293/uc1.$b807293.json.bz2
uva/pairtree_root/x0/02/01/58/43/x002015843/uva.x002015843.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/7d/r2/rd/9m/ark+=13960=t7dr2rd9m/uc2.ark+=13960=t7dr2rd9m.json.bz2
uc1/pairtree_root/32/10/60/02/06/35/32/32106002063532/uc1.32106002063532.json.bz2
mdp/pairtree_root/39/01/50/05/61/80/72/39015005618072/mdp.39015005618072.json.bz2
nnc2/pairtree_root/ar/k+/=1/39/60/=t/8t/b1/52/64/ark+=13960=t8tb15264/nnc2.ark+=13960=t8tb15264.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/9m/32/p5/24/ark+=13960=t9m32p524/uc2.ark+=13960=t9m32p524.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/90/87/bz/87/ark+=13960=t9087bz87/nc01.ark+=13960=t9087bz87.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/4b/n9/z4/48/ark+=13960=t4bn9z448/uc2.ark+=13960=t4bn9z448.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/4c/n7/06/3n/ark+=13960=t4cn7063n/uc2.ark+=13960=t4cn7063n.json.bz2
mdp/pairtree_root/39/01/50/30/04/16/13/39015030041613/mdp.39015030041613.json.bz2
uva/pairtree_root/x0/30/83/25/14/x030832514/uva.x030832514.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/1t/d9/p7/8b/ark+=13960=t1td9p78b/uc2.ark+=13960=t1td9p78b.json.bz2
inu/pairtree_root/30/00/01/05/00/01/49/30000105000149/inu.30000105000149.json.bz2
inu/pairtree_root/30/00/01/09/02/49/62/30000109024962/inu.30000109024962.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/9d/51/qz/1t/ark+=13960=t9d51qz1t/nc01.ark+=13960=t9d51qz1t.json.bz2
uva/pairtree_root/x0/04/27/42/78/x004274278/uva.x004274278.json.bz2
uc1/pairtree_root/b3/32/42/30/b3324230/uc1.b3324230.json.bz2
nyp/pairtree_root/33/43/30/74/87/36/17/33433074873617/nyp.33433074873617.json.bz2
uc1/pairtree_root/32/10/60/09/29/52/44/32106009295244/uc1.32106009295244.json.bz2
uc1/pairtree_root/b3/68/72/68/b3687268/uc1.b3687268.json.bz2
mdp/pairtree_root/39/01/50/33/91/11/76/39015033911176/mdp.39015033911176.json.bz2
loc/pairtree_root/ar/k+/=1/39/60/=t/08/w4/9p/1x/ark+=13960=t08w49p1x/loc.ark+=13960=t08w49p1x.json.bz2
nyp/pairtree_root/33/43/30/81/88/30/05/33433081883005/nyp.33433081883005.json.bz2
loc/pairtree_root/ar/k+/=1/39/60/=t/34/17/vk/95/ark+=13960=t3417vk95/loc.ark+=13960=t3417vk95.json.bz2
hvd/pairtree_root/hw/3e/5e/hw3e5e/hvd.hw3e5e.json.bz2
uc1/pairtree_root/b7/98/79/1/b798791/uc1.b798791.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/50/g4/wj/3w/ark+=13960=t50g4wj3w/nc01.ark+=13960=t50g4wj3w.json.bz2
mdp/pairtree_root/39/01/50/59/47/55/36/39015059475536/mdp.39015059475536.json.bz2
inu/pairtree_root/30/00/00/54/47/29/76/30000054472976/inu.30000054472976.json.bz2
inu/pairtree_root/30/00/01/27/83/07/70/30000127830770/inu.30000127830770.json.bz2
uva/pairtree_root/x0/01/57/88/51/x001578851/uva.x001578851.json.bz2
mdp/pairtree_root/39/01/50/04/28/80/42/39015004288042/mdp.39015004288042.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/30/28/pw/46/ark+=13960=t3028pw46/uc2.ark+=13960=t3028pw46.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/1v/d6/p9/9w/ark+=13960=t1vd6p99w/uc2.ark+=13960=t1vd6p99w.json.bz2
uc1/pairtree_root/b3/32/51/63/b3325163/uc1.b3325163.json.bz2
nyp/pairtree_root/33/43/30/76/06/92/14/33433076069214/nyp.33433076069214.json.bz2
uc1/pairtree_root/b2/49/72/3/b249723/uc1.b249723.json.bz2
nyp/pairtree_root/33/43/30/76/03/27/25/33433076032725/nyp.33433076032725.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/2s/47/rp/50/ark+=13960=t2s47rp50/nc01.ark+=13960=t2s47rp50.json.bz2
miun/pairtree_root/ac/r4/28/9,/00/01/,0/01/acr4289,0001,001/miun.acr4289,0001,001.json.bz2
uva/pairtree_root/x0/00/55/06/58/x000550658/uva.x000550658.json.bz2
njp/pairtree_root/32/10/10/68/15/01/74/32101068150174/njp.32101068150174.json.bz2
nyp/pairtree_root/33/43/30/76/08/92/04/33433076089204/nyp.33433076089204.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/5n/87/97/0b/ark+=13960=t5n87970b/nc01.ark+=13960=t5n87970b.json.bz2
njp/pairtree_root/32/10/10/73/47/59/47/32101073475947/njp.32101073475947.json.bz2
nyp/pairtree_root/33/43/30/74/78/82/94/33433074788294/nyp.33433074788294.json.bz2
mdp/pairtree_root/39/01/50/09/77/24/46/39015009772446/mdp.39015009772446.json.bz2
hvd/pairtree_root/hn/l3/3i/hnl33i/hvd.hnl33i.json.bz2
njp/pairtree_root/32/10/10/19/67/98/91/32101019679891/njp.32101019679891.json.bz2
nc01/pairtree_root/ar/k+/=1/39/60/=t/7j/q1/0k/79/ark+=13960=t7jq10k79/nc01.ark+=13960=t7jq10k79.json.bz2
uc1/pairtree_root/b4/10/51/39/b4105139/uc1.b4105139.json.bz2
uva/pairtree_root/x0/02/04/28/61/x002042861/uva.x002042861.json.bz2
mdp/pairtree_root/39/01/50/63/61/75/29/39015063617529/mdp.39015063617529.json.bz2
pst/pairtree_root/00/00/05/97/78/88/000005977888/pst.000005977888.json.bz2
nyp/pairtree_root/33/43/30/74/94/10/26/33433074941026/nyp.33433074941026.json.bz2
mdp/pairtree_root/39/01/50/04/83/07/85/39015004830785/mdp.39015004830785.json.bz2
uc1/pairtree_root/b3/14/46/96/b3144696/uc1.b3144696.json.bz2
miun/pairtree_root/af/j9/00/3,/00/01/,0/01/afj9003,0001,001/miun.afj9003,0001,001.json.bz2
loc/pairtree_root/ar/k+/=1/39/60/=t/6z/w1/qw/76/ark+=13960=t6zw1qw76/loc.ark+=13960=t6zw1qw76.json.bz2
nyp/pairtree_root/33/43/30/66/59/99/15/33433066599915/nyp.33433066599915.json.bz2
inu/pairtree_root/30/00/01/11/99/79/73/30000111997973/inu.30000111997973.json.bz2
dul1/pairtree_root/ar/k+/=1/39/60/=t/1c/j9/91/6g/ark+=13960=t1cj9916g/dul1.ark+=13960=t1cj9916g.json.bz2
uva/pairtree_root/x0/00/30/16/12/x000301612/uva.x000301612.json.bz2
uva/pairtree_root/x0/04/50/85/65/x004508565/uva.x004508565.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/0q/r4/pk/1s/ark+=13960=t0qr4pk1s/uc2.ark+=13960=t0qr4pk1s.json.bz2
inu/pairtree_root/30/00/00/53/31/96/57/30000053319657/inu.30000053319657.json.bz2
uc2/pairtree_root/ar/k+/=1/39/60/=t/3s/t7/fj/83/ark+=13960=t3st7fj83/uc2.ark+=13960=t3st7fj83.json.bz2
EOF