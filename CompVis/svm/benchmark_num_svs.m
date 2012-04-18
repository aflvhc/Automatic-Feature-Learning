%MATLAB FILE TO TEST THE FAST CLASSIFIER%
%Subhransu Maji (smaji@cs.berkeley.edu)
%Creates a random training and test data set. Expected error is
%close to 50%. Here however we are testing how close to the exact
%predictions do we get using the approximations.

clear all; clc;

%training data%
numtr = 100*[1:5];
numte = 5000;
dim = 100;

%test data%
ted = rand(numte,dim);
tel = (rand(numte,1) > 0.5)+1;


nbins = 300;
approx_str = sprintf('-m 1 -n %d',nbins);
nsv = zeros(size(numtr));

for i = 1:length(numtr)
  trd = rand(numtr(i),dim);
  trl = (rand(numtr(i),1) > 0.5)+1;

  %train model
  model  = svmtrain(trl,trd,'-s 0 -t 4');
  nsv(i) = model.totalSV;
  
  tic;
    [p,acc,dec] = svmpredict(tel,ted,model);
    svmtime(i)=toc;
    dec = single(dec);
    
  tic;
  approx_model = precomp_model(model,approx_str);
  exact_model  = precomp_model(model,'-m 0');
  ft(i,1) = toc;
  
  tic;
  fe = fiksvm_predict(tel,single(ted),exact_model,'-e 1');
  ft(i,2) = toc;
  
  tic;
  fpwc = fiksvm_predict(tel,single(ted),approx_model,'-e 0 -a 0');
  ft(i,3) = toc;
  tic;
    
  tic;
  fpwl = fiksvm_predict(tel,single(ted),approx_model,'-e 0 -a 1');
  ft(i,4) = toc;
  tic;

  err_e(i)   = mean(abs(dec-fe));
  err_pwc(i) = mean(abs(dec-fpwc));
  err_pwl(i) = mean(abs(dec-fpwl));
end
figure;
hold on;
plot(nsv,err_e,'--r*');
plot(nsv,err_pwc,'--g*');
plot(nsv,err_pwl,'--b*');
legend('exact (binary search)','approx (piecewise constant)',['approx (piecewise ' ...
                    'linear)'],'Location','NorthWest');
title('Mean Abs. Error in Approximation vs. Number of Support Vectors');

xlabel('Number of Support Vectors');
ylabel('Mean Error in Approximation');
grid on;box on;
set(gca,'XTick',nsv)

figure;
hold on;
plot(nsv,svmtime,'--m*');
plot(nsv,ft(:,1),'--k*');
plot(nsv,ft(:,2),'--r*');
plot(nsv,ft(:,3),'--g*');
plot(nsv,ft(:,4),'--b*');
legend('libsvm','precomp','exact (binary search)','approx (piecewise constant)',['approx (piecewise ' ...
                    'linear)'],'Location','NorthWest');

title('Classification Time(s) vs. Number of Support Vectors');
xlabel('Number of Support Vectors');
ylabel('Classification Time(s)');
grid on; box on;
set(gca,'XTick',nsv)
