%%
%Load Data
load ../data/data_with_bigrams.mat;
load count.mat;
load load.mat;
load negation.mat;

%%
%Train

Xb = make_sparse_bigram(train);
Y = double([train.rating]');
Xs = make_sparse(train, count);
X = make_sparse_new(train, vocab, count, values);

model0 = libsvmtrain(Y, X, '-s 0');
model0b = libsvmtrain(Y, Xb, '-s 0');
model1 = libsvmtrain(Y, X, '-s 1');
model1b = libsvmtrain(Y, Xb, '-s 1');
model2 = libsvmtrain(Y, X, '-s 2');
model2b = libsvmtrain(Y, Xb, '-s 2');
model3 = libsvmtrain(Y, X, '-s 3');
model3b = libsvmtrain(Y, Xb, '-s 3');
model4 = libsvmtrain(Y, Xs, '-s 4');
model4b = libsvmtrain(Y, Xb, '-s 4');
model5 = libsvmtrain(Y, X, '-s 5');
model5b = libsvmtrain(Y, Xb, '-s 5');
model6 = libsvmtrain(Y, X, '-s 6');
model6b = libsvmtrain(Y, Xb, '-s 6');
model7 = libsvmtrain(Y, Xs, '-s 7');
model7b = libsvmtrain(Y, Xb, '-s 7');

%%
%Test

Xbtest = make_sparse_bigram(test);
Xtest = make_sparse_new(test, vocab, count, values);
Ytest = zeros(size(Xtest,1),1);
Ye = emotion(test, values, negationvalue);

[Yhat0] = libsvmpredict(Ytest, Xtest, model0);
[Ybhat0] = libsvmpredict(Ytest, Xbtest, model0b);
[Yhat1] = libsvmpredict(Ytest, Xtest, model1);
[Ybhat1] = libsvmpredict(Ytest, Xbtest, model1b);
[Yhat2] = libsvmpredict(Ytest, Xtest, model2);
[Ybhat2] = libsvmpredict(Ytest, Xbtest, model2b);
[Yhat3] = libsvmpredict(Ytest, Xtest, model3);
[Ybhat3] = libsvmpredict(Ytest, Xbtest, model3b);
[Yhat4] = libsvmpredict(Ytest, Xtest, model4);
[Ybhat4] = libsvmpredict(Ytest, Xbtest, model4b);
[Yhat5] = libsvmpredict(Ytest, Xtest, model5);
[Ybhat5] = libsvmpredict(Ytest, Xbtest, model5b);
[Yhat6] = libsvmpredict(Ytest, Xtest, model6);
[Ybhat6] = libsvmpredict(Ytest, Xbtest, model6b);
[Yhat7] = libsvmpredict(Ytest, Xtest, model7);
[Ybhat7] = libsvmpredict(Ytest, Xbtest, model7b);

Yh = (3 * Yhat0 + 3 * Ybhat0 + Yhat1 + Ybhat1 + Yhat2 + Ybhat2 + Yhat3 + Ybhat3 + Yhat4 + Ybhat4 + Yhat5 + Ybhat5 + Yhat6 + Ybhat6 + 3 * Yhat7 + 3 * Ybhat7 + 3 * Ye) / 27;

save('-ascii', 'submit.txt', 'Yh');