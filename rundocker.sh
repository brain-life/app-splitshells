
#mkdir input
scp -r karst.uits.iu.edu:/N/u/hayashis/Karst/testdata/app-splitshells/* input/

#mkdir output
#cp config.json output

docker run -it --rm \
    -v `pwd`/testdata:/input \
    -v `pwd`:/output \
    brainlife/splitshells

#docker run -it \
#    -v `pwd`:/output \
#    brainlife/splitshells
