for f in *
do
	if [ -d ${f} ]	#only run if it is a directory
	then
		cd "$f"
		TMalign *_model.pdb native.pdb > $x.tmalign
	fi
done