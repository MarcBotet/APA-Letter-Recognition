Instruccions per executar el codi:

1- L'script split.R genera els dos subconjunts de train i test utilitzats en tots els altres scripts.

2- Per a cada model primer s'utilitza cross validation i despr�s d'utilitza el model per predir.
(no incluim els models guardats degut a que no es permeten arxius tan pesats al rac�)

3- Per als models que trigaven molt s'utilitza el package doParallel per paral�lelitzar i poder utilitzar el nombre de cores que es vulgui.
	 install.packages("doParallel", repos="http://R-Forge.R-project.org")
	 usat en : SVM_RBF.R, svmq.R, mlp.R
	 recomanem canviar el n�mero de cores utilitzats en funci� de cada ordinador

La resta s'executa de manera estandard de Rstutio.