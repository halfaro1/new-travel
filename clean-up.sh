mv class-pins.topojson class-pins
  if [ ! -f *.topojson ]; then
    echo ":frown: there are no new topojson files!"
    mv class-pins class-pins.topojson
    git checkout master
    git branch -d cleanup-and-merge
    exit
  else
    echo ":tada: I found new files, combining and pushing now!"
    geojson-merge *.topojson class-pins > class-pins.topojson
    rm class-pins
    mv class-pins.topojson class-pins
    rm *.topojson
    mv class-pins class-pins.topojson
    git add -A
    git commit -m "clean up class files"
    git push -u origin cleanup-and-merge
    echo "All done. Please go create the PR and merge if tests are passing!"
  fi
